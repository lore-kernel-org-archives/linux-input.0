From: Stephen Kitt <steve@sk2.org>
Subject: Release candidate of the linuxconsole tools (jscal etc.,
 inputattach, evtest)
Date: Mon, 4 Apr 2011 21:52:48 +0200
Message-ID: <20110404215248.7ec876b6@sk2.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA256;
 boundary="Sig_/jy5HUn6_mLqBA4OTTCNVxPT"; protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:57168 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754194Ab1DDTxF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 4 Apr 2011 15:53:05 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: rneri@libero.it

--Sig_/jy5HUn6_mLqBA4OTTCNVxPT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi everyone,

I'm pleased to announce that after many years without a packaged release, I=
'm
preparing an update to the venerable linuxconsole tools: the joystick
utilities (jscal, jstest, the various force-feedback tools), inputattach and
evtest.

The update is based on the Debian packages which I've maintained since 2008;
these include all the patches I've found concerning jscal, jstest and
inputattach, and a few which people have pointed out to me for evtest. I
would greatly appreciate it if interested parties could have a look at the
package and let me know if they have any comments or improvements!

The tarball is available at
https://sourceforge.net/projects/linuxconsole/files/

The user-visible changes since the last commonly-used snapshot (20051019) a=
re
as follows:

* inputattach has been cleaned up, and now supports the following new
  devices:
  - Sahara Touch-iT213
  - PS/2 multiplexers on TQM85xx boards
  - Zhen Hua PCM-4CH RC transmitters
  - TAOS evaluation modules
  - Wacom W8001
  - Microtouch, Touchright, Touchwindow, Penmount and Fujitsu
    touchscreens

* jscal tolerates greater jitter (so joysticks which don't send stable
  values can still be calibrated).

* jscal supports axis and button remapping.

* Various USB devices which caused jscal and/or jstest to segfault are
  now handled correctly.

* jscal-store and jscal-restore allow joystick calibration and
  remapping settings to be stored and restored.

* Documentation is provided, with manpages for all the provided
  utilities and sample udev rules.

The tools build with recent kernels, and probably older ones too. The only
requirement is the SDL development tools for the ffmvforce force-feedback
testing tool (the documentation fails to mention this so I guess that's the
first improvement needed!).

Regards,

Stephen

--Sig_/jy5HUn6_mLqBA4OTTCNVxPT
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJNmiGQAAoJEHWXeKmja0lPmO0P/2Nw7Cc63hJsJEs0gYd+9uMU
+FJTBowm7553ac6dttnnHUOaTl9KGHztUVQ8W6HXbV3qh8VePsDQFP0YGuWQ3Hy9
uco6HUuejXLqWuX2F/qsZ8Kwfu3ke1ETMjjk2VGXSiGOSFKAhb3HBv9NMIecqyAx
WpCj1ckzU812LAteCLdxYFwKo8+QkfKaqlaI+MfqFEGuyl7rmyl5Q911Fr2H8I2V
hdkbQuOK5Q12XK7tKToHA9JX7JlOEpfl9EVZxSd8C8+yX+Z3ggIR1RmnnEgdaY0G
OIzEC30PwY6dY/4bU/J7bOSO8aOO9uHG7zm75LxqmcdL+Fc9N3QTlZdoNPePwcxi
MoGFOv2U2POAl/RHNSK7+XNjUdmJbT5mSpiCSz0rYlZjuJ3WG3rmwQ/dsgnmE4Kz
doRLQZe5lWde906MKje6uqRbkEWq7+WeU4EKoAY7JvRkaOpMm7HPPd8Mok40SIVM
0DjFhBKXpDlTWAxFC3icuVVnE0SMbFjJpwy68coAUSQ2THxH3AO8T6ZAIK8VuMar
KN//OqaDB3W/6NnNbj2A4xeF4zFUKtRxJ+edsVwfRqduhQ0BuIpfpp9V/ash9Kya
x3A34ly+df5sqcBzdyxWuYVReQ1Qvad3GGFqBdQBHdc0zS4c2o8M1lf/WmTFHM36
Sbwz0fZMEYG1HlI9454C
=vctm
-----END PGP SIGNATURE-----

--Sig_/jy5HUn6_mLqBA4OTTCNVxPT--
