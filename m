From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 0/2] HID: i2c-hid: Do not register i2c_hid_driver on
 devices with a CHPN0001 touchscreen
Date: Tue, 27 Jun 2017 14:48:45 +0200
Message-ID: <20170627124845.GD26073@mail.corp.redhat.com>
References: <20170618101448.17734-1-hdegoede@redhat.com>
 <alpine.LSU.2.20.1706271426140.30709@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59042 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751453AbdF0Msw (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 27 Jun 2017 08:48:52 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.1706271426140.30709@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Jun 27 2017 or thereabouts, Jiri Kosina wrote:
> On Sun, 18 Jun 2017, Hans de Goede wrote:
> 
> > Hi Jiri, Benjamin,
> > 
> > As discussed with myself in the linux-input thread about adding
> > icn8505 (ACPI HID CHPN0001) devices to the icn8313 driver:
> > https://www.spinics.net/lists/linux-input/msg51916.html
> > 
> > Unfortunately the ACPI node for this non HID compatible device has an
> > ACPI CID (compatility ID) of PNP0C50 causing the i2c-hid driver to bind,
> > which leads to the touchscreen not working (see the second patch
> > commit message for details).
> > 
> > Although these 2 patches are not really pretty I believe they are the
> > best way to fix this.
> > 
> > Note that even if I do add firmware upload support to the icn8318 driver,
> > we still have the issue left of i2c-hid doing a
> > dev_err(dev, "hid_descr_cmd failed") which is also undesirable.
> > 
> > A normal system bootup should have no output for "dmesg --level=err",
> > this is esp. important for the flickerfree boot experience both Fedora
> > and Ubuntu have been working towards. Any _err kernel messages will
> > cause the splash screen to drop back to text-mode breaking the
> > flickerfree experience. So to silence that error we would need to
> > blacklist the CHPN0001 ACPI HID somewhere in the i2c-hid driver
> > anyways.
> 
> Benjamin, as i2c-hid is mainly your playground, would you mind (n)Acking 
> this? :)
> 

Sorry, I should have replied here too.

I still maintain: http://www.spinics.net/lists/linux-input/msg51961.html
So unless we have some new elements, I am NAcking this patch.

Cheers,
Benjamin

> Thanks,
> 
> -- 
> Jiri Kosina
> SUSE Labs
> 
