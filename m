From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH 3/4] hid-ntrig.c Split multi and single touch.
Date: Fri, 12 Feb 2010 18:16:26 -0500
Message-ID: <4B75E14A.2050602@seas.upenn.edu>
References: <1265933946-8318-1-git-send-email-rafi@seas.upenn.edu> <1265944448-23436-1-git-send-email-rafi@seas.upenn.edu> <1265944448-23436-2-git-send-email-rafi@seas.upenn.edu> <1265944448-23436-3-git-send-email-rafi@seas.upenn.edu> <20100212081350.GB7777@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.seas.upenn.edu ([158.130.12.194]:60050 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848Ab0BLXQh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Feb 2010 18:16:37 -0500
In-Reply-To: <20100212081350.GB7777@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, chatty@enac.fr, Henrik Rydberg <rydberg@euromail.se>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/12/10 03:13, Dmitry Torokhov wrote:
> On Thu, Feb 11, 2010 at 10:14:07PM -0500, Rafi Rubin wrote:
>> +
>> +	/* options */
>> +	enum ntrig_mt_emit_ghosts emit_ghosts;
> 
> How can user change this option? Why would he want to do it?

If I move it to a module parameter is there some particular style to handle
enumerations or should I change it back to an int?  Or even a bool.

And if I also wanted to make max contacts a parameter is there any reason to
worry about people putting in multiple devices handled by this driver and
wanting different caps for each?


Anyway, the reason I have the max_contacts and 2 ghost options is a bit of
uncertainty about the protocol.  Perhaps we should clear that up first.

Henrik: you wrote the protocol doc, perhaps you can clarify this.

My understanding is that mt contacts should be emitted sparsely.  And we should
not worry about emitting ghosts.  If so I'd be happy to pull that.

The document also states that the kernel should not do finger tracking.  In this
case, the hardware is reporting tracking id's even though it is not actually
performing the tracking.  Given the history of behavior change on each firmware
update, it would not surprise me if newer firmware and newer devices might
actually start sending valid id's.  Is it better to track or to block emission
of the id's to userspace?

Also, keep in mind that finger tracking is useful for the single touch emulation.


For now, I'll remove the ghost code and will write a new patch later if needed.

Rafi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkt14UcACgkQwuRiAT9o60865ACg+MQta7w6FLqXO0lwDslGM79g
RdMAn2EjxFyK3KYmn+4uORvuHjvUI0aY
=V5aK
-----END PGP SIGNATURE-----
