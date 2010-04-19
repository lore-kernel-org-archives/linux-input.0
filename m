From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: RFC: touch event clarification
Date: Mon, 19 Apr 2010 04:42:58 -0400
Message-ID: <4BCC1792.1020901@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.seas.upenn.edu ([158.130.12.194]:54645 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633Ab0DSInT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Apr 2010 04:43:19 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ping <pinglinux@gmail.com>, Rafi Rubin <rafi@seas.upenn.edu>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dmitry: would you care to clarify the meaning of the basic touch events?  It
might also be helpful to add more comments to input.h or add something to the
Documents directory.


My current understanding:
BTN_TOOL_FINGER: touch pad single finger
BTN_TOOL_(DOUBLE|TRIPLE|QUAD)TAP: touch pad 2,3 and 4 fingers
BTN_TOUCH: touch screen single finger
BTN_[0-N]: not really for fingers.


Are the taps at all appropriate for touch screens?  How should the wacom
non-screen tablets be treated, should they act like touch pads both for absolute
and relative modes?

Should there be any difference between pad and screen devices with respect to
multitouch events (currently, I'm assuming not)?


Thanks,
Rafi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkvMF48ACgkQwuRiAT9o60/5+ACg+JjfmgxYWNymySwDI9uTStaN
XrEAn2B/ZiP5j6BZyQ7IvgIg1hc16IRh
=928b
-----END PGP SIGNATURE-----
