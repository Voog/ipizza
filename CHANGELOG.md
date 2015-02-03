## v2.0.0

* Added support for iPizza services (`1011`, `1012`, `4011` and `4012`). Read more form [Estonian Banking Association webpage](http://pangaliit.ee/et/arveldused/pangalingi-spetsifikatsioon)
* Changed MAC calculation in case of UTF-8 encoding to support new iPizza protocol.
* Added supported encodings to Provider model (`UTF-8` (default), `ISO-8859-1` and `WINDOWS-1257`).
* Added 'transaction_time' attribute to `Ipizza::Payment` object (parsed value of the `VK_T_DATETIME` field).
* Removed support for iPizza services (`1001`, `1002`, `4001` and `4002`).
* Added new provider: LHV Bank.
* Authentication request response method `authentication_info` returns now `Ipizza::Authentication` object instead of string.
