From: Stefano Babic <sbabic@denx.de>
Subject: Re: [PATCH] input: wrong irq requested in edt-ft5x06.c
Date: Thu, 20 Sep 2012 10:56:55 +0200
Message-ID: <505ADA57.4060606@denx.de>
References: <1348066434-2168-1-git-send-email-sbabic@denx.de> <20120919165815.GB16286@core.coreip.homeip.net> <505AD145.8050204@denx.de> <505AD454.7060200@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtpi3.ngi.it ([88.149.128.33]:50522 "EHLO smtpi3.ngi.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753191Ab2ITI5D (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Sep 2012 04:57:03 -0400
In-Reply-To: <505AD454.7060200@kernelconcepts.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Budig <simon.budig@kernelconcepts.de>
Cc: Stefano Babic <sbabic@denx.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

On 20/09/2012 10:31, Simon Budig wrote:
> On 09/20/2012 10:18 AM, Stefano Babic wrote:
>> But they contain the same information, as the irq number can be
>> get easy from irq_pin with gpio_to_irq(). Having both, it is
>> possible to set them to different values, and this is wrong.
> 
> gpio_to_irq is not available on all platforms. There was a
> discussion on that topic quite a while ago.

I missed this issue, thanks !

> Moving the irq setup code to the board file was the conclusion from
> that discussion.

Understood, thanks.

Regards,
Stefano

-- 
=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
