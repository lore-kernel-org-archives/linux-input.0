From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2 6/9] Input: psmouse - add support for SMBus companions
Date: Mon, 13 Mar 2017 12:01:59 +0100
Message-ID: <20170313110159.GG4378@mail.corp.redhat.com>
References: <20170310230114.788-1-dmitry.torokhov@gmail.com>
 <20170310230114.788-7-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751409AbdCMLCF (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 13 Mar 2017 07:02:05 -0400
Content-Disposition: inline
In-Reply-To: <20170310230114.788-7-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Mar 10 2017 or thereabouts, Dmitry Torokhov wrote:
> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> This provides glue between PS/2 devices that enumerate the RMI4 devices
> and Elan touchpads to the RMI4 (or Elan) SMBus driver.
> 
> The SMBus devices keep their PS/2 connection alive. If the initialization
> process goes too far (psmouse_activate called), the device disconnects
> from the I2C bus and stays on the PS/2 bus, that is why we explicitly
> disable PS/2 device reporting (by calling psmouse_deactivate) before
> trying to register SMBus companion device.
> 
> The HID over I2C devices are enumerated through the ACPI DSDT, and
> their PS/2 device also exports the InterTouch bit in the extended
> capability 0x0C. However, the firmware keeps its I2C connection open
> even after going further in the PS/2 initialization. We don't need
> to take extra precautions with those device, especially because they
> block their PS/2 communication when HID over I2C is used.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Actually, one thing I noticed but forgot to say in my previous email:

If you call rescan from the sysfs, there is a chance the i2c device is
still there while we are trying to reconnect the device. Which means
that we fail at creating the i2c device, and then fall back on PS/2.

It's not a big issue, but still it will show some warning in the dmesg
while attempting to create some sysfs files that already exist.

S solution could be to unlock the mutexes and wait for the termination
of i2c_unregister_device, but I would believe the best approach would be
to remove the mutexes in serio and psmouse, and directly call
i2c_unregister_device in .disconnect.

Cheers,
Benjamin


