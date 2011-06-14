From: simon@mungewell.org
Subject: Re: [PATCH] Fix autocentering command in hid-lgff driver
Date: Tue, 14 Jun 2011 17:20:52 -0400
Message-ID: <e8b1518b49c3c1dd660270df5e512705.squirrel@host171.canaca.com>
References: <2502891.N5kVV5at6b@qosmio-x300>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:49862 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799Ab1FNVU5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jun 2011 17:20:57 -0400
In-Reply-To: <2502891.N5kVV5at6b@qosmio-x300>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?=22Michal_Mal=FD=22?= <madcatxster@gmail.com>
Cc: jkosina@suse.cz, linux-input@vger.kernel.org

> Hello,
>
> this patch fixes two issues with autocentering in lgff driver. Current
> implementation incorrectly assumes that the saturation force is always
> 0x80 which is
> inconsistent with behavior of the official driver. It also makes it
> impossible to disable autocentering on some wheels - at least Logitech
> Formula Force RX is
> the case. Values of stiffness coefficient were also calculated
> incorrectly. Formula used in this patch appears to generate the same
> commands as the official
> Logitech drivers. The patch also fixes two minor coding style issues.

Hi Michal,
Can you elaborate more on the difference between stiffness and saturation?
And how these might work in the Linux FF system which only accounts a
single parameter.

On my reverse engineering of the Wii Wheel (1) I noticed that the
AutoCentre consisted of 3 variables, but did realise the precise details.
Perhaps I can factor in a similar adjustment....

BTW - I also discovered some other modes of feedback beyond AutoCentre and
CF which might be applicable to other Logitech wheels. (2)

Simon

1.
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=drivers/hid/hid-lg4ff.c;h=fa550c8e1d1bc639bd3e9c34a299903391bca44a;hb=3a2289a4a317e0290a8bc7af28c62c9830cb12e5#l72

2. http://wiibrew.org/wiki/Logitech_USB_steering_wheel

