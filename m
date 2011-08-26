From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: Question: I2C touchscreen controller
Date: Fri, 26 Aug 2011 12:06:28 -0500
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F388575FB8@AUSP01VMBX24.collaborationhost.net>
References: <ADE657CA350FB648AAC2C43247A983F001F3885759E3@AUSP01VMBX24.collaborationhost.net>
 <20110824195436.GA13228@core.coreip.homeip.net>
 <ADE657CA350FB648AAC2C43247A983F001F388575A7F@AUSP01VMBX24.collaborationhost.net>
 <20110825072324.GA4065@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail127.messagelabs.com ([216.82.250.115]:54415 "EHLO
	mail127.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865Ab1HZRGg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Aug 2011 13:06:36 -0400
In-Reply-To: <20110825072324.GA4065@polaris.bitmath.org>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thursday, August 25, 2011 12:23 AM, Henrik Rydberg wrote:
>> It looks like these are the current I2C touchscreen drivers in mainline:
>> 
>> CONFIG_TOUCHSCREEN_88PM860X		pmic mfd device? probably not standalone
>> CONFIG_TOUCHSCREEN_AD7879_I2C		datasheet looks simple enough
>> CONFIG_TOUCHSCREEN_ATMEL_MXT		needs firmware? probably complicated
>> CONFIG_TOUCHSCREEN_BU21013			can't find a datasheet
>> CONFIG_TOUCHSCREEN_CY8CTMG110		looks like the chip may be obsolete
>> CONFIG_TOUCHSCREEN_MAX11801		Maxim usually has long lead times
>> CONFIG_TOUCHSCREEN_MCS5000			can't find a datasheet
>> CONFIG_TOUCHSCREEN_STMPE			datasheet looks simple enough
>> CONFIG_TOUCHSCREEN_TSC2007			datasheet looks simple enough
>> 
>> Based on that I'm considering the Analog Devices, STMicro, and TI parts.
>> 
>> Do you know if any of these work better than the others?
>
> Out of those, bu21013 (and st1232 not on your list) are dual touch,
> and atmel_mxt is true multitouch. The rest are single touch.

Henrik,

Thanks for the info and pointing out the st1232 driver.  Do you know
of a link to a datasheet for it?

So, is the dual/muti-touch feature just a function of the controller?
Or do you need a touchscreen that actually supports it?

My product is currently using a 5.7" color TFT-LCD from OSD Displays.
They have a version with a built in 4 wire resistance type touchscreen
(p/n OSD057VA01CT).  I haven't used a touchscreen before so I don't
know any of the details on how they work, but with the 4 wire interface
(YU, XR, YD, XL) I don't see how you could read more than one touch.

Thanks for any information.

Regards,
Hartley