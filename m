From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH 1/4] input: touchscreen: introduce tsc2005 driver
Date: Mon, 14 Feb 2011 13:14:24 +0200 (EET)
Message-ID: <alpine.DEB.1.10.1102141229200.27610@esdhcp041196.research.nokia.com>
References: <1290699913-26540-1-git-send-email-ext-srikar.1.bhavanarayana@nokia.com> <20101213085143.GE21401@core.coreip.homeip.net> <4D088CC0.9080402@nokia.com> <20101216075716.GD26567@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:58757 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752710Ab1BNLQc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Feb 2011 06:16:32 -0500
In-Reply-To: <20101216075716.GD26567@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Srikar <ext-srikar.1.bhavanarayana@nokia.com>, linux-input@vger.kernel.org, lauri.leukkunen@nokia.com, aaro.koskinen@nokia.com, ext-phil.2.carmody@nokia.com, David Brownell <dbrownell@users.sourceforge.net>, Imre Deak <imre.deak@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ari Kauppi <Ext-Ari.Kauppi@nokia.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, Roman Tereshonkov <roman.tereshonkov@nokia.com>

Hi,

On Wed, 15 Dec 2010, Dmitry Torokhov wrote:
> On Wed, Dec 15, 2010 at 11:39:12AM +0200, Srikar wrote:
>> Hi ToroKhov,
>>               TSC2005 is using SPI interface/driver  and TSC2007 driver
>> is using i2C Interface/driver are main differences.
>
> I see. In this case I believe that, instead of creating completely
> separate driver, we need to abstract bus access from tsc2007 and convert
> the driver into tsc200x-core.c core piece and tcs2005.c/tsc2007.c
> implementing just bus access methods. Pretty much what was done for
> ad714x, adxl34x, ad7879 and other drivers.

I think there are more differences than just the bus access. The command
interface is different, including register definitions. TSC2007 data
sheet mentions it's compatible with TSC2003 but does not mention TSC2005.

I would keep them separate, and I think this patch should be
applied for .39 (the subject is wrong - it's just a single patch:
https://patchwork.kernel.org/patch/357012/).

A.
