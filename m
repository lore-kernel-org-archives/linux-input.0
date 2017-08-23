From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] Input: add support for HiDeep touchscreen
Date: Tue, 22 Aug 2017 19:07:48 -0500
Message-ID: <20170823000748.t6hgghj7udpm6nzb@rob-hp-laptop>
References: <1500965607-2446-1-git-send-email-anthony.kim@hideep.com>
 <1503392618-26853-1-git-send-email-anthony.kim@hideep.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37032 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752533AbdHWAHw (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 22 Aug 2017 20:07:52 -0400
Content-Disposition: inline
In-Reply-To: <1503392618-26853-1-git-send-email-anthony.kim@hideep.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anthony Kim <anthony.kim@hideep.com>
Cc: dmitry.torokhov@gmail.com, mark.rutland@arm.com, rydberg@bitmath.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org

On Tue, Aug 22, 2017 at 06:03:38PM +0900, Anthony Kim wrote:
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
>  .../bindings/input/touchscreen/hideep.txt          |   39 +
>  .../devicetree/bindings/vendor-prefixes.txt        |    1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/input/touchscreen/Kconfig                  |   11 +
>  drivers/input/touchscreen/Makefile                 |    1 +
>  drivers/input/touchscreen/hideep_core.c            | 1294 ++++++++++++++++++++
>  drivers/input/touchscreen/hideep_core.h            |  221 ++++
>  6 files changed, 1567 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/hideep.txt
>  create mode 100644 drivers/input/touchscreen/hideep_core.c
>  create mode 100644 drivers/input/touchscreen/hideep_core.h
