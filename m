From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/4] input: touchscreen: introduce tsc2005 driver
Date: Wed, 15 Dec 2010 23:57:16 -0800
Message-ID: <20101216075716.GD26567@core.coreip.homeip.net>
References: <1290699913-26540-1-git-send-email-ext-srikar.1.bhavanarayana@nokia.com>
 <20101213085143.GE21401@core.coreip.homeip.net>
 <4D088CC0.9080402@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35806 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753833Ab0LPH5Z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Dec 2010 02:57:25 -0500
Received: by pwj3 with SMTP id 3so382026pwj.19
        for <linux-input@vger.kernel.org>; Wed, 15 Dec 2010 23:57:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D088CC0.9080402@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srikar <ext-srikar.1.bhavanarayana@nokia.com>
Cc: linux-input@vger.kernel.org, lauri.leukkunen@nokia.com, aaro.koskinen@nokia.com, ext-phil.2.carmody@nokia.com, David Brownell <dbrownell@users.sourceforge.net>, Imre Deak <imre.deak@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ari Kauppi <Ext-Ari.Kauppi@nokia.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, Roman Tereshonkov <roman.tereshonkov@nokia.com>

On Wed, Dec 15, 2010 at 11:39:12AM +0200, Srikar wrote:
> Hi ToroKhov,
>               TSC2005 is using SPI interface/driver  and TSC2007 driver
> is using i2C Interface/driver are main differences.

I see. In this case I believe that, instead of creating completely
separate driver, we need to abstract bus access from tsc2007 and convert
the driver into tsc200x-core.c core piece and tcs2005.c/tsc2007.c
implementing just bus access methods. Pretty much what was done for
ad714x, adxl34x, ad7879 and other drivers.

> I have a question, Can I release patch to input for enabling the driver
> tsc2005 located at *arch/arm/mach-omap2/*
> 
> As commented below by Tony Lindgren,
> This does not exist in mainline yet, please send this patch
> along with the tsc2005 driver via the input list. For this one:
> 

I am not sure what this means... If you want to submit parts of platform
code through my tree that should be fine as long as respective
maintainer of given arch is OK with it as well.

Thanks.

-- 
Dmitry
