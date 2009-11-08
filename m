From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] UCB1400: Allow passing IRQ through platfrom_data
Date: Sat, 7 Nov 2009 21:40:05 -0800
Message-ID: <20091108054005.GA6542@core.coreip.homeip.net>
References: <200911080310.04121.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:44330 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696AbZKHFkG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 8 Nov 2009 00:40:06 -0500
Received: by pxi10 with SMTP id 10so1603805pxi.33
        for <linux-input@vger.kernel.org>; Sat, 07 Nov 2009 21:40:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200911080310.04121.marek.vasut@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Marek,

On Sun, Nov 08, 2009 at 03:10:03AM +0100, Marek Vasut wrote:
> From b8d3ab594008dd2714d4dedf12348d05c08a48fd Mon Sep 17 00:00:00 2001
> From: Marek Vasut <marek.vasut@gmail.com>
> Date: Sun, 8 Nov 2009 02:51:55 +0100
> Subject: [PATCH] UCB1400: Allow passing IRQ through platfrom_data
> 
> This patch allows UCB1400 to get IRQ GPIO from platform data. In case
> platform_data are not supplied or the IRQ set in the platform_data is lower than
> zero, fall back to the old IRQ detection algorithm.
> 

Makes sense, will apply.

-- 
Dmitry
