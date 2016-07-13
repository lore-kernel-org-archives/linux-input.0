From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v1] Add support for the ektf2127 touchscreencontroller
Date: Wed, 13 Jul 2016 14:50:18 -0700
Message-ID: <20160713215018.GA1799@dtor-ws>
References: <1467624545-3455-1-git-send-email-siebren.vroegindeweij@gmail.com>
 <1467624545-3455-2-git-send-email-siebren.vroegindeweij@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35825 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067AbcGMVuW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jul 2016 17:50:22 -0400
Content-Disposition: inline
In-Reply-To: <1467624545-3455-2-git-send-email-siebren.vroegindeweij@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Siebren Vroegindeweij <siebren.vroegindeweij@gmail.com>, KT Liao <ktalex.liao@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Michel Verlaan <michel.verl@gmail.com>, Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>, KT Liao <kt.liao@emc.com.tw>

On Mon, Jul 04, 2016 at 11:29:05AM +0200, Siebren Vroegindeweij wrote:
> From: Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>
> 
> The ELAN eKTF2127 driver is written for the ELAN series of
> touchscreencontrollers. This version is especially written for the
> eKTF2127 controller. The driver communicates to the controller over i2c.
> The additional screen specifications can be read from the devicetree file.
> The driver has also the ability to read the screen height and width from
> the controller. When the screen is pressed, a interrupt is generated.
> The interrupt wil be handled by a function that request a data string from
> the controller. This string is then modified so that the right number of touches
> and their x and y coordinates are available and given to userspace through
> the input subsystem.

Adding KT. Can eKTF2127 be driven with [modified] elants_i2c driver or
we are better off with separate driver.

...

> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 3 of the License, or
> + * (at your option) any later version.

Gpl V2 or later for kernel please, we won't take v3.

Thanks.

-- 
Dmitry
