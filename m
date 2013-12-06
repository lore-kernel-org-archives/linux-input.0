From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4] Input: wacom - add SW_MUTE_DEVICE to
 include/uapi/linux/input.h
Date: Thu, 5 Dec 2013 19:37:46 -0800
Message-ID: <20131206033746.GC16530@core.coreip.homeip.net>
References: <1386100749-8827-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:43728 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753513Ab3LFJb5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Dec 2013 04:31:57 -0500
Received: by mail-pb0-f53.google.com with SMTP id ma3so753675pbc.12
        for <linux-input@vger.kernel.org>; Fri, 06 Dec 2013 01:31:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1386100749-8827-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, killertofu@gmail.com, chris@cnpbagwell.com, peter.hutterer@who-t.net, Ping Cheng <pingc@wacom.com>

Hi Ping,

On Tue, Dec 03, 2013 at 11:59:09AM -0800, Ping Cheng wrote:
> New Intuos series models added a hardware switch to turn touch
> data on/off. The state of the switch is reported periodically
> from the tablet. To report the state, SW_MUTE_DEVICE is added
> in include/uapi/linux/input.h.
> 
> Reviewed_by: Chris Bagwell <chris@cnpbagwell.com>
> Acked-by: Peter Hutterer <peter.hutterer@who-t.net>
> Tested-by: Jason Gerecke <killertofu@gmail.com>
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
> v4: Changed SW_TOUCH to SW_MUTE_DEVICE as suggested by Dmitry.

I split SW_MUTE_DEVICE addition into a separate patch (want to push it
sooner rather than later) and applied both.

Thanks.

-- 
Dmitry
