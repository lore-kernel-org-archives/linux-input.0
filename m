From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH] hid-ntrig.c: Single touch mode tap
Date: Tue, 16 Feb 2010 10:30:13 -0500
Message-ID: <4B7ABA05.7090209@seas.upenn.edu>
References: <1266333731-2166-1-git-send-email-rafi@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.seas.upenn.edu ([158.130.12.194]:40162 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755684Ab0BPPaX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Feb 2010 10:30:23 -0500
In-Reply-To: <1266333731-2166-1-git-send-email-rafi@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, dmitry.torokhov@gmail.com

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I just got some feedback from a user with a single touch firmware letting me
know he wasn't seeing the DOUBLETAP events after the previous patch set.

That was a side effect of dropping old mapping for confidence.  The confidence
mapping may be fine for st mode but causes problems in mt mode.

This seemed simpler than complicating the mapping further or messing with the
handling of HD_DG_CONFIDENCE.

Rafi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkt6ugMACgkQwuRiAT9o609YfgCdGYgDeu+UIGSUd6AJqJxMBR33
BbAAoJQvbBXKID3ukN5qjkqhzQ6n+iS0
=xLHv
-----END PGP SIGNATURE-----
