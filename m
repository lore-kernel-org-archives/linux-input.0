From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 3/3] ACPI / PMIC: Add opregion driver for Intel Dollar
 Cove TI PMIC
Date: Tue, 22 Aug 2017 16:26:40 +0300
Message-ID: <1503408400.25945.57.camel@linux.intel.com>
References: <20170822055710.26515-1-tiwai@suse.de>
         <20170822055710.26515-4-tiwai@suse.de>
         <1503395915.25945.48.camel@linux.intel.com> <s5ho9r7aohj.wl-tiwai@suse.de>
         <s5hefs3amsq.wl-tiwai@suse.de> <1503401841.25945.51.camel@linux.intel.com>
         <1503403707.25945.54.camel@linux.intel.com> <s5h378jaiva.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3236 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932791AbdHVN0p (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 22 Aug 2017 09:26:45 -0400
In-Reply-To: <s5h378jaiva.wl-tiwai@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Johannes Stezenbach <js@sig21.net>, linux-input@vger.kernel.org, linux-acpi@vger.kernel.org

On Tue, 2017-08-22 at 14:26 +0200, Takashi Iwai wrote:
> On Tue, 22 Aug 2017 14:08:27 +0200,
> Andy Shevchenko wrote:
> > 

> 
> > Or even do a separate ADC driver under drivers/iio/adc for PMIC(s).
> 
> That's another option, but I took an easier path as the first step.

Looking to the current pattern we have ADC being referred from ACPI PMIC
 OpRegion drivers, so, I have to withdraw my proposal.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
