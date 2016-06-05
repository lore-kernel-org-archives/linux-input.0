From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v7 0/4] i2c-smbus: add support for HOST NOTIFY
Date: Sun, 5 Jun 2016 09:13:28 +0200
Message-ID: <20160605071325.GB2722@katana>
References: <1464688985-19102-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1464688985-19102-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-doc-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Corey Minyard <minyard@acm.org>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Benjamin,

> this is mostly a resubmission of the v6 with the acks, tested-by and few typos
> here and there.

I actually reviewed v6 but got an NMI so writing the mails fell through
the cracks :( Sorry about that! Good news is that the code is fine from
my point of view, some documentation updates I'd request. After updating
those, I will pick up the core patches right away. Note that while the
i801 patch looks good to me, I need Jean's review here. There are other
patches pending for i801, that needs to be coordinated by him.

Thanks,

   Wolfram


--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXU9EUAAoJEBQN5MwUoCm2hBIP/j+w32sjOJ4o4YCjZ3pgl/wd
6lPpwHqxw2aNLwxCmZtzISbw6e7CK912nCoJDR/KKItrlrkmlQ6VBc7TkDK7EGfX
M6yUlhhPPJhyb3e0CphPh7ydvNZvm1qDzvPU+ezNTQ5AHd0A8FEYfjgnPrDzeWLv
aYvL2z/ePfysZ3W5maXhH0KkhTCpHJvhijvj6ddKrTpmZB8Ee4YzjCm5WwvQ1E9F
lD3Z6/jyZWI68e1eJdnbxLJLEtFWkvwpL4KCIB+4gzTBLlfFejL1fDnUDWNIVjG9
Z48dIAdLyD6MRZE4e5h7zm0zH5yA7hYzOwZ6RwKMiyDZvIemYAKrL4N2yQ69LqpJ
0XMYImQvC5ZsWQ9P0FFUm9bcGw/tgedBF8pvwieOPF7COqVOQRT7bLN9E1TerQEL
Hv5s3ln3n/+Cdw3s9Hpxt6YJ06AMC5tYJXO/mUhaA1OsAULWXxOnZYsMeXvM0Baj
lHftiaC8wQL0r8ltV4QyUk2C/49Yo4kCNdRfvo4FI3r4ev+uNns7Wq1bCgD9U/5t
NDuPf138nE1OND2qX3+WmBMJd6cgOkJIkouHn8jCYWGjaxIfy8I8yhhHWPpN1kqo
ys/jYHiYUtaXJwFyhsadgQeIananGhXilS6M0q1ayIfi6ESqPaZ4Pf/Yk4M6qBAa
L9DxGfNRVdWTMQYlw++H
=Q2fF
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--
