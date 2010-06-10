From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: in kernel contact tracking
Date: Wed, 09 Jun 2010 21:00:47 -0400
Message-ID: <4C10393F.40303@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.seas.upenn.edu ([158.130.12.194]:39998 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754869Ab0FJBCF (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Jun 2010 21:02:05 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>
Cc: Henrik Rydberg <rydberg@euromail.se>, Stephane Chatty <chatty@lii-enac.fr>, Ping <pinglinux@gmail.com>, Rafi Rubin <rafi@seas.upenn.edu>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Now that Henrik's slots seem to be coming along, I'd like to see what people
think about in kernel contact tracking.

I'd certainly like to see it available for hid-ntrig, but would rather see the
centralized code to make it available to all the devices lacking or with poor
tracking.

Any objection on general principles, or would this simply be a matter of getting
it right?


Cheers,
Rafi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkwQOTsACgkQwuRiAT9o60/ADQCeJMOK9sLcyN0CNcEeSFvEY1Xc
GFsAoLkC6PvzZjrQfWjQC1qcgmBExpjn
=y+qv
-----END PGP SIGNATURE-----
