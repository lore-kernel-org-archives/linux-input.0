From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH 2/2] Use TIPSWITCH for TOUCH
Date: Tue, 13 Apr 2010 16:04:37 -0400
Message-ID: <4BC4CE55.8030905@seas.upenn.edu>
References: <1270850306-4949-1-git-send-email-rafi@seas.upenn.edu> <1270850306-4949-2-git-send-email-rafi@seas.upenn.edu> <alpine.LNX.2.00.1004131530460.8345@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.seas.upenn.edu ([158.130.12.194]:58975 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793Ab0DMUEs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Apr 2010 16:04:48 -0400
In-Reply-To: <alpine.LNX.2.00.1004131530460.8345@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, micki@n-trig.com, dmitry.torokhov@gmail.com, chatty@enac.fr

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>> +				/*
>> +				 * TIPSWITCH indicates the presence of a
>> +				 * finger.  DOUBLETAP is emitted are both
>> +				 * emitted to support legacy drivers.
>> +				 */
> 
> This comment has some slightly strange wording.

Yeah, the wording wasn't great before, but it looks like something happened to
the comment I thought I wrote.  I will clean up that comment and resubmit later
today.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkvEzlUACgkQwuRiAT9o609lyQCfS8LgCIT3XPHyH0113lRicYFt
qWsAn07U5muHivTFk1ovYcdzWvaM4gK3
=Bd+a
-----END PGP SIGNATURE-----
