{ python3, fetchFromGitHub }:
python3.pkgs.buildPythonApplication rec {
  pname = "superset";
  version = "3.0.0rc1";
  src = fetchFromGitHub {
    owner = "apache";
    repo = pname;
    rev = "refs/tags/${version}";
    hash = "sha256-XoUzZyAMYt8PP77OxjogGcNkj4wlpmq+vN9NKXLFb/U=";

  };

  propagatedBuildDepes = with python3.pkgs; [
        backoff # >=1.8.0
        cachelib # >=0.4.1,<0.5
        celery # >=5.2.2, <6.0.0
        click # >=8.0.3
        click-option-group
        colorama
        croniter #>=0.3.28
        cron-descriptor
        cryptography #>=39.0.1, <40
        deprecation# >=2.1.0, <2.2.0
        flask# >=2.2.5, <3.0.0
        flask-appbuilder# >=4.3.4, <5.0.0
        flask-caching# >=1.10.1, <2.0
        flask-compress#>=1.13, <2.0
        flask-talisman# >=1.0.0, <2.0
        flask-login# >=0.6.0, < 1.0
        flask-migrate#>=3.1.0, <4.0
        flask-wtf#>=1.1.0, <2.0
        func_timeout
        geopy
        gunicorn# >=20.1.0; sys_platform != 'win32'
        hashids# >=1.3.1, <2
        holidays# >=0.28, <1.0
        humanize
        importlib_metadata
        isodate
        Mako# >=1.2.2
        markdown# >=3.0
        msgpack# >=1.0.0, <1.1
        nh3# >=0.2.11, <0.3
        numpy# ==1.23.5
        packaging
        pandas# >=1.5.3, <1.6
        parsedatetime
        pgsanity
        polyline# >=2.0.0, <3.0
        pyparsing# >=3.0.6, <4
        python-dateutil
        python-dotenv
        python-geohash
        pyarrow# >=12.0.0, <13
        pyyaml# >=5.4
        PyJWT# >=2.4.0, <3.0
        redis# >=4.5.4, <5.0
        selenium# >=3.141.0, <4.10.0
        shortid
        sshtunnel# >=0.4.0, <0.5
        simplejson# >=3.15.0
        slack_sdk# >=3.19.0, <4
        sqlalchemy# >=1.4, <2
        sqlalchemy-utils# >=0.38.3, <0.39
        sqlparse# >=0.4.4, <0.5
        tabulate# >=0.8.9, <0.9
        typing-extensions# >=4, <5
         # waitress; sys_platform == 'win32'
        werkzeug# >=2.3.3, <3
        wtforms # >=2.3.3, <4
        wtforms-json
        xlsxwriter # >=3.0.7, <3.1
  ];
}

