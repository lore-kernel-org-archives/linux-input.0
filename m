From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add driver for GOODiX GTx5 series touchsereen
Date: Tue, 6 Jun 2017 23:33:11 -0700
Message-ID: <20170607063311.GB23434@dtor-ws>
References: <82be2a70-2fe7-93c3-ddeb-e9f9d9243d53@goodix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36639 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbdFGGdO (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Jun 2017 02:33:14 -0400
Content-Disposition: inline
In-Reply-To: <82be2a70-2fe7-93c3-ddeb-e9f9d9243d53@goodix.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wang Yafei <wangyafei@goodix.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, andrew@goodix.com, mouse@goodix.com

Hi Wang,

On Wed, Jun 07, 2017 at 12:05:51PM +0800, Wang Yafei wrote:
> This driver is for GOODiX GTx5 series touchscreen controllers
> such as GT8589, GT7589. This driver designed with hierarchial structure,
> for that can be modified to support subsequent controllers easily.
> Some zones of the touchscreen can be set to buttons(according to the
> hardware). That is why it handles button and multitouch events.
> 
> A brief description of driver structure
> - Core Layer: This layer responsible for basic input events report,
>   GPIO pinctrl, Interrupt, Power resources manager and submodules
>   manager.
> - Hardware Layer: This layer responsible for controllers initialization,
>   irq handle as well as bus read/write.
> - External Module Layer: This layer used for support more features
>   such as firmware update, debug tools and gesture wakeup.


What is the difference between this version and the version you posted a
couple of days ago?

A few high level comments/questions:

- is this for a different chip that what is handled by the Goodix driver
  that we already have in the kernel?

- you should be using standard touchscreen bindings described in
  Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt

- please use gpiod API without gpio fallbacks: you are submitting the
  driver for inclusion into mainline that does have gpiod API and for
  mainline it does not make sense to use fallbacks.

- similarly drop other compat stuff for older kernels

- please drop Android stiff (EARLY_SUSPEND, ets).

- use generic device properties (device_property_read_*()) instead of
  OF-specific variants.

- use get_unaligned_*() API to convert data on wire to CPU format
  instead of doing the same by hand.

- use dev_err(), dev_dbg(), etc for logging.

Thanks.

-- 
Dmitry
