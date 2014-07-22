From: Markus Niebel <list-09_linux_input@tqsc.de>
Subject: Re: [RFC] edt-ft5x06 - cannot see IRQ Qfrom device after DT probe
Date: Tue, 22 Jul 2014 12:40:04 +0200
Message-ID: <53CE3F84.5030301@tqsc.de>
References: <53C5685D.1090008@tqsc.de> <53C64D86.1010808@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay01.ispgateway.de ([80.67.31.24]:52518 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbaGVK2H (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Jul 2014 06:28:07 -0400
In-Reply-To: <53C64D86.1010808@kernelconcepts.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Budig <simon.budig@kernelconcepts.de>, linux-input@vger.kernel.org

Am 16.07.2014 12:01, wrote Simon Budig:
> On 15/07/14 19:43, Markus Niebel wrote:
>> - when adding an int-gpios node to devicetree and parsing this gpio the gpio will be configured as input
>> - IRQ can be seen by CPU
>>
>> Question:
>>
>> - shall we add an int-gpio property to enable gpio pin config as input or
> 
> Shouldn't it be possible to configure the pin as input directly from the
> device tree, indepently from the touch driver section?

I don't see, how to do that, maybe I did miss the right point.

I digged through the gpio code. There are drivers (gpio-omap) that make sure, that gpio is configured as
input and others that don't care (gpio-mxc / gpio-mxs).

seeing this I posted "gpio: gpio-mxc: make sure gpio is input when request IRQ" on linux-arm-kernel

Global question is: how can we make sure, that the driver that request the IRQ requests also the GPIO (implicit or like in the old platfrom data days explicit)? But thats beyond input devices and my knowledge. 

Regards

Markus

> 
> Bye,
>         Simon
> 

