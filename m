From: Markus Kaindl <markus@markus-kaindl.de>
Subject: Synaptics: Missing pnpID for rmi-smbus
Date: Fri, 18 Aug 2017 04:52:48 +0200
Message-ID: <ff2d9143-0312-1d9d-73a0-d8f5ac719cbb@markus-kaindl.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="7CuLUxSP3bpjl0l6SqP8VAkoatFlQU6g9"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ama-dablam.eu ([37.120.171.8]:42052 "EHLO maila.ama-dablam.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753345AbdHRC6l (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 17 Aug 2017 22:58:41 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by maila.ama-dablam.eu (Postfix) with ESMTPSA id 2C2DB2046B
        for <linux-input@vger.kernel.org>; Fri, 18 Aug 2017 04:52:51 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7CuLUxSP3bpjl0l6SqP8VAkoatFlQU6g9
Content-Type: multipart/mixed; boundary="P9O5KEXljPCobvu7tl7S6VSDTjTcmuUfI";
 protected-headers="v1"
From: Markus Kaindl <markus@markus-kaindl.de>
To: linux-input@vger.kernel.org
Message-ID: <ff2d9143-0312-1d9d-73a0-d8f5ac719cbb@markus-kaindl.de>
Subject: Synaptics: Missing pnpID for rmi-smbus

--P9O5KEXljPCobvu7tl7S6VSDTjTcmuUfI
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Hi,

on my Thinkpad T460s my Kernel (4.12.8 built from gentoo-sources) told
me about my Touchpad supporting a different bus.
After building all the related modules, the message stayed, so I did as
the message told and set psmouse.synaptics_intertouch to 1, it then used
the rmi_smbus module.

Feel free to contact me, if you need more information.

Regards,
Markus

Aug 18 04:29:59 Lhotse kernel: psmouse serio1: synaptics: Your touchpad
(PNP: LEN004b PNP0f13) says it can support a different bus. If i2c-hid
and hid-rmi are not used, you might want to try setting
psmouse.synaptics_intertouch to 1 and report this to
linux-input@vger.kernel.org.


--P9O5KEXljPCobvu7tl7S6VSDTjTcmuUfI--

--7CuLUxSP3bpjl0l6SqP8VAkoatFlQU6g9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJMBAEBCgA2FiEECJ1cR+5OK7RID/8MqrLES8wH+KUFAlmWVoAYHG1hcmt1c0Bt
YXJrdXMta2FpbmRsLmRlAAoJEKqyxEvMB/ilT4QP/Ra0HXaz2lcUl1YZbiB/FeuE
RjofkRzmJ/j4BfSZejKCGFsfc94nZ83vH/qcp4kD4k4K59Rw49UI/GuZdTe152nn
xYsTwI10EtG7E9VW0i2v8M2LIyHf17A6+UhorYIjHKmhAXgKdM079TJz+hNDvm40
TC3zaQuo7blK+q7dn7VAVU1gFe+kcEY/fAX4APqQ+OS597sMYgcp+nmKoMCcl0DE
HjZPItzXuz8ema46ghlamWuy7A4SMwTwn51gZkOJexqJoN7T02RDfjFJIJFpDvRa
XHR24PABhIrMuYcTI4uOIsyYT3hyIYs6URf17C+LzJIDaHpyWatE3ac+k3HtbAGp
bgIA2YODXraNJGmeOLzO8EM6xGDKufzPN0pF+LLTeRqevL5WOjsDrY5p4VCzRHwi
L+aZ2idVBR9RokwPPAz1UxF/kGgjQJn6G42PYR1ST6Y9ITncFkkF+uy5OLDmJvKn
z8Jq5IkSXwPUVevp7RkzY2i7qL/2zCmbTS5M0WeSp1NrPio884A4UVGGz5xwOEP7
LcqGRMdTUZw+EIy0Cp9ki8rJ+a4wVjk4Hvm8SYIAszfJvnqHuZ9hAVByJu2gMYwF
2kk7jXSKtpD8Tdj3Y3R7FSQxYRJVqzAYVXGZI/h2uv5RJn+Ufc+xd3SvUBO4drS0
yw94OQWYEhTHWEQwcqCT
=w9jg
-----END PGP SIGNATURE-----

--7CuLUxSP3bpjl0l6SqP8VAkoatFlQU6g9--
