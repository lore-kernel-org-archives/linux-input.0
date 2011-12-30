From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: samsung-keypad - Implement runtime power
 management support
Date: Thu, 29 Dec 2011 19:29:27 -0800
Message-ID: <20111230032927.GC17850@core.coreip.homeip.net>
References: <1325071284-28634-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64689 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754952Ab1L3D3d (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Dec 2011 22:29:33 -0500
Received: by iaeh11 with SMTP id h11so24615943iae.19
        for <linux-input@vger.kernel.org>; Thu, 29 Dec 2011 19:29:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1325071284-28634-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Thomas Abraham <thomas.abraham@linaro.org>, linux-input@vger.kernel.org

On Wed, Dec 28, 2011 at 11:21:24AM +0000, Mark Brown wrote:
> When runtime power management is enabled put the Samsung keypad driver
> into suspend mode with wakeups disabled whenever the device is open but
> a key is not actually been pressed. As well as saving a trivial amount of
> power this will support the use of SoC wide idle modes which put the entire
> device into a retention mode and use explicit wakeup sources to exit.
> 
> Since not all of the interrupt controllers used with the driver support
> set_irq_wake() (though they all do the right thing) and there's a nasty
> WARN() when we disable wake after failing to enable it keep track of the
> current wake status from runtime PM and only disable wake if we managed
> to enable it; I'm not entirely sure why this doesn't affect the existing
> uses of the API in the driver.
> 
> System suspend is unaffected as the driver core will runtime resume any
> suspended devices prior to system suspend.
> 

Applied, thank you Mark.

-- 
Dmitry
