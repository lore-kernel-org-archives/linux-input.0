From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH RFC] HID: cp2112: add IRQ chip handling
Date: Mon, 28 Nov 2016 14:45:54 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1611281445290.29400@cbobk.fhfr.pm>
References: <1479726474-31532-1-git-send-email-benjamin.tissoires@redhat.com> <CAAj6DX28iTuSxs5igUXJc3SoXPmdPwpf_ZQ98vaqfpKSum6G0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39672 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932908AbcK1Np5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 28 Nov 2016 08:45:57 -0500
In-Reply-To: <CAAj6DX28iTuSxs5igUXJc3SoXPmdPwpf_ZQ98vaqfpKSum6G0A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Borneo <borneo.antonio@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ellen Wang <ellen@cumulusnetworks.com>, David Barksdale <dbarksdale@uplogix.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sat, 26 Nov 2016, Antonio Borneo wrote:

> > I am currently running this patch in my local tree.
> > It allows to attach a SMBus device completely on the CP2112, with a simple
> > definition at the end of probe:
> >
> >         {
> >                 struct i2c_client *client;
> >                 struct i2c_hid_platform_data pdata = {
> >                         .hid_descriptor_address = 0x20,
> >                 };
> >                 struct i2c_board_info synaptics_info = {
> >                         I2C_BOARD_INFO("hid", 0x2c),
> >                         .platform_data = &pdata,
> >                 };
> >                 int irq = cp2112_allocate_irq(dev, 2);
> >
> >                 if (irq <= 0) {
> >                         dev_err(dev->gc.parent, "Failed to translate GPIO to IRQ\n");
> >                         goto err_sysfs_remove;
> >                 }
> >
> >                 synaptics_info.irq = irq;
> >                 irq_set_irq_type(irq, IRQ_TYPE_LEVEL_LOW);
> >
> >                 hid_device_io_start(hdev);
> >
> >                 /* give time for the device to initialize */
> >                 msleep(500);
> >
> >                 client = i2c_new_device(&dev->adap, &synaptics_info);
> >                 if (!client)
> >                         hid_err(hdev, "failed allocating Synaptics device\n");
> >
> >         }
> >
> > I wonder if we want to consider this upstream, given that the driver is only
> > used for development.
> 
> Ciao Benjamin,
> 
> for me it makes sense to push it upstream.
> I also coded something similar 2+ years ago, but then my cp2112 got
> broken before I could clean-up and submit the patches.
> As far as I remember, Ellen was using cp2112 in a system in production.
> For sure this driver is not widely used, but definitively it's not for
> development use only.

I've queued this in for-4.10/cp2112. Thanks,

-- 
Jiri Kosina
SUSE Labs

