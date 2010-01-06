From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: Question: Formula Force GP (Force) Feedback
Date: Wed, 6 Jan 2010 14:41:30 +0200
Message-ID: <201001061441.30202.anssi.hannula@iki.fi>
References: <1262554958.10612.19.camel@slim-one-desktop> <alpine.LNX.2.00.1001061141570.2277@pobox.suse.cz> <1262781002.2804.60.camel@slim-one-desktop>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sypressi.dnainternet.net ([83.102.40.135]:57960 "EHLO
	sypressi.dnainternet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756Ab0AFMlc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Jan 2010 07:41:32 -0500
In-Reply-To: <1262781002.2804.60.camel@slim-one-desktop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter <peter@slim-one.de>
Cc: Jiri Kosina <jkosina@suse.cz>, wylda@volny.cz, christophe.borivant@wanadoo.fr, linux-input@vger.kernel.org

Peter wrote:
> Hi,

Hi!

> my description wasn't that good indeed :)
> 
> I have an Logitech Formula Force GP and tried to get Force Feedback
> working (to play LFS (www.lfs.net) via wine). The wheel is recognized
> properly and as an input device there are no problems. Force Feedback
> isn't working properly, tho. I looked around a bit and found hid-lgff.c,
> which i have modified a bit to get an idea how the effects are
> generated:
> 
>     case FF_CONSTANT:
>         x = effect->u.ramp.start_level + 0x7f; /* 0x7f is center */
>         y = effect->u.ramp.end_level   + 0x7f; /**/
>         CLAMP(x);
>         CLAMP(y);
>         report->field[0]->value[0] = 0x51;
>         report->field[0]->value[1] = 0x08;
>         report->field[0]->value[2] = x;
>         report->field[0]->value[3] = y;
>         dbg_hid("(x, y)=(%04x, %04x)\n", x, y);
>         usbhid_submit_report(hid, report, USB_DIR_OUT);
> >       printk(KERN_INFO "Forces: x=%d y=%d\n",
> >		report->field[0]->value[2], 
> >		report->field[0]->value[3]);
>         break;
> 
> I guess i could have enabled debug somehow, but didn't know how to. It
> did the trick for me anyway. 
> 
> The problem is, that somehow x and y only get values above 0x7f.

This issue is probably fixed by this commit:

http://git.kernel.org/?p=linux/kernel/git/dtor/input.git;a=commitdiff;h=1b11c88d3e8f55dc9d193d19de11e3f7abc1b7d7

-- 
Anssi Hannula
