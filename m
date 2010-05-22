From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Lost events in older kernels
Date: Sat, 22 May 2010 03:06:07 -0400
Message-ID: <4BF7825F.2030405@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.seas.upenn.edu ([158.130.12.194]:33527 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034Ab0EVHGq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 22 May 2010 03:06:46 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'm playing with a project with a 2.6.29 kernel, and the userspace application
seems to miss some events.  Is there a particular fix that improved the handling?

Also tried catting the dev to a file while testing, and the dump also is missing
some events.

Rafi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkv3glkACgkQwuRiAT9o609vZACffkFSeTCDcNONThELFmUNx7Rk
LbQAn1Zzw0w1TcRn16hC8mBgpipF6ZL8
=F24i
-----END PGP SIGNATURE-----
