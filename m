From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH] MAINTAINERS: Update rydberg's addresses
Date: Tue, 20 Jan 2015 23:26:20 +0100
Message-ID: <54BED60C.3030303@bitmath.org>
References: <1418979967-2134-1-git-send-email-rydberg@bitmath.org> <CAN+gG=Gmgk+wKSnHkSAERoWt+1PqAojNSZt6jo=qmzPOqJs+3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailrelay7.public.one.com ([91.198.169.215]:15345 "EHLO
	mailrelay7.public.one.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796AbbATW0W (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Jan 2015 17:26:22 -0500
In-Reply-To: <CAN+gG=Gmgk+wKSnHkSAERoWt+1PqAojNSZt6jo=qmzPOqJs+3Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Benjamin,

> Henrik, I just used the get_maintainer to add you on CC to an input-mt
> patch series, and it ended up using the @euromail.se instead of your
> still valid one. I can resend to you the patch series if you want.

Thanks, that won't be necessary.

I looked through the the patchset, and it strikes me as mostly renames without
deeper explanations, which all in all puts them in the not-needed category, I am
afraid. An in-depth explanation could be added as a text block somewhere without
touching the current code.

The only patch that does something is the last one, and what it does could
easily be performed in userland, by further processing of the contacts there. I
therefore see no use for any of those patches in the kernel.

Is there a good reason for the first reaction to be to add special tweaks such
as this one in the kernel, rather than in a dedicated userland input system? I
am genuinely curious.

Thanks,
Henrik

