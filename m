From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH 4/4] hid-ntrig: Contact tracking
Date: Sat, 20 Feb 2010 12:48:41 -0500
Message-ID: <4B802079.8000006@seas.upenn.edu>
References: <1265933946-8318-1-git-send-email-rafi@seas.upenn.edu> 	<1265944448-23436-1-git-send-email-rafi@seas.upenn.edu> <1265944448-23436-2-git-send-email-rafi@seas.upenn.edu> 	<1265944448-23436-3-git-send-email-rafi@seas.upenn.edu> <1265944448-23436-4-git-send-email-rafi@seas.upenn.edu> <45cc95261002200025m378e1a80rec09bde5673a6060@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stag.seas.upenn.edu ([158.130.70.79]:42260 "EHLO
	stag.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756760Ab0BTRsz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 20 Feb 2010 12:48:55 -0500
In-Reply-To: <45cc95261002200025m378e1a80rec09bde5673a6060@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, jkosina@suse.cz, chatty@enac.fr

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/20/10 03:25, Mohamed Ikbel Boulabiar wrote:
> Hi,
> 
> What happens when two fingers approaches then separates ?

Given the way the hardware numbers the contacts and the way that code processes
them, the persistent id would go to the finger closer to the bottom of the
screen and the other one would get assigned an inactive id.

Similarly I think the lower finger would most likely determine the id of the
merged contact.  Not entirely certain.

Longer term tracking for a more satisfying and reliable tracking takes more
processing.  I think that's why the protocol doc suggests that userspace should
be responsible for hardware that doesn't track.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkuAIHkACgkQwuRiAT9o609k+QCcCHXx/DRuhEOWpcWaZrTLfubh
cPAAoL+TMEiNtil9hh/KX5oJIKejchNT
=oQbI
-----END PGP SIGNATURE-----
