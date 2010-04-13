From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH 1/2] Emit TOUCH with DOUBLETAP for single touch
Date: Tue, 13 Apr 2010 16:01:26 -0400
Message-ID: <4BC4CD96.3050806@seas.upenn.edu>
References: <1270850306-4949-1-git-send-email-rafi@seas.upenn.edu> <alpine.LNX.2.00.1004131526300.8345@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stag.seas.upenn.edu ([158.130.70.79]:60570 "EHLO
	stag.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952Ab0DMUBs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Apr 2010 16:01:48 -0400
In-Reply-To: <alpine.LNX.2.00.1004131526300.8345@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, micki@n-trig.com, dmitry.torokhov@gmail.com, chatty@enac.fr

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jiri Kosina wrote:
> On Fri, 9 Apr 2010, Rafi Rubin wrote:
> 
>> Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>
>> ---
>>
>> I squelched TipSwitch in a recent patch which resulted in the loss
>> of Touch events for single touch firmwares.  This patch just puts Touch back
>> in for single touch, and bundles it with DoubleTap (like the multitouch code).
>> The two events are used to convey the same message to different drivers.
> 
> Thanks Rafi. This should probably still be .34 material, right?

Yes, this fix became more necessary with the previous Touch patch, which
squelched the tipswitch event on behalf of the multi touch firmwares.  So it
would be nice to keep them relatively close together.


Rafi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkvEzZYACgkQwuRiAT9o60/PaACgmzf/cLF+vyms9JZcR9zZab04
mNsAoPXBPJjFmXdnhITd6NEMf9qjdyR5
=stpn
-----END PGP SIGNATURE-----
