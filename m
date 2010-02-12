From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH 3/4] hid-ntrig.c Split multi and single touch.
Date: Thu, 11 Feb 2010 22:10:35 -0500
Message-ID: <4B74C6AB.1010704@seas.upenn.edu>
References: <1265933946-8318-1-git-send-email-rafi@seas.upenn.edu> <1265933946-8318-2-git-send-email-rafi@seas.upenn.edu> <1265933946-8318-3-git-send-email-rafi@seas.upenn.edu> <20100212004247.GB6394@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.seas.upenn.edu ([158.130.12.194]:48078 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757850Ab0BLDKr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Feb 2010 22:10:47 -0500
In-Reply-To: <20100212004247.GB6394@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, chatty@enac.fr

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>> +			input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, 0);
>> +			input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, 0);
>> +			input_mt_sync(input);
>> +		}
>> +	}
> 
> Where's the final input_sync()? And if hid does it for us (I think it does)
> then syncs above are not needed.

It seems the normal input_sync calls are unnecessary for the single touch device.

The mt syncs are necessary to separate each contact.  And since we are caching the
contacts we need to emit those.  The final normal input_sync is handled by hid.

On a side note, once I pulled the st input syncs, the mt device stopped getting them.
I had to undo the blocking of CONTACTCOUNT which restores the normal syncs from hid.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkt0xqgACgkQwuRiAT9o6081+wCfe5K5LRJXr0jORoTJPOVwCrXT
V7YAn1ijdSwMSyenvPU9wy3QfJyodDJS
=UZmW
-----END PGP SIGNATURE-----
