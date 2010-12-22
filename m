From: Srikar <ext-srikar.1.bhavanarayana@nokia.com>
Subject: Re: [PATCH 1/4] input: touchscreen: introduce tsc2005 driver
Date: Wed, 22 Dec 2010 10:42:07 +0200
Message-ID: <4D11B9DF.4050107@nokia.com>
References: <1290699913-26540-1-git-send-email-ext-srikar.1.bhavanarayana@nokia.com> <20101213085143.GE21401@core.coreip.homeip.net> <4D088CC0.9080402@nokia.com> <20101216075716.GD26567@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:30290 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752230Ab0LVIm2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Dec 2010 03:42:28 -0500
In-Reply-To: <20101216075716.GD26567@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ext Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, lauri.leukkunen@nokia.com, aaro.koskinen@nokia.com, kwlee@mtekvision.com, ext-phil.2.carmody@nokia.com, David Brownell <dbrownell@users.sourceforge.net>, Imre Deak <imre.deak@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ari Kauppi <Ext-Ari.Kauppi@nokia.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, Roman Tereshonkov <roman.tereshonkov@nokia.com>

Hi Torkhov ,
           Other differences between tsc2005 and tsc2007 driver are
request_threaded_irq is being used by tsc2005 and request_irq is being
used by tsc2007.
        Similar  type there are other differences in the both code where
tsc200x core need to implemented  other then bus access methods,need to
discuss with tsc2007 driver to make it common implementation for both
drivers.More over added the kwlee@mtekvision.com who is contributor for
tsc2007 driver which is also need to modified for to tsc200x and
tsc2007.c.To adapt requires comments and discussion with kwlee and Lauri.
Please let me know your comments about this.So that patches to enable
touch screen driver in  platform code can sent to input.
Regards,
Srikar
     

On 12/16/2010 09:57 AM, ext Dmitry Torokhov wrote:
> On Wed, Dec 15, 2010 at 11:39:12AM +0200, Srikar wrote:
>> Hi ToroKhov,
>>               TSC2005 is using SPI interface/driver  and TSC2007 driver
>> is using i2C Interface/driver are main differences.
> I see. In this case I believe that, instead of creating completely
> separate driver, we need to abstract bus access from tsc2007 and convert
> the driver into tsc200x-core.c core piece and tcs2005.c/tsc2007.c
> implementing just bus access methods. Pretty much what was done for
> ad714x, adxl34x, ad7879 and other drivers.
>
>> I have a question, Can I release patch to input for enabling the driver
>> tsc2005 located at *arch/arm/mach-omap2/*
>>
>> As commented below by Tony Lindgren,
>> This does not exist in mainline yet, please send this patch
>> along with the tsc2005 driver via the input list. For this one:
>>
> I am not sure what this means... If you want to submit parts of platform
> code through my tree that should be fine as long as respective
> maintainer of given arch is OK with it as well.
>
> Thanks.
>

