import os
import argparse


def proc_dir(dir_path, file_list=[]):
    print(dir_path)
    for file in os.listdir(dir_path):
        file_path = os.path.join(dir_path, file)
        if os.path.isdir(file_path):
            file_list = proc_dir(file_path, file_list)
        elif os.path.isfile(file_path) and file.endswith(".wav"):
            file_list.append(file_path[:-4])
    return file_list


def write_files(wav_files, training_file, validation_file=None, val_factor=None):
    for i, f in enumerate(wav_files):
        if validation_file is not None and val_factor is not None and i % val_factor == 0:
            validation_file.write(f + "\n")
        else:
            training_file.write(f + "\n")


def make_lists(ds_path, file_list_loc=None, val_size=0):
    if file_list_loc is None:
        file_list_loc = ds_path
    trn_file = os.path.join(file_list_loc, "training_list.txt")
    val_file = None
    files = proc_dir(ds_path)
    print(len(files))
    if val_size > 0:
        val_file = os.path.join(file_list_loc, "validation_list.txt")
        if val_size == 1:
            val_mod_factor = (len(files) - 1)//2 + 1
        else:
            val_mod_factor = (len(files) - 1)//val_size
    with open(trn_file, "w") as trn_out:
        if val_file is not None:
            with open(val_file, "w") as val_out:
                print("got validation file {}, {}".format(val_file, val_mod_factor))
                write_files(files, trn_out, val_out, val_mod_factor)
        else:
            write_files(files, trn_out)


if __name__ == "__main__":
    parser = argparse.ArgumentParser("generate filelists for training by recursing a path")
    parser.add_argument("--dataset_root", required=True, help="Root path to dataset")
    parser.add_argument("--filelist_dir", required=False,
                        help="Path to save filelists in defaults to dataset root", default=None)
    parser.add_argument("--val_sz", required=False, help="Number of files for validation list", default=0, type=int)

    args = parser.parse_args()

    make_lists(args.dataset_root, args.filelist_dir, args.val_sz)
