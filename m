From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: i2c: Call acpi_device_fix_up_power for
 ACPI-enumerated devices
Date: Mon, 29 May 2017 13:08:46 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1705291308280.26873@cbobk.fhfr.pm>
References: <20170509080436.19233-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41488 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750902AbdE2LIs (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 29 May 2017 07:08:48 -0400
In-Reply-To: <20170509080436.19233-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Tue, 9 May 2017, Hans de Goede wrote:

> For ACPI devices which do not have a _PSC method, the ACPI subsys cannot
> query their initial state at boot, so these devices are assumed to have
> been put in D0 by the BIOS, but for touchscreens that is not always true.
> 
> This commit adds a call to acpi_device_fix_up_power to explicitly put
> devices without a _PSC method into D0 state (for devices with a _PSC
> method it is a nop). Note we only need to do this on probe, after a
> resume the ACPI subsys knows the device is in D3 and will properly
> put it in D0.
> 
> This fixes the SIS0817 i2c-hid touchscreen on a Peaq C1010 2-in-1
> device failing to probe with a "hid_descr_cmd failed" error.
> 
> Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Improve commit msg
> -Add Benjamin's Acked-by

Applied to for-4.12/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

