From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] wm97xx-core: Report a phys for WM97xx touchscreens
Date: Thu, 22 May 2008 09:41:48 -0400
Message-ID: <20080522093759.ZZRA012@mailhub.coreip.homeip.net>
References: <1211456106-10882-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:34500 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964AbYEVNlx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 May 2008 09:41:53 -0400
Received: by py-out-1112.google.com with SMTP id p76so28142pyb.10
        for <linux-input@vger.kernel.org>; Thu, 22 May 2008 06:41:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1211456106-10882-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org

Hi Mark,

On Thu, May 22, 2008 at 12:35:06PM +0100, Mark Brown wrote:
> phys is displayed in various diagnostic output so ensure that it is set
> to something sensible.
>

Phys is used to describe the physical connection of a device that is
ideally not changing between reboots so having it set up based on
device's bus_id is not a best option I think.

What tools besides evbug use phys? They probably should display both
phys and sysfs paths (I will be changing evbug soon).

-- 
Dmitry
