From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] Input: add support for HiDeep touchscreen
Date: Mon, 18 Sep 2017 14:03:59 -0500
Message-ID: <20170918190359.ukynrfnbci7d6v2h@rob-hp-laptop>
References: <1505114862-32489-1-git-send-email-anthony.kim@hideep.com>
 <1505363804-6827-1-git-send-email-anthony.kim@hideep.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:34496 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbdIRTEB (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 18 Sep 2017 15:04:01 -0400
Content-Disposition: inline
In-Reply-To: <1505363804-6827-1-git-send-email-anthony.kim@hideep.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anthony Kim <anthony.kim@hideep.com>
Cc: dmitry.torokhov@gmail.com, lkp@intel.com, kbuild-all@01.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Sep 14, 2017 at 01:36:44PM +0900, Anthony Kim wrote:
> The HiDeep touchscreen device is a capacitive multi-touch controller
> mainly for multi-touch supported devices use. It use I2C interface for
> communication to IC and provide axis X, Y, Z locations for ten finger
> touch through input event interface to userspace.
> 
> It support the Crimson and the Lime two type IC. They are different
> the number of channel supported and FW size. But the working protocol
> is same.
> 
> Signed-off-by: Anthony Kim <anthony.kim@hideep.com>
> ---
>  .../bindings/input/touchscreen/hideep.txt          |   42 +
>  .../devicetree/bindings/vendor-prefixes.txt        |    1 +

Please add acks when posting new versions.

>  drivers/input/touchscreen/Kconfig                  |   11 +
>  drivers/input/touchscreen/Makefile                 |    1 +
>  drivers/input/touchscreen/hideep.c                 | 1274 ++++++++++++++++++++
>  5 files changed, 1329 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/hideep.txt
>  create mode 100644 drivers/input/touchscreen/hideep.c
