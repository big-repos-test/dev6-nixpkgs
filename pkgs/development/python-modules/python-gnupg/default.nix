{ lib, buildPythonPackage, fetchPypi, gnupg }:

buildPythonPackage rec {
  pname = "python-gnupg";
  version = "0.5.0";

  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-cHWOOH/A4MS628s5T2GsvmizSXCo/tfg98iUaf4XkSo=";
  };

  postPatch = ''
    substituteInPlace gnupg.py \
      --replace "gpgbinary='gpg'" "gpgbinary='${gnupg}/bin/gpg'"
    substituteInPlace test_gnupg.py \
      --replace "os.environ.get('GPGBINARY', 'gpg')" "os.environ.get('GPGBINARY', '${gnupg}/bin/gpg')"
  '';

  pythonImportsCheck = [ "gnupg" ];

  meta = with lib; {
    description = "API for the GNU Privacy Guard (GnuPG)";
    homepage = "https://github.com/vsajip/python-gnupg";
    license = licenses.bsd3;
    maintainers = with maintainers; [ copumpkin ];
  };
}
