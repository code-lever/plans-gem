require 'plans/command'

module Plans
  class Thumbs < Command

    def do(path)
      img_path = pathname(path) + 'img'

      unless img_path.exist?
        say 'Images directory (img) does not exist.'
        say "  #{img_path}"
        if (yes? 'Would you like to create the directory?')
          say 'Creating it.'
          FileUtils.mkdir img_path
        end
      end

      images = Dir.glob(img_path + '*.*')
      if (images.length == 0)
        say 'Nothing to do. No images found in img directory.', :green
        say "  #{img_path}"
        return
      end
      create_thumbnails(200, images, img_path)
      create_thumbnails(400, images, img_path)
      create_thumbnails(600, images, img_path)
      say 'Thumbnails creation complete.', :green
    end

    def create_thumbnails(size, images, path)
      target_directory = path + "#{size}px"
      FileUtils.remove_dir target_directory if Dir.exist? target_directory
      FileUtils.mkdir target_directory
      FileUtils.cp images, target_directory
      `mogrify -resize #{size} #{target_directory}/*.*`
      # Check mogrify's return code.
      if $?.to_i == 0
        say "Created #{images.length} #{size}px images."
      else
        say "Problem creating #{size}px images. (Mogrify ERR: #{$?.to_i})", :red
        say "  #{target_directory}"
        raise_error("Mogrify ERR: #{$?.to_i}")
      end
    end
  end
end

