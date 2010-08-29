From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH 3/4] identify firmware version
Date: Sun, 29 Aug 2010 15:55:45 -0400
Message-ID: <4C7ABB41.1020708@seas.upenn.edu>
References: <1282798497-19791-1-git-send-email-rafi@seas.upenn.edu> <1282798497-19791-4-git-send-email-rafi@seas.upenn.edu> <4C77A92F.8020302@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from talbot.seas.upenn.edu ([158.130.67.217]:52179 "EHLO
	talbot.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018Ab0H2UIR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Aug 2010 16:08:17 -0400
In-Reply-To: <4C77A92F.8020302@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, chatty@enac.fr, micki@n-trig.com

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/27/10 08:01, Henrik Rydberg wrote:
> On 08/26/2010 06:54 AM, Rafi Rubin wrote:
> 
>> This adds firmware version polling to the end of probe and reports the
>> version both in the raw form and proccessed to match the formatting used
>> by ntrig in windows.
>>
>> Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>
> 
> 
> The version field of the input_id struct is a 16-bit number that can be used to
> code device-specific version information, and is retrievable via EVIOCGID.
> Perhaps one could code the firmware version in there.
> 
> Henrik

Thanks, I missed that field and will update my approach accordingly.

I suppose in that case, I should also keep the firmware decoding as a userspace
tool.

Micki, would you care to comment on the decoding?  Any misplaced bits, or
additional bits you would like to add mappings for?

Rafi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkx6u0EACgkQwuRiAT9o60+8SwCgrjqd+FNJPSEve/tdM7+C0i4/
0xsAmwVg0YDjz3QFukfPyawrZwdoPD3U
=htK1
-----END PGP SIGNATURE-----
