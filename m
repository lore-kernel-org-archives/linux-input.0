From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [BISECTED] Re: psmouse.c: GlidePoint at isa0060/serio1/input0
	lost sync at byte 1
Date: Wed, 16 Jan 2008 14:33:50 -0500
Message-ID: <20080116142815.ZZRA012@mailhub.coreip.homeip.net>
References: <19f34abd0711141226n60323630rdc4833db0bfb2eeb@mail.gmail.com> <19f34abd0801071224kb9cb121u244b00b274231db0@mail.gmail.com> <d120d5000801110647k4b1fa49ene974898baf745aec@mail.gmail.com> <478CFB56.1030700@gmail.com> <20080115154142.ZZRA012@mailhub.coreip.homeip.net> <20080116104024.ZZRA012@mailhub.coreip.homeip.net> <19f34abd0801160946j2fe1c75ap3617dd125c81008f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from po-out-1718.google.com ([72.14.252.153]:36258 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbYAPTd6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Jan 2008 14:33:58 -0500
Received: by po-out-1718.google.com with SMTP id y22so2946008pof.1
        for <linux-input@vger.kernel.org>; Wed, 16 Jan 2008 11:33:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <19f34abd0801160946j2fe1c75ap3617dd125c81008f@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vegard Nossum <vegard.nossum@gmail.com>
Cc: linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, William Pettersson <william.pettersson@gmail.com>

On Wed, Jan 16, 2008 at 06:46:46PM +0100, Vegard Nossum wrote:
> 
> I have now tried this patch. I don't see a sync error now, but the
> button still does not work as expected. Now the scroll down button
> acts like a middle button instead of scrolling down.
> 
> I am sorry for the confusion; on my laptop it looks like a single
> button, but in fact it can be pressed in four different ways (up,
> down, left, and right). In 2.6.23, pressing left or right, I get the
> traditional paste functionality. Pressing up or down, it acts like a
> scroll wheel (up or down). In 2.6.24-rc1, it is the scrolling up/down
> that causes the lost sync (but the left/right works correctly).
>

I see. Could you please provide me with another debug log of all
4 presses/releases of all the buttons, with the patch applied?
Do it in the following order please: left, right, middle, up, down.

Thank you.

-- 
Dmitry
