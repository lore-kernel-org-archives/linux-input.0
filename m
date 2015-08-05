From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/9] Input: atmel_mxt_ts - use deep sleep mode when
 stopped
Date: Tue, 4 Aug 2015 17:02:12 -0700
Message-ID: <20150805000212.GB20765@dtor-ws>
References: <1438615397-17112-1-git-send-email-nick.dyer@itdev.co.uk>
 <1438615397-17112-3-git-send-email-nick.dyer@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35160 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbbHEACP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Aug 2015 20:02:15 -0400
Received: by pabxd6 with SMTP id xd6so2900872pab.2
        for <linux-input@vger.kernel.org>; Tue, 04 Aug 2015 17:02:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1438615397-17112-3-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: linux-input@vger.kernel.org, Alan Bowens <Alan.Bowens@atmel.com>

On Mon, Aug 03, 2015 at 04:23:10PM +0100, Nick Dyer wrote:
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
>  .../devicetree/bindings/input/atmel,maxtouch.txt   |   5 +

Since the T9 code is for compatibility with old Pixel only I do not
think we should be adding it to device tree binding, at least not at the
moment. I cut the device tree parsing out and default to deep sleep on
DT-based systems.

Thanks.

-- 
Dmitry
