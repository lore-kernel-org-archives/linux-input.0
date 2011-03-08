From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH] hid: Do not create input devices for feature reports
Date: Mon, 07 Mar 2011 22:44:06 -0500
Message-ID: <4D75A606.8040104@seas.upenn.edu>
References: <1298572259-18173-1-git-send-email-rydberg@euromail.se> <alpine.LNX.2.00.1103011702240.32580@pobox.suse.cz> <AANLkTikd67q_j_ySam7RZvau8WoESLEmdXkfCWerVrLp@mail.gmail.com> <alpine.LNX.2.00.1103011726300.32580@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fox.seas.upenn.edu ([158.130.68.12]:42530 "EHLO
	fox.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887Ab1CHDoX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Mar 2011 22:44:23 -0500
In-Reply-To: <alpine.LNX.2.00.1103011726300.32580@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@enac.fr>, Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

A bit on the late side, I can confirm this reverts the annoying proliferation of
input nodes mapped for ntrig hardware.

The new firmwares seem to really enjoy exposing bugs, more on that later.

Rafi

On 03/01/11 11:26, Jiri Kosina wrote:
> On Tue, 1 Mar 2011, Benjamin Tissoires wrote:
> 
>> Tested-by: Benjamin Tissoires <benjmain.tissoires@gmail.com>
>> Acked-by: Benjamin Tissoires <benjmain.tissoires@gmail.com>
> 
> Applied, thanks.
> 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJNdaYCAAoJEPILXytRLnK214MP/RC61mIowTq/2o4oWp8JQvy3
l7zZumg3v/tInK7OS1XciWzMQl+zH09FfzutgAEULO7hGhN1RFiP8qiBHtuMrMVg
80FWXIl24SykGe/MwgQPi9esipTx6ee8W7hmIpFOfyVIZIl/F4afdPe3a9fFhuH+
0H5yn7+tUw5n7wglD57xkeDW4a3RD3ehf++ehZhmmwWoPKhr9119XN9UDAmHRBX4
1DfdtOTtsVA161DJkiMipEO5KoeD6dH1VMiCBhxkn+WLpVPHP6zhV/3KUhIDEFDd
oWMvldltbpe8UHQmh2KwiwrtJib0bLIrrmzS5EZkVm8bT2EFlM6ZsYt5tkp6NDwl
/bD1gBrMd14KGwVjb7XflfprlUHbbgpvjDUF7L5B3I955LWsowFoFqjquoV6+Phj
KOJRbUABvDa6esRpg79aAjD59Uh3adnmFydFFcHBHNc3Kb6ROJ4LVGlR1Zxt+QoT
rEXEYuxPZwxJ0zZ08yO2Si+FaoPVOrZC7S2XNhv64MMpISGBWEIvRWowDPjpgutY
v2aVdGiWskPsjqxjVXyR9MTqOgdXrp2JoZy2U2Jq7AV3vzwQfoJ+BJjgEAwkVmO3
XpKuxJ2s5vYPTlxPga3PqUPT2r7PzfjakTcXM4UQ3f7iQy4RZ4qr4q6+4aI3saVy
kvTrsCQV6SmmbbZuaFLh
=h0h3
-----END PGP SIGNATURE-----
