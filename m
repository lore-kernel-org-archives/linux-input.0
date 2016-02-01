From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/3] input: touchscreen: ad7879: add device tree
 support
Date: Mon, 1 Feb 2016 09:13:05 -0600
Message-ID: <20160201151305.GA9558@rob-hp-laptop>
References: <1454111295-5615-1-git-send-email-stefan@agner.ch>
 <1454111295-5615-3-git-send-email-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35279 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752319AbcBAPNK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 1 Feb 2016 10:13:10 -0500
Content-Disposition: inline
In-Reply-To: <1454111295-5615-3-git-send-email-stefan@agner.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: dmitry.torokhov@gmail.com, michael.hennerich@analog.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, realmz6@gmail.com, broonie@kernel.org, jic23@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jan 29, 2016 at 03:48:15PM -0800, Stefan Agner wrote:
> Add device tree support for the I2C and SPI variant of AD7879(-1).
> This allows to specify the touchscreen controller as a I2C client
> node or SPI slave device. Most of the options available in platform
> data are also available as device tree properties, the only exception
> being GPIO capabilities, which can not be activated through device
> tree currently.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Changes since v1:
> - Move device tree parsing to main driver file ad7879.c
> - Use common touchscreen_parse_properties for common properties
> - Use device_property_* API
> - Use struct ad7879 directly to store parsed values
> - Support SPI variant through device tree too (untested)
> - Add vendor prefix to vendor specific dt properties
> 
>  .../bindings/input/touchscreen/ad7879.txt          |  53 ++++++++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/input/touchscreen/ad7879-i2c.c             |  10 ++
>  drivers/input/touchscreen/ad7879-spi.c             |  10 ++
>  drivers/input/touchscreen/ad7879.c                 | 141 +++++++++++++--------
>  4 files changed, 160 insertions(+), 54 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ad7879.txt
