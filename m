From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: i2c-hid: Add no-irq-after-reset quirk for
 0911:5288 device
Date: Thu, 9 Nov 2017 12:51:52 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1711091251370.32604@cbobk.fhfr.pm>
References: <20171107122800.23196-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47472 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752066AbdKILvx (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 9 Nov 2017 06:51:53 -0500
In-Reply-To: <20171107122800.23196-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Tue, 7 Nov 2017, Hans de Goede wrote:

> Several cheap Apollo Lake based laptops / 2-in-1s use an i2c-hid mt
> touchpad which is advertised by the DSDT with an ACPI HID of "SYNA3602",
> this touchpad can be found on e.g. the Cube Thinker and the EZBook 3 Pro.
> 
> On my "T-bao Tbook air" the i2c-hid driver fails to bind to this touchpad:
> "i2c_hid i2c-SYNA3602:00: failed to reset device.".
> 
> After some debuging this it seems that this touchpad simply never sends
> an interrupt after a reset as expected by the i2c hid driver. This commit
> adds a quirk for this device, making i2c_hid_command sleep 100ms after
> a reset instead of waiting for an irq, fixing i2c-hid failing to bind to
> this touchpad.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to for-4.15/upstream. Thanks,

-- 
Jiri Kosina
SUSE Labs

