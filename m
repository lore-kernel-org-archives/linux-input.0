From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 0/2] some updates for newer elantech touchpads
Date: Sun, 20 Nov 2011 22:37:25 -0800
Message-ID: <20111121063725.GB20521@core.coreip.homeip.net>
References: <1321854786-6666-1-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:32822 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799Ab1KUGhf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Nov 2011 01:37:35 -0500
Received: by iage36 with SMTP id e36so6881007iag.19
        for <linux-input@vger.kernel.org>; Sun, 20 Nov 2011 22:37:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1321854786-6666-1-git-send-email-jj_ding@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>
Cc: Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, =?iso-8859-1?Q?=C9ric?= Piel <E.A.B.Piel@tudelft.nl>, Daniel Kurtz <djkurtz@chromium.org>, linux-input@vger.kernel.org

On Mon, Nov 21, 2011 at 01:53:04PM +0800, JJ Ding wrote:
> Hi,
> 
> These two are my last pending patches for newer elantech touchpads.
> The first patch adds support for a shorter and faster send_cmd, available
> since v3 hardware. The other one teaches the driver to query resolution
> data from v4 hardware.
> 
> Patches are against Dmitry's current -next tree.
> 
> Any comment is welcome, thank you very much.
> 
> Change in v2:
>  - allow resolution query to fail, print a warning if so. (Daniel)
> 

Applied both, thanks JJ.

-- 
Dmitry
