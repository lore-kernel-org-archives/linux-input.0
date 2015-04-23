From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: i2c-hid: Do not fail probing if gpiolib is not
 enabled
Date: Thu, 23 Apr 2015 10:58:59 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1504231058450.3695@pobox.suse.cz>
References: <7007524.JGeOHMMZVW@xps13> <1429022112-231578-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42222 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755862AbbDWI7B (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Apr 2015 04:59:01 -0400
In-Reply-To: <1429022112-231578-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Gabriele Mazzotta <gabriele.mzt@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Tue, 14 Apr 2015, Mika Westerberg wrote:

> Using GPIOs and gpiolib is optional. If the kernel is compiled without GPIO
> support the driver should not fail if it finds the interrupt using normal
> methods.
> 
> However, commit a485923efbb8 ("HID: i2c-hid: Add support for ACPI GPIO
> interrupts") did not take into account that acpi_dev_add_driver_gpios()
> returns -ENXIO when !CONFIG_GPIOLIB.
> 
> Fix this by checking the return value against -ENXIO and 0 and only in that
> case fail the probe.
> 
> Reported-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

I have applied this to for-4.1/upstream-fixes.

-- 
Jiri Kosina
SUSE Labs
