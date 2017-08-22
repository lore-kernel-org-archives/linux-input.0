From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/3] input/keyboard: Add support for Dollar Cove TI
 power button
Date: Tue, 22 Aug 2017 12:42:08 +0300
Message-ID: <1503394928.25945.46.camel@linux.intel.com>
References: <20170822055710.26515-1-tiwai@suse.de>
         <20170822055710.26515-3-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:20588 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932205AbdHVJmM (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 22 Aug 2017 05:42:12 -0400
In-Reply-To: <20170822055710.26515-3-tiwai@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Johannes Stezenbach <js@sig21.net>, linux-input@vger.kernel.org, linux-acpi@vger.kernel.org

On Tue, 2017-08-22 at 07:57 +0200, Takashi Iwai wrote:
> This provides a new input driver for supporting the power button on
> Dollar Cove TI PMIC, found on Cherrytrail-based devices.
> The patch is based on the original work by Intel, found at:
>   https://github.com/01org/ProductionKernelQuilts

For now we have similar driver under drivers/platform/x86.

I think when we move to regmap API there we might even reuse
intel_mid_powerbtn.c.

Or other way around, move that one to input subsystem (which I
personally see less fit).

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
