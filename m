From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v3] Input: Add driver for GOODiX GTx5 series touchsereen
Date: Thu, 22 Jun 2017 18:32:28 +0200
Message-ID: <1498149148.2559.37.camel@hadess.net>
References: <20170620130021.GA29031@andrew-dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:50288 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752374AbdFVQcd (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 22 Jun 2017 12:32:33 -0400
In-Reply-To: <20170620130021.GA29031@andrew-dell>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wang Yafei <wangyafei@goodix.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-input@vger.kernel.org, andrew@goodix.com, mouse@goodix.com

Hey,

Very shallow review. There are tons of typos in the code and comments,
including in the subject line for this patch ("touchsereen"), including
"godix", "excuted", etc. Please run a spell-check over the whole patch,
and have somebody review all the text.

On Tue, 2017-06-20 at 21:00 +0800, Wang Yafei wrote:
> This driver is for GOODiX GTx5 series touchscreen controllers
> such as GT8589, GT7589. This driver designed with hierarchial 

"hierarchical"

> structure,
> for that can be modified to support subsequent controllers easily.
> Some zones of the touchscreen can be set to buttons(according to the
> hardware). That is why it handles button and multitouch events.
> 
> A brief description of driver structure
> - Core Layer: This layer responsible for basic input events report,
>   GPIO pinctrl, Interrupt, Power resources manager and submodules
> manager.
> - Hardware Layer: This layer responsible for controllers
> initialization,
>   irq handle as well as bus read/write.
> - External Module Layer: This layer used for support more features
>   such as firmware update, debug tools and gesture wakeup.

I think that the driver should be split up in multiple patches. The
first one should handle the basics for the device (I'd say parity with
the driver for the older models would be fine), then add the various
features on top (firmware loading, gesture wakeup, etc.) as those
features probably need more thought as to what the external APIs should
be.

> Signed-off-by: Wang Yafei <wangyafei@goodix.com>
> ---
> Goodix driver that the kernel already have, is for our gt9xx series
> touchscreen controllers. This new driver is for out new generation
> touchscreen controllers, consider this two generations are very
> different with each other. We wrote a new driver instead of make
> a patch on the old driver.

You'll probably need a preparatory patch which makes changes to the
description and KConfig for the old driver, spelling out exactly what
the old driver supports, maybe renaming it.

You'll also need to decide whether the company is called GOODiX, GOODIX
or Goodix, whether the new devices are "sunrise", "GTx5" or something
else.

> Changes in v2:
>  - replace touchscreen properties according to the description in
>    Documentation/devicetree/bindings/input/touchscreen/touchscreen.tx
> t
>  - Droped all compat stuff for older kernels
>  - Removed Android stuff (EARLY_SUSPEND, CONFIG_FB)

There's still an ifdef with "COMPAT" in the name, not sure compat with
what.

>  - Use device_property_read_*  get device properties
>  - use get-unaligned_*() API
>  - Use dev_err() dev_dbg() for logging
>  - remove pinctrl functions
>  - remove some unused functions

Cheers
