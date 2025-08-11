import argparse, json, os, sys, time, tempfile

def validate(data_path: str, output_file: str):
    os.makedirs(os.path.dirname(output_file), exist_ok=True)

    with open(data_path, "r", encoding="utf-8") as f:
        data = json.load(f)

    data["validated"] = True
    data["validated_at"] = int(time.time())

    fd, tmp_path = tempfile.mkstemp(dir=os.path.dirname(output_file),
                                    prefix=os.path.basename(output_file) + ".", suffix=".tmp")
    
    try:
        with os.fdopen(fd, "w", encoding="utf-8") as out:
            json.dump(data, out, ensure_ascii=False, indent=2)
            out.write("\n")
        os.replace(tmp_path, output_file)
        print(f"Validation complete. Report: {output_file}")
    except Exception:
        try:
            os.remove(tmp_path)
        except OSError:
            pass
        raise

def main():
    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers(dest="command", required=True)

    p_validate = subparsers.add_parser("validate")
    p_validate.add_argument("-dp", "--dataset-path", required=True)
    p_validate.add_argument("-o", "--output", required=True)

    args = parser.parse_args()

    if args.command == "validate":
        validate(args.dataset_path, args.output)

if __name__ == "__main__":
    sys.exit(main())
