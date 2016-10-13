From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] Revert "HID: i2c-hid: Add support for ACPI GPIO
 interrupts"
Date: Thu, 13 Oct 2016 13:24:45 +0300
Message-ID: <20161013102445.GP2774@lahna.fi.intel.com>
References: <1476351045-8829-1-git-send-email-benjamin.tissoires@redhat.com>
 <1476351045-8829-2-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:41494 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753676AbcJMK1z (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 13 Oct 2016 06:27:55 -0400
Content-Disposition: inline
In-Reply-To: <1476351045-8829-2-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, David Arcari <darcari@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Oct 13, 2016 at 11:30:44AM +0200, Benjamin Tissoires wrote:
> From: David Arcari <darcari@redhat.com>
> 
> This reverts commit a485923efbb8 ("HID: i2c-hid: Add support for ACPI
> GPIO interrupts") and commit a7d2bf25a483 ("HID: i2c-hid: Do not fail
> probing if gpiolib is not enabled") at the same time.
> 
> Since commit c884fbd45214 ("gpio / ACPI: Add support for retrieving
> GpioInt resources from a device") i2c_core already set the IRQ by
> looking into the ACPI tree and retrieving the gpioInt. So we just
> have some boiler-plate here that is not needed anymore.
> 
> The only downside effect here is that now we are not exiting early
> enough if the irq is set to -EPROBE_DEFER or any other error, but
> this is going to be fixed in the following patch.
> 
> Signed-off-by: David Arcari <darcari@redhat.com>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

I went through my collection of ACPI dumps from different machines and I
did not find anything using plain GpioIo() resource. So I think this
should be safe thing to do.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
