input = File.read("./in.txt")

def calc_at_most_100000(folder : Folder) : Int32
  size = folder.folders.sum {|x| calc_at_most_100000(x[1])}

  return folder.size + size if folder.size < 100_000
  size
end

class Folder
  getter parent
  getter name
  property folders
  property files

  def initialize(name : String, parent : Folder | Nil)
    @name = name
    @parent = parent
    @folders = Hash(String, Folder).new
    @files = Hash(String, Int32).new
  end

  def size : Int32
    @folders.sum { |x| x[1].size } + @files.sum { |x| x[1] }
  end
end

def generate_root_dir(input) : Folder
  root_dir = Folder.new("/", nil)
  current_dir = root_dir

  command_lines = input
    .split("\n")
    .map { |x| x.split(" ") }
    .skip(1)
    .each { |x|
      case x[0]
      when "$"
        case x[1]
        when "cd"
          case x[2]
          when ".."
            current_dir = current_dir.parent.as(Folder)
          else
            current_dir = current_dir.folders[x[2]]
          end
        end
      else
        case x[0]
        when "dir"
          current_dir.folders[x[1]] = Folder.new(x[1], current_dir) unless current_dir.folders[x[1]]?       
        else
          current_dir.files[x[1]] = x[0].to_i
        end
      end
    }

    root_dir
end

root_dir = generate_root_dir(input)
p1 = calc_at_most_100000(root_dir)

p p1

# part 2

def get_folder_sizes(folder : Folder): Array(Int32)
  sizes = folder.folders.flat_map {|x| get_folder_sizes(x[1]) }
  sizes.push(folder.size)
  sizes
end

def solve2(folder : Folder, needed_space : Int32) : Int32
  sizes = get_folder_sizes(folder)

  return sizes.select { |x| x >= needed_space}.min
end

total_space = 70_000_000
used_space = root_dir.size
update_space = 30_000_000

unused_space = total_space - used_space
needed_space = update_space - unused_space

p solve2(root_dir, needed_space)
