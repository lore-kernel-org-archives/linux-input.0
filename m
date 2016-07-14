From: =?big5?B?ufmxUrph?= <kt.liao@emc.com.tw>
Subject: RE: [PATCH v1] Add support for the ektf2127 touchscreencontroller
Date: Thu, 14 Jul 2016 18:12:57 +0800
Message-ID: <009e01d1ddb8$4b51ad60$e1f50820$@emc.com.tw>
References: <1467624545-3455-1-git-send-email-siebren.vroegindeweij@gmail.com> <1467624545-3455-2-git-send-email-siebren.vroegindeweij@gmail.com> <20160713215018.GA1799@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:49530 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbcGNKND (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Jul 2016 06:13:03 -0400
In-Reply-To: <20160713215018.GA1799@dtor-ws>
Content-Language: zh-tw
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, 'Siebren Vroegindeweij' <siebren.vroegindeweij@gmail.com>, =?big5?B?J0pvaG5ueSBDaHVhbmcosviozsBNKSc=?= <johnny.chuang@emc.com.tw>, 'James Chen' <james.chen@emc.com.tw>
Cc: linux-input@vger.kernel.org, 'devicetree' <devicetree@vger.kernel.org>, 'Hans de Goede' <hdegoede@redhat.com>, 'Michel Verlaan' <michel.verl@gmail.com>, 'Siebren Vroegindeweij' <siebren.vroegindeweij@hotmail.com>

-----Original Message-----
From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com] 
Sent: Thursday, July 14, 2016 5:50 AM
To: Siebren Vroegindeweij; KT Liao
Cc: linux-input@vger.kernel.org; devicetree; Hans de Goede; Michel Verlaan;
Siebren Vroegindeweij; KT Liao
Subject: Re: [PATCH v1] Add support for the ektf2127 touchscreencontroller

On Mon, Jul 04, 2016 at 11:29:05AM +0200, Siebren Vroegindeweij wrote:
> From: Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>
> 
> The ELAN eKTF2127 driver is written for the ELAN series of 
> touchscreencontrollers. This version is especially written for the
> eKTF2127 controller. The driver communicates to the controller over i2c.
> The additional screen specifications can be read from the devicetree file.
> The driver has also the ability to read the screen height and width 
> from the controller. When the screen is pressed, a interrupt is generated.
> The interrupt wil be handled by a function that request a data string 
> from the controller. This string is then modified so that the right 
> number of touches and their x and y coordinates are available and 
> given to userspace through the input subsystem.

Adding KT. Can eKTF2127 be driven with [modified] elants_i2c driver or we
are better off with separate driver.

Hi Johnny,
Please check Dmitry's touchscreen issue.
...

> + *
> + * This program is free software; you can redistribute it and/or 
> + modify
> + * it under the terms of the GNU General Public License as published 
> + by
> + * the Free Software Foundation; either version 3 of the License, or
> + * (at your option) any later version.

Gpl V2 or later for kernel please, we won't take v3.

Thanks.

--
Dmitry

