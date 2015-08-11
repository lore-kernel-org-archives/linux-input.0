From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH 2/9] Input: atmel_mxt_ts - use deep sleep mode when stopped
Date: Tue, 11 Aug 2015 15:24:38 +0100
Message-ID: <55CA05A6.1020006@itdev.co.uk>
References: <1438615397-17112-1-git-send-email-nick.dyer@itdev.co.uk>	<1438615397-17112-3-git-send-email-nick.dyer@itdev.co.uk> <CAN+gG=Hm-RAj6L8xM54RAWQhTe96XWmQp-1s+sAnQdK8qRzyng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:4371 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964946AbbHKOYn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Aug 2015 10:24:43 -0400
In-Reply-To: <CAN+gG=Hm-RAj6L8xM54RAWQhTe96XWmQp-1s+sAnQdK8qRzyng@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Alan Bowens <Alan.Bowens@atmel.com>

On 10/08/15 21:11, Benjamin Tissoires wrote:
> I am currently running v4.2-rc6, merged with Dmitry's and Jiri's tree.
> This patch completely kills my touchpad on the Pixel 2. No touch
> information is sent while the physical button still emits values. You
> said that you tested it on this laptop too, so I wonder why mine
> refuses to work.

I'm just building that version to see if I can reproduce. Dmitry made some
minor changes when he merged it, but I don't think it should have affected
anything.

Are you able to send me some dmesg output with dyndbg=+pt enabled?

It would also be useful if you could compile mxt-app and try issuing a
calibrate or reset command to see if that restores touch (let me know if
you need instructions).

> It looks also that the deep sleep gets kept while rebooting a
> different kernel. If I reboot to the standard fedora kernel (without
> this patch), I still have the same problem, and I have to reboot under
> ChromeOS to get the touchpad back alive. Then, the Fedora kernel works
> just fine.

That's unfortunate. In an ideal world the Fedora kernel driver should
reset the touch controller or at least check the power settings, and it
appears it's doing neither.
