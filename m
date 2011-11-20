From: Felix Zweig <f.zweig@yahoo.de>
Subject: ALPS touchpad recognized as Generic Wheel Mouse
Date: Sun, 20 Nov 2011 21:03:23 +0100
Message-ID: <4EC95D0B.4070407@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nm1-vm1.bullet.mail.ne1.yahoo.com ([98.138.91.36]:30837 "HELO
	nm1-vm1.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752322Ab1KTUJy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Nov 2011 15:09:54 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The following refers to the same Touchpad as in bug #15893 (ALPS in an
Acer Aspire 532h).

The device is recognized as "ImPS/2 Generic Wheel Mouse as
/devices/platform/i8042/serio1/input/input5" instead of a touchpad; at
least since Linux 3.0 (and up to 3.2-rc2).

As one result, middle mouse button emulation doesn't work. IIRC, evdev
disabled it for non-touchpad inputs a while ago.

Is there a way to have the device recognized correctly as a touchpad (as
it used to be a few versions earlier, unfortunately I can't remember
which versions worked).

Regards,
Felix Zweig


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJOyV0LAAoJEPkIdpkG1yBb/8EH/1io1OFfpkvSDHF65niOcwk7
n7Sy7Ui+c/3WTusqdYl9cyQVoAy2UK3i9MmxWmhxw00vIl65sxZPBinrDJ8JNwnk
jSNhNSRVw1SLY7qtJ5o4bkg6mezOYYkNSOxlXKF+fRD29fbJnJc8ED3cibZVZFjp
Roj11DT8DjyR6xLOD6gT2CgLZcpsTUPdP2t0hjGKakNM0ZzDconEYFGetAmpeEgc
kkB6l0Fe+fntFBuaz3Ltah6I0l8bxlEnDEvcut5IUwrSJJgW7gJpZQjqen7O1O9E
Tab76U0QBSkvndLeRzRlubNYG7XpgucKifKmg+SD6Yjg5OViMViu3uPc4+i+p8I=
=wJyt
-----END PGP SIGNATURE-----
