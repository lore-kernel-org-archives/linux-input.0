From: Stefano Babic <sbabic@denx.de>
Subject: Re: [PATCH] input: wrong irq requested in edt-ft5x06.c
Date: Thu, 20 Sep 2012 10:18:13 +0200
Message-ID: <505AD145.8050204@denx.de>
References: <1348066434-2168-1-git-send-email-sbabic@denx.de> <20120919165815.GB16286@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtpi3.ngi.it ([88.149.128.33]:42945 "EHLO smtpi3.ngi.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751704Ab2ITIS3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Sep 2012 04:18:29 -0400
In-Reply-To: <20120919165815.GB16286@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>, linux-input@vger.kernel.org, Simon Budig <simon.budig@kernelconcepts.de>, Guenter Roeck <linux@roeck-us.net>

On 19/09/2012 18:58, Dmitry Torokhov wrote:
> Hi Stefano,
> 

Hi Dmitry,

> On Wed, Sep 19, 2012 at 04:53:54PM +0200, Stefano Babic wrote:
>> The probe function checks for integrity the pdata->irq_pin,
>> but then does not request this line for interrupt.
>> For this reason, no interrupts are generated.
>>
>> Tested on a AM3517 board with EP0700M06
> 
> Why is your board code does not set client->irq properly?

My concern is related that there are two different setup for the irq.
Near the client structure, the driver uses a an own platform data
structure edt_ft5x06_platform_data, where one filed is irq_pin. In whole
driver the pdata->irq_pin is used, and client->irq is used only for
requesting the irq.

But they contain the same information, as the irq number can be get easy
from irq_pin with gpio_to_irq(). Having both, it is possible to set them
to different values, and this is wrong.

Regards,
Stefano


-- 
=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
