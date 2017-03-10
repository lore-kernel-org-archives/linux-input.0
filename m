From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 6/8] Input: psmouse - add support for SMBus companions
Date: Fri, 10 Mar 2017 10:16:15 -0800
Message-ID: <20170310181615.GD21811@dtor-ws>
References: <20170309221644.17035-1-dmitry.torokhov@gmail.com>
 <20170309235308.GI20077@dtor-ws>
 <20170310175509.GA1221@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32842 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755050AbdCJSQT (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 10 Mar 2017 13:16:19 -0500
Content-Disposition: inline
In-Reply-To: <20170310175509.GA1221@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

On Fri, Mar 10, 2017 at 06:55:09PM +0100, Benjamin Tissoires wrote:
> On Mar 09 2017 or thereabouts, Dmitry Torokhov wrote:
> > From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > 
> > This provides glue between PS/2 devices that enumerate the RMI4 devices
> > and Elan touchpads to the RMI4 (or Elan) SMBus driver.
> > 
> > The SMBus devices keep their PS/2 connection alive. If the initialization
> > process goes too far (psmouse_activate called), the device disconnects
> > from the I2C bus and stays on the PS/2 bus, that is why we explicitly
> > disable PS/2 device reporting (by calling psmouse_deactivate) before
> > trying to register SMBus companion device.
> > 
> > The HID over I2C devices are enumerated through the ACPI DSDT, and
> > their PS/2 device also exports the InterTouch bit in the extended
> > capability 0x0C. However, the firmware keeps its I2C connection open
> > even after going further in the PS/2 initialization. We don't need
> > to take extra precautions with those device, especially because they
> > block their PS/2 communication when HID over I2C is used.
> > 
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >
> 
> Hi Dmitry,
> 
> There is an issue with this patch. The platform_data provided by the
> caller of psmouse_smbus_init() may be dereference, leading to a dangling
> pointer on the stack in rmi4.
> 
> There is no guarantees rmi-smbus will get probed directly and even if it
> does, a later rmmod/modprobe might happen and won't have access to the
> platform data.
> 
> See below for a patch that solves this. Feel free to squash it, change it
> and remove the terrible commit message.
> 
> From a86f766de9c544a8d61da520719287c68a5f1bea Mon Sep 17 00:00:00 2001
> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Date: Fri, 10 Mar 2017 18:31:01 +0100
> Subject: [PATCH] Input: smbus companion - store the platform data for later
>  use
> 
> The platform data should be available as long as the i2c_device exists.
> In the current implementation, the platform data is allocated on the
> stack, which gives a dangling pointer to the i2c_client once
> psmouse_smbus_init() ends.
> 
> Duplicate the provided platform data in psmouse_smbus_init() so that
> the allocation/free of pdata is handled by psmouse-smbus.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/input/mouse/psmouse-smbus.c | 18 ++++++++++++++++--
>  drivers/input/mouse/psmouse.h       |  2 +-
>  drivers/input/mouse/synaptics.c     |  5 ++---
>  3 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/mouse/psmouse-smbus.c b/drivers/input/mouse/psmouse-smbus.c
> index 5bda551..6f603ec 100644
> --- a/drivers/input/mouse/psmouse-smbus.c
> +++ b/drivers/input/mouse/psmouse-smbus.c
> @@ -20,6 +20,7 @@
>  struct psmouse_smbus_dev {
>  	struct psmouse *psmouse;
>  	struct i2c_client *client;
> +	void *pdata;
>  	struct list_head node;
>  	unsigned short addr;
>  	bool dead;
> @@ -166,6 +167,7 @@ static void psmouse_smbus_disconnect(struct psmouse *psmouse)
>  		psmouse_smbus_schedule_remove(smbdev->client);
>  	}
>  
> +	kfree(smbdev->pdata);

We can 't do it here if we fired off a work to unregister i2c_client, as
it may still be referencing it. I guess we can do it in notifier code.
I'll update the patch.

Thanks.

-- 
Dmitry
