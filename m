From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 2/9] Input: atmel_mxt_ts - use deep sleep mode when stopped
Date: Mon, 10 Aug 2015 16:11:30 -0400
Message-ID: <CAN+gG=Hm-RAj6L8xM54RAWQhTe96XWmQp-1s+sAnQdK8qRzyng@mail.gmail.com>
References: <1438615397-17112-1-git-send-email-nick.dyer@itdev.co.uk>
	<1438615397-17112-3-git-send-email-nick.dyer@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:34303 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498AbbHJULc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Aug 2015 16:11:32 -0400
Received: by wicne3 with SMTP id ne3so150079328wic.1
        for <linux-input@vger.kernel.org>; Mon, 10 Aug 2015 13:11:30 -0700 (PDT)
In-Reply-To: <1438615397-17112-3-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Alan Bowens <Alan.Bowens@atmel.com>

Hi Nick,

On Mon, Aug 3, 2015 at 11:23 AM, Nick Dyer <nick.dyer@itdev.co.uk> wrote:
> The hardcoded 0x83 CTRL setting overrides other settings in that byte,
> enabling extra reporting that may not be useful on a particular platform.
>
> Implement improved suspend mechanism via deep sleep. By writing zero to
> both the active and idle cycle times the maXTouch device can be put into a
> deep sleep mode, using minimal power. It is necessary to issue a calibrate
> command after the chip has spent any time in deep sleep, however a soft
> reset is unnecessary.
>
> Use the old method on Chromebook Pixel via platform data option.
>
> This patch also deals with the situation where the power configuration is
> zero on probe, which would mean that the device never wakes up to execute
> commands.
>
> After a config download, the T7 power configuration may have changed so it
> is necessary to re-read it.
>
> Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
> Acked-by: Benson Leung <bleung@chromium.org>
> Acked-by: Yufeng Shen <miletus@chromium.org>
> ---

I am currently running v4.2-rc6, merged with Dmitry's and Jiri's tree.
This patch completely kills my touchpad on the Pixel 2. No touch
information is sent while the physical button still emits values. You
said that you tested it on this laptop too, so I wonder why mine
refuses to work.

It looks also that the deep sleep gets kept while rebooting a
different kernel. If I reboot to the standard fedora kernel (without
this patch), I still have the same problem, and I have to reboot under
ChromeOS to get the touchpad back alive. Then, the Fedora kernel works
just fine.

Any ideas why?

Cheers,
Benjamin
