From: Benson Leung <bleung@google.com>
Subject: Re: [PATCH] HID: usbhid: get/put around clearing needs_remote_wakeup
Date: Mon, 11 Sep 2017 16:29:07 -0700
Message-ID: <20170911232907.GA92445@decatoncale.mtv.corp.google.com>
References: <20170908174337.GA13616@dtor-ws>
 <1504942552.10395.2.camel@suse.com>
 <20170911200252.GB41615@decatoncale.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35182 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751014AbdIKX3M (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 11 Sep 2017 19:29:12 -0400
Received: by mail-pf0-f174.google.com with SMTP id q76so2543253pfq.2
        for <linux-input@vger.kernel.org>; Mon, 11 Sep 2017 16:29:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170911200252.GB41615@decatoncale.mtv.corp.google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, bleung@google.com


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Oliver,

On Mon, Sep 11, 2017 at 01:02:52PM -0700, Benson Leung wrote:
> Thanks for the pointer. I'll respin the patch with the no_resume version =
of
> usb_autopm_get_interface and retest.
>=20

I went and tried this patch but with usb_autopm_get_interface_no_resume ins=
tead
and the original bug I was trying to fix with a Yubikey hid security key ca=
me
back, so something is still wrong here.

I went ahead and filed a bug to track this here:
https://bugs.chromium.org/p/chromium/issues/detail?id=3D764112

I'll find some time to dig into this deeper and understand why this device
ends up getting stuck in active instead of suspending when all handles are
closed.

Thanks,
Benson

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJZtxxDAAoJEB8J9XsKL+ZYHekQAJRxJGFJgjh3VHZKUy9HG3fv
nF0NZP2o0TGM9PIQddaxWQ38K9GAR7bevjbMkhHKDVyKQXqL/dYOvxbhBfWdvqDx
2UPhhMqr1ebfllnc9QtePhw/M3Ff8sb2qLLxpS9sZIz4PCPbLDUXqaTqj6XcWJz/
1lEKNgDNub8JouhL35OhetA2JXNyre89h3cnb6hm8Uk1bRO2zVePOcZUAXUVgHzi
nufq/UUQG2I3xG5R4j566KLp2ogQLfNlcDCR2xVhv0hiC39uvkPt+4qjWpcrk1GG
tVuWyJa9kiGPIfWdHPlOc6538SaMdlkdOEEB58ahiq++RbD/O+LD9NvMD9X5PcWY
MKgAQJMJJoA0m+XU5ZkLwoxyY2S0dJYoAHoeULQsXSnJ/GVqSTnNnQ9lLc22fMeP
y/pLfcemrOHR5rPXWlgzjoAz7u2xh67XRzz0nBeoTmW0pOkgX/xeLoC1OzdE/xPb
9J1YDCJYpte8wgUYFU+L3ZoUCRlW13dClIHjFBMrPLm/bRBJco0RuGVnwd7n+fbp
24l6ipmsuErOISf735c7RIhs7q1CvBDiZ6FY6/heElHFXPN48MjOFX6la1d002ni
3n+05Z63gWWw56UOLf6ytptOyHKa6UPbLNdoc8aKAphMHn9LTaAFW9ZvxiDw3PZp
YwE5a2mOg1goiSlGSfvN
=UndD
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
