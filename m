From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 0/2] HID: i2c-hid: Do not register i2c_hid_driver on
 devices with a CHPN0001 touchscreen
Date: Tue, 27 Jun 2017 14:26:43 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1706271426140.30709@cbobk.fhfr.pm>
References: <20170618101448.17734-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34374 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752320AbdF0M0q (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 27 Jun 2017 08:26:46 -0400
In-Reply-To: <20170618101448.17734-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Sun, 18 Jun 2017, Hans de Goede wrote:

> Hi Jiri, Benjamin,
> 
> As discussed with myself in the linux-input thread about adding
> icn8505 (ACPI HID CHPN0001) devices to the icn8313 driver:
> https://www.spinics.net/lists/linux-input/msg51916.html
> 
> Unfortunately the ACPI node for this non HID compatible device has an
> ACPI CID (compatility ID) of PNP0C50 causing the i2c-hid driver to bind,
> which leads to the touchscreen not working (see the second patch
> commit message for details).
> 
> Although these 2 patches are not really pretty I believe they are the
> best way to fix this.
> 
> Note that even if I do add firmware upload support to the icn8318 driver,
> we still have the issue left of i2c-hid doing a
> dev_err(dev, "hid_descr_cmd failed") which is also undesirable.
> 
> A normal system bootup should have no output for "dmesg --level=err",
> this is esp. important for the flickerfree boot experience both Fedora
> and Ubuntu have been working towards. Any _err kernel messages will
> cause the splash screen to drop back to text-mode breaking the
> flickerfree experience. So to silence that error we would need to
> blacklist the CHPN0001 ACPI HID somewhere in the i2c-hid driver
> anyways.

Benjamin, as i2c-hid is mainly your playground, would you mind (n)Acking 
this? :)

Thanks,

-- 
Jiri Kosina
SUSE Labs

