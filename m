From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH v2 0/3] input: rmi4: Regulator supply support
Date: Mon, 9 May 2016 17:36:11 -0700
Message-ID: <57312CFB.2040304@synaptics.com>
References: <1462596008-21381-1-git-send-email-bjorn.andersson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:50409 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbcEJAgM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 May 2016 20:36:12 -0400
In-Reply-To: <1462596008-21381-1-git-send-email-bjorn.andersson@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Christopher Heiny <cheiny@synaptics.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

Hi Bjorn,

On 05/06/2016 09:40 PM, Bjorn Andersson wrote:
> The first version of the regulator support patch suffered from being
> implemented in the transport driver, as a work around for resource availability
> racing (EPROBE_DEFER of the core driver) with the interrupt handler.
>
> After reconsidering the solutions discussed following that I concluded that the
> interrupt management is not really part of the transport, neither conceptually
> or electrically. I therefor here suggest (patch 1/3) to move the interrupt
> registration and handling to the core rmi driver.

My concern with moving interrupt processing to the core is that not all 
transports report attn to the rmi core using an irq. The HID and SMBus 
transports which are currently in development, reside a little higher in 
the stack and attention is reported using different mechanisms. We moved 
interrupt handling to the transport drivers so that they could handle 
the differences in how attn is reported.

This message has some of the previous discussion regarding interrupt 
processing:
https://lkml.org/lkml/2015/11/28/123

Similarly, not all transports will need support for regulators. 
Implementing both in the transport drivers avoids the EPROBE_DEFER 
racing and avoids adding checks in the core to see if it needs to handle 
interrupts and manage regulators.

Thanks,
Andrew

> This solves the potential race of interrupts being delivered in the transport
> driver before the core driver have been given a chance to recover from probe
> deferral.
>
> Patch 2/3 then add the necessary code for acquiring regulator handles and
> enabling these.
>
> Patch 3/3 removes the set_page() done in the transport drivers, as we can't
> rely on the chip becoming available at any time during the initialization/probe
> phase.
>
> Bjorn Andersson (3):
>    input: rmi4: Move IRQ handling to rmi_driver
>    input: rmi4: Acquire and enable VDD and VIO supplies
>    input: rmi4: Remove set_page() call before core is initialized
>
>   .../devicetree/bindings/input/rmi4/rmi_i2c.txt     |  6 ++
>   .../devicetree/bindings/input/rmi4/rmi_spi.txt     |  6 ++
>   drivers/input/rmi4/rmi_driver.c                    | 89 +++++++++++++++++++++-
>   drivers/input/rmi4/rmi_i2c.c                       | 84 ++------------------
>   drivers/input/rmi4/rmi_spi.c                       | 83 ++------------------
>   include/linux/rmi.h                                | 11 ++-
>   6 files changed, 118 insertions(+), 161 deletions(-)
>

