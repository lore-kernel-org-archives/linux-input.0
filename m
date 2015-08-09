From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: synaptics-rmi4: Add device tree support for RMI4
 I2C devices
Date: Sun, 9 Aug 2015 00:40:38 -0700
Message-ID: <20150809074038.GB32984@dtor-ws>
References: <1438994270-29809-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34043 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932482AbbHIHkl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 9 Aug 2015 03:40:41 -0400
Content-Disposition: inline
In-Reply-To: <1438994270-29809-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>

Hi Andrew,

On Fri, Aug 07, 2015 at 05:37:49PM -0700, Andrew Duggan wrote:
> +Optional Properties:
> +- syna,sensor-name: The string containing the name of the sensor.
> +- syna,attn-gpio: The GPIO number used to assert attention.
> +- syna,attn-polarity: The polarity of the attention GPIO.
> +- syna,level-triggered: Set to 1 if attention GPIO is level triggered, 0 if
> +			edge triggered.

We already have generic bindings for i2c devices interrupt line, along
with trigger type. We also have standard bindings for gpios, with the
polarity. Interrupts are also parsed by the I2C core. There is no need
to invent your own bindings.

> +- syna,poll-interval-ms: The interval in milliseconds to wait between reading
> +			interrupts when the driver is polling.
> +- syna,reset-delay-ms: The number of milliseconds to wait after resetting the
> +			device.
> +- syna,f01-*: Additional parameters specific to RMI4 function 1
> +		see Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt.
> +- syna,f11-*: Additional parameters specific to RMI4 function 11
> +		see Documentation/devicetree/bindings/input/rmi4/rmi_f11.txt.

For function parameters I wonder if they should not be modelled as
subnodes with "reg" representing function number.

Thanks.

-- 
Dmitry
