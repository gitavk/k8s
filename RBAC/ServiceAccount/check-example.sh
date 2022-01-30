#!/usr/bin/env sh
sa_name="system:serviceaccount:default:akuzmin1-sa"
for verb in get list watch; do
  echo -n $verb: && kubectl auth can-i $verb deployment --as=${sa_name}
done
