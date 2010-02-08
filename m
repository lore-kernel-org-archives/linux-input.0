From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH] HID: Major update to N-Trig touchscreen
Date: Mon, 08 Feb 2010 11:45:32 -0500
Message-ID: <4B703FAC.5080008@seas.upenn.edu>
References: <1265418069-14240-1-git-send-email-rafi@seas.upenn.edu> <4B6CBFD3.8050700@seas.upenn.edu> <alpine.LNX.2.00.1002081648160.30967@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.SEAS.upenn.edu ([158.130.12.194]:46921 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753741Ab0BHQpo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Feb 2010 11:45:44 -0500
In-Reply-To: <alpine.LNX.2.00.1002081648160.30967@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Will do, sorry about the mess.

I've also been trying to learn more about the hid subsystem and found the rdesc parser.  I've discovered that the pen/stylus needs
no special handling.  So I should be able to remove all the old code for that.  I think I'd also better partition the changes
between cleanup of what's there and the additional functionality I'm adding.

Rafi

On 02/08/10 10:49, Jiri Kosina wrote:
> On Fri, 5 Feb 2010, Rafi Rubin wrote:
> 
>> I think something deep down inside of me is trying to expose the depths of my
>> stupidity, forcing me to make countless idiotic mistakes, like forgetting to
>> commit and read the patch before sending it....
>>
>> Really, very sorry about that.  I'd better step away from my computers for a
>> while.
> 
> Hi Rafi,
> 
> seems I got lost in the maze of multiple (re)submissions. Could you please 
> resubmit the latest version of the driver, or at least somehow mark the 
> one that you would like to be actually reviewed for merging? :)
> 
> Thanks,
> 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAktwP6gACgkQwuRiAT9o60/WHwCgmeqDyFPPJlJHJDJ+fYKlOsLP
PpwAn3rAefZj98d2ZJ4Lmx+amjYHc6GB
=Phub
-----END PGP SIGNATURE-----
