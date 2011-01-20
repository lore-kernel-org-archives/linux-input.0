From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: EVIOC mechanism for MT slots
Date: Thu, 20 Jan 2011 16:10:15 -0500
Message-ID: <4D38A4B7.7060901@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fox.seas.upenn.edu ([158.130.68.12]:51303 "EHLO
	fox.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754259Ab1ATVVp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Jan 2011 16:21:45 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>, Stephane Chatty <chatty@lii-enac.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosi>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, "X.Org Devel List" <xorg-devel@lists.freedesktop.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

We've come across a little problem with filtered MT events.  It seems there
isn't a mechanism to request the full state.  If a program opens a device
there's no way it can see static objects.

Consider for example a board game.  If the user puts the pieces on a MT surface
before starting the application, those pieces will not register and the state of
the game will be incorrect.

If there's opposition to this request, I suggest settling the dispute with a
game of MT battleship :-)

Rafi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJNOKS3AAoJEPILXytRLnK2HssP/0HfUm6pcvI6DyRu5xUzVWWd
THJ4lx9wytcxMkXucKugkai1l8lC60wUQeof1vE+T5TNWbQWPlA/dL+cmSGLCMkj
4JHXUg0p91I54oNwcRmkutxw+G9YOq45O4qHWaKUNVrxapaGnY74cnYlSDYo3Jec
OALRdV+flJAmdZPNhAuQAdSTn30QE4TSbcmIveYYy9WEsC1416Qx1zXFkNlaRrf/
ytKe+oKg3tlVzcQ+sSjEMimRGoMmNnGv5EQ0ZdFVFIOphuqLWoWv6nE1ziiFiwWL
bSoYN9vVjgBfUmhp+tOdxdKJMwARxoUiKsa/i2etyukJI5ULJ6s1I1oc3MQCw30m
CUoe6jTkW9MPpMdZIN7ip2RNmCoCg5wQKZTlw/gx20ZTYBlaY0msdcf81O78/HuJ
MqUqiCuI2ytnyKJQboOgfwmf6sau9BW4g36qkAdkITuunr653gCeHdTAMtETfAJ0
EVHyGC2jMI+X+rkBWL2I2Ax0r+Vvtvna/cuC+KrOBY0nIkr02ed3azeF0CJoblps
wr844XGgHsnus9nscSERLBVW4y0RvUt2AhX5JUChF4xM8zDTItY4CojCyg50Crc+
J/3c/8QUBhSHgnDXxN4YEdxLlz3/xf/u2qaf/dVnY5P5sh6y6WoxjhHhI3M19yLq
j26XxoED92WXFuz5Hv9s
=GrDk
-----END PGP SIGNATURE-----
