From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: Add generic driver for Zeitec touchscreens
Date: Fri, 29 May 2015 17:14:14 -0700
Message-ID: <20150530001414.GD7429@dtor-ws>
References: <1432815722-31120-1-git-send-email-bogdan.g.stefan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:33319 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753951AbbE3AOT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 29 May 2015 20:14:19 -0400
Content-Disposition: inline
In-Reply-To: <1432815722-31120-1-git-send-email-bogdan.g.stefan@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bogdan George Stefan <bogdan.g.stefan@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Purdila Octavian <octavian.purdila@intel.com>

Hi Bogdan,

On Thu, May 28, 2015 at 03:22:02PM +0300, Bogdan George Stefan wrote:
> This driver adds support for Zeitec touchscreens. It has
> been tested with ZET6273 and ZET9172.
> 
> It supports ACPI and device tree enumeration. For ACPI you need ACPI
> 5.1+ in order to be able to use named GPIOs.
> 
> Screen resolution, the maximum number of fingers supported,
> if the touchscreen has hardware keys are configurable
> using ACPI/DT properties.
> 
> Signed-off-by: Bogdan George Stefan <bogdan.g.stefan@intel.com>
> ---
> Changes since v1:
> 
> Implemented most changes following Dmitry Torokhov's recommendations
> from https://lkml.org/lkml/2015/5/15/319
> The only things I kept are described below in the Notes section.
> - fixed style issues
> - reset is activated when gpio is set to high
> - switched from i2c_transfer to i2c_master_recv/i2c_master_send
> - removed redundant evbit initialization. However EV_ABS still needs
> to be reported and it is set through input_set_capability
> - replaced usleep_range with msleep where neede. Checking the patch
> with -strict will report an issue on this. Hope this is not a problem
> - fixed casts in zet_process_events
> - removed  client->irq = gpiod_to_irq(ts->irq); from probe
> - moved firmware loading from probe to open
> - used proper casts in zet_suspend
> - dropped zet_ts_remove as it was doing unnecesary things
> Notes:
> - I've kept the flags IRQF_TRIGGER_FALLING | IRQF_ONESHOT when calling
> devm_request_threaded_irq. No the irq handler is not called whn only IRQF_ONESHOT
> is used. Looking at other drivers, I saw that they use the same aproach. I am not
> sure how to setup things in ACPI/DT so that the driver could work only with IRQF_ONESHOT

Hmm, Rafael, do ACPI systems automatically set up IRQ triggers,
similarly to what OF systems do (based on device tree data)?

> - The number of thingers that can simultaneously touch the device and if it has
> HW keys or not, cannot be read from the device. I've asked Zeitec on this.

According to a random Zeitec datasheet I found on the web you send 0xB2
command to the device to retrieve buch of information, including number
of fingers and whether keys are supported.

Thanks.

-- 
Dmitry
