From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: Gesture support query
Date: Thu, 24 Jun 2010 18:16:46 -0400
Message-ID: <4C23D94E.1030304@seas.upenn.edu>
References: <AANLkTileUKzy88sgBejaZApyNgCH5CQNOfvRReH0pbmA@mail.gmail.com> <AANLkTins_UY0opDg87EAlApIbLU84SvAHGZskylVzZ0_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from talbot.seas.upenn.edu ([158.130.67.217]:35529 "EHLO
	talbot.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450Ab0FXWeY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Jun 2010 18:34:24 -0400
In-Reply-To: <AANLkTins_UY0opDg87EAlApIbLU84SvAHGZskylVzZ0_@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>
Cc: Sriram V <vshrirama@gmail.com>, linux-input@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/24/10 08:09, Mohamed Ikbel Boulabiar wrote:
>>  My touch device supports gestures like flip and so on.
> What you mean by device support of gestures ?

Please specify which device you are using.  Some devices have specific software
to support gestures (synaptics touchpads, wacom, magic mouse, for a few
examples), though at the moment we don't really have universal gesture support.

>>  How drivers can report these to the application? Where can i find
>> the event codes for these?
> actually, gesture recognition are not inside drivers, they are
> software in between.

Sorry, no general event codes for gestures.

>>  Are there test applications to test the gestures or these are
>> application specific?
> can you specify which gestures you want to test and in which scenarios ?

Rafi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkwj2UwACgkQwuRiAT9o60/KKwCgvBwTPMa1/vKWeSx7yEk6J75K
NOUAoJdceBZYH35SxEyxrVnaEZgG5gu2
=lk4a
-----END PGP SIGNATURE-----
