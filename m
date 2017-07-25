From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 2/2] HID: i2c-hid: Do not bind to CHPN0001 touchscreen
Date: Tue, 25 Jul 2017 14:58:45 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1707251457190.4705@cbobk.fhfr.pm>
References: <20170722185537.12696-1-hdegoede@redhat.com> <20170722185537.12696-2-hdegoede@redhat.com> <20170724081928.GB18097@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52122 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750861AbdGYM6t (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 25 Jul 2017 08:58:49 -0400
In-Reply-To: <20170724081928.GB18097@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org

On Mon, 24 Jul 2017, Benjamin Tissoires wrote:

> > The CHPN0001 ACPI device has a _CID of PNP0C50 but is not HID compatible,
> > it uses its own protocol which is handled by the chipone_icn8318 driver.
> > 
> > If the i2c_hid_driver's probe functon gets called it will fail with a
> > "hid_descr_cmd failed" error.
> > 
> > Worse, after the probe failure the i2c / ACPI core code will put the ACPI
> > device in D3 state and when the chipone_icn8318 driver then loads the
> > device is put back in D0 state, executing its PS0 ACPI method, which
> > resets the controller, causing the controller to loose its firmware
> > which was loaded by the BIOS. The chipone_icn8318 driver has a workaround
> > for this, but that requires it to be the only (or the first) driver to
> > probe the device.
> > 
> > This commit adds a match callback and returns -ENODEV for i2c_client-s
> > with a CHPN0001 ACPI device id, so that the probe function never gets
> > called, fixing the controller losing its firmware.
> > 
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> > Changes in v2:
> > -Use the new i2c_driver match callback to only filter out the CHPN0001
> >  ACPI device, rather then use acpi_dev_present in probe and not
> >  registering the driver at all when the system has a CHPN0001 device
> 
> I like the v2 much more than the v1.
> 
> Reviewed-By: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Wolfram,

what do we do with this patchset? I think it makes sense for both patches 
to go in via one tree.

Either I can take it through hid.git with your Ack for the first patch, or 
vice versa. Please let me know what you'd prefer.

Thanks,

-- 
Jiri Kosina
SUSE Labs

