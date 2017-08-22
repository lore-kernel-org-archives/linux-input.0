From: Johannes Stezenbach <js@sig21.net>
Subject: Re: [PATCH 2/3] input/keyboard: Add support for Dollar Cove TI power
 button
Date: Tue, 22 Aug 2017 19:25:46 +0200
Message-ID: <20170822172546.6ejpwoedjzsbufzm@sig21.net>
References: <20170822055710.26515-1-tiwai@suse.de>
 <20170822055710.26515-3-tiwai@suse.de>
 <1503394928.25945.46.camel@linux.intel.com>
 <s5hinhfamyo.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hinhfamyo.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-input@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Aug 22, 2017 at 12:58:07PM +0200, Takashi Iwai wrote:
> I updated the patches and now pushed to topic/dollar-cove-ti-4.13-v2
> branch.  Will resubmit v2 (tomorrow or later) once after gathering
> reviews.

FWIW I tested current Linus's master + topic/dollar-cove-ti-4.13-v2
+ topic/soc-cx2072x-4.13 + my test patches, no observable
difference to topic/dollar-cove-ti-4.13 on E200HA.

Still hoping someone would give me a hint about possible
causes for the SoC entering S0i1 only instead of S0i3?
(https://bugzilla.kernel.org/show_bug.cgi?id=193891)
Where do I start looking?

Thanks,
Johannes
