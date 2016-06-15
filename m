From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4] input: touchscreen: Add generic driver for Silead touchscreens
Date: Wed, 15 Jun 2016 13:39:15 -0500
Message-ID: <CAL_JsqJOSYMO7znAF3+98MmQQ3nNChrgW+N=yTmim67=X6TgLg@mail.gmail.com>
References: <1465814810-7151-1-git-send-email-djaniboe@gmail.com>
 <1465814810-7151-2-git-send-email-djaniboe@gmail.com> <20160614232720.GA28035@rob-hp-laptop>
 <46f9d002-61df-66aa-c468-9df42c8af306@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48240 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753598AbcFOSjj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Jun 2016 14:39:39 -0400
In-Reply-To: <46f9d002-61df-66aa-c468-9df42c8af306@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Daniel Jansen <djaniboe@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Robert Dolca <robert.dolca@gmail.com>, Gregor Riepl <onitake@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Wessel Blokzijl <wesselb94@gmail.com>

On Wed, Jun 15, 2016 at 2:39 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
>
> On 06/15/2016 01:27 AM, Rob Herring wrote:
>>
>> On Mon, Jun 13, 2016 at 12:46:50PM +0200, Daniel Jansen wrote:
>>>
>>> From: Robert Dolca <robert.dolca@intel.com>
>>>
>>> This driver adds support for Silead touchscreens. It has been tested
>>> with GSL1680 and GSL3680 touch panels.
>>>
>>> It supports ACPI and device tree enumeration. Screen resolution,
>>> the maximum number of fingers supported and firmware name are
>>> configurable.

[...]

>>> b/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
>>> @@ -0,0 +1,39 @@
>>> +* GSL 1680 touchscreen controller
>>> +
>>> +Required properties:
>>> +- compatible             : "silead,gsl1680"
>>> +- reg                    : I2C slave address of the chip (0x40)
>>> +- interrupt-parent       : a phandle pointing to the interrupt
>>> controller
>>> +                           serving the interrupt for this chip
>>> +- interrupts             : interrupt specification for the gsl1680
>>> interrupt
>>> +- wake-gpios             : GPIO specification for the WAKE input
>>
>>
>> What direction is this?
>
>
> This is an input to the touchscreen controller, it needs to be driven high
> to take the touchscreen controller out of its low power state.

Okay, please clarify that in the description. The gpio flags should
also indicate it is active high.

Rob
