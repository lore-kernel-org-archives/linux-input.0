From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 6/9] input: goodix: write configuration data to device
Date: Thu, 28 May 2015 14:21:33 +0100
Message-ID: <20150528132133.GI23176@leverpostej>
References: <1432817265-23891-1-git-send-email-irina.tirdea@intel.com>
 <1432817265-23891-7-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54838 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752130AbbE1NVl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 28 May 2015 09:21:41 -0400
Content-Disposition: inline
In-Reply-To: <1432817265-23891-7-git-send-email-irina.tirdea@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Octavian Purdila <octavian.purdila@intel.com>

On Thu, May 28, 2015 at 01:47:42PM +0100, Irina Tirdea wrote:
> Goodix devices can be configured by writing this information
> to the device at init. The configuration data can
> be provided through the ACPI/device tree property
> "device-config". If "device-config" is not set, the default
> device configuration will be used.
> 
> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> ---
>  .../bindings/input/touchscreen/goodix.txt          |   5 +
>  drivers/input/touchscreen/goodix.c                 | 143 +++++++++++++++++++++
>  2 files changed, 148 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> index 7137881..9e4ff69 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> @@ -15,6 +15,11 @@ Required properties:
>   - irq-gpio		: GPIO pin used for IRQ
>   - reset-gpio		: GPIO pin used for reset
>  
> +Optional properties:
> +
> + - device-config	: device configuration information (specified as byte
> +			  array). Maximum size is 240 bytes.

Generally we frown on passing opaque data.

What exactly is encoded in device-config? The description is very vague.

Does this correspond to anything in a data sheet or manual?

Mark.
