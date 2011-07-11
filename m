From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: Re: [PATCH] Input: TPS6507X - define MFD dependencies for touch	and
 regulator unit
Date: Mon, 11 Jul 2011 14:29:39 +0200
Message-ID: <4E1AECB3.3080607@visionsystems.de>
References: <4E1AD56B.6080306@visionsystems.de> <20110711122004.GA9478@sirena.org.uk>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hhlx01.vscom.de ([62.145.30.242]:34911 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756454Ab1GKM3t (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jul 2011 08:29:49 -0400
In-Reply-To: <20110711122004.GA9478@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

Am 11.07.2011 14:20, schrieb Mark Brown:
> On Mon, Jul 11, 2011 at 12:50:19PM +0200, Yegor Yefremov wrote:
>> both touchscreen and regulator units are only working if
>> mfd device is activated. So if mfd support is enabled,
>> select TPS6507X mfd support automatically.
>>
>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> This should be split into separate patches and sent to *all* the
> relevant maintainers.
>
>>  config TOUCHSCREEN_TPS6507X
>>  	tristate "TPS6507x based touchscreens"
>> -	depends on I2C
>> +	depends on I2C && MFD_SUPPORT
>> +	select TPS6507X
> This isn't a good fix, the driver should depend on the MFD core not
> select it.

Thanks for reviewing. Should I change the patch like this:

touchscreen unit is only working if mfd device is activated.
So if mfd support is enabled, select TPS6507X mfd support
automatically.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 drivers/input/touchscreen/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/input/touchscreen/Kconfig
===================================================================
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -716,7 +716,7 @@

 config TOUCHSCREEN_TPS6507X
        tristate "TPS6507x based touchscreens"
-       depends on I2C
+       depends on I2C && TPS6507X
        help
          Say Y here if you have a TPS6507x based touchscreen
          controller.

