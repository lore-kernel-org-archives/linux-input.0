From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2 6/9] Input: psmouse - add support for SMBus companions
Date: Mon, 3 Apr 2017 18:04:06 +0200
Message-ID: <20170403160406.GA1715@mail.corp.redhat.com>
References: <20170310230114.788-1-dmitry.torokhov@gmail.com>
 <20170310230114.788-7-dmitry.torokhov@gmail.com>
 <20170331093705.GL22683@mail.corp.redhat.com>
 <20170401172222.GK17130@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751803AbdDCQEN (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 3 Apr 2017 12:04:13 -0400
Content-Disposition: inline
In-Reply-To: <20170401172222.GK17130@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Apr 01 2017 or thereabouts, Dmitry Torokhov wrote:
> On Fri, Mar 31, 2017 at 11:37:05AM +0200, Benjamin Tissoires wrote:
> > Hi Dmitry,
> > 
> > On Mar 10 2017 or thereabouts, Dmitry Torokhov wrote:
> > > From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > 
> > > This provides glue between PS/2 devices that enumerate the RMI4 devices
> > > and Elan touchpads to the RMI4 (or Elan) SMBus driver.
> > > 
> > > The SMBus devices keep their PS/2 connection alive. If the initialization
> > > process goes too far (psmouse_activate called), the device disconnects
> > > from the I2C bus and stays on the PS/2 bus, that is why we explicitly
> > > disable PS/2 device reporting (by calling psmouse_deactivate) before
> > > trying to register SMBus companion device.
> > > 
> > > The HID over I2C devices are enumerated through the ACPI DSDT, and
> > > their PS/2 device also exports the InterTouch bit in the extended
> > > capability 0x0C. However, the firmware keeps its I2C connection open
> > > even after going further in the PS/2 initialization. We don't need
> > > to take extra precautions with those device, especially because they
> > > block their PS/2 communication when HID over I2C is used.
> > > 
> > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > ---
> > >  drivers/input/mouse/Kconfig         |   4 +
> > >  drivers/input/mouse/Makefile        |   2 +
> > >  drivers/input/mouse/psmouse-base.c  |  16 +-
> > >  drivers/input/mouse/psmouse-smbus.c | 291 ++++++++++++++++++++++++++++++++++++
> > >  drivers/input/mouse/psmouse.h       |  37 +++++
> > >  5 files changed, 348 insertions(+), 2 deletions(-)
> > >  create mode 100644 drivers/input/mouse/psmouse-smbus.c
> > > 
> > > diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
> > > index 096abb4ad5cd..87bde8a210c7 100644
> > > --- a/drivers/input/mouse/Kconfig
> > > +++ b/drivers/input/mouse/Kconfig
> > > @@ -171,6 +171,10 @@ config MOUSE_PS2_VMMOUSE
> > >  
> > >  	  If unsure, say N.
> > >  
> > > +config MOUSE_PS2_SMBUS
> > > +	bool
> > > +	depends on MOUSE_PS2
> > > +
> > >  config MOUSE_SERIAL
> > >  	tristate "Serial mouse"
> > >  	select SERIO
> > > diff --git a/drivers/input/mouse/Makefile b/drivers/input/mouse/Makefile
> > > index 6168b134937b..56bf0ad877c6 100644
> > > --- a/drivers/input/mouse/Makefile
> > > +++ b/drivers/input/mouse/Makefile
> > > @@ -39,6 +39,8 @@ psmouse-$(CONFIG_MOUSE_PS2_TOUCHKIT)	+= touchkit_ps2.o
> > >  psmouse-$(CONFIG_MOUSE_PS2_CYPRESS)	+= cypress_ps2.o
> > >  psmouse-$(CONFIG_MOUSE_PS2_VMMOUSE)	+= vmmouse.o
> > >  
> > > +psmouse-$(CONFIG_MOUSE_PS2_SMBUS)	+= psmouse-smbus.o
> > > +
> > >  elan_i2c-objs := elan_i2c_core.o
> > >  elan_i2c-$(CONFIG_MOUSE_ELAN_I2C_I2C)	+= elan_i2c_i2c.o
> > >  elan_i2c-$(CONFIG_MOUSE_ELAN_I2C_SMBUS)	+= elan_i2c_smbus.o
> > > diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
> > > index 40f09ce84f14..bdb48b2acc57 100644
> > > --- a/drivers/input/mouse/psmouse-base.c
> > > +++ b/drivers/input/mouse/psmouse-base.c
> > > @@ -1996,16 +1996,27 @@ static int __init psmouse_init(void)
> > >  	synaptics_module_init();
> > >  	hgpk_module_init();
> > >  
> > > +	err = psmouse_smbus_module_init();
> > > +	if (err)
> > > +		return err;
> > > +
> > >  	kpsmoused_wq = alloc_ordered_workqueue("kpsmoused", 0);
> > >  	if (!kpsmoused_wq) {
> > >  		pr_err("failed to create kpsmoused workqueue\n");
> > > -		return -ENOMEM;
> > > +		err = -ENOMEM;
> > > +		goto err_smbus_exit;
> > >  	}
> > >  
> > >  	err = serio_register_driver(&psmouse_drv);
> > >  	if (err)
> > > -		destroy_workqueue(kpsmoused_wq);
> > > +		goto err_destroy_wq;
> > >  
> > > +	return 0;
> > > +
> > > +err_destroy_wq:
> > > +	destroy_workqueue(kpsmoused_wq);
> > > +err_smbus_exit:
> > > +	psmouse_smbus_module_exit();
> > >  	return err;
> > >  }
> > >  
> > > @@ -2013,6 +2024,7 @@ static void __exit psmouse_exit(void)
> > >  {
> > >  	serio_unregister_driver(&psmouse_drv);
> > >  	destroy_workqueue(kpsmoused_wq);
> > > +	psmouse_smbus_module_exit();
> > >  }
> > >  
> > >  module_init(psmouse_init);
> > > diff --git a/drivers/input/mouse/psmouse-smbus.c b/drivers/input/mouse/psmouse-smbus.c
> > > new file mode 100644
> > > index 000000000000..cc716977fbf9
> > > --- /dev/null
> > > +++ b/drivers/input/mouse/psmouse-smbus.c
> > > @@ -0,0 +1,291 @@
> > > +/*
> > > + * Copyright (c) 2017 Red Hat, Inc
> > > + *
> > > + * This program is free software; you can redistribute it and/or modify it
> > > + * under the terms of the GNU General Public License version 2 as published by
> > > + * the Free Software Foundation.
> > > + */
> > > +
> > > +#define pr_fmt(fmt)		KBUILD_MODNAME ": " fmt
> > > +
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/libps2.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/serio.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/workqueue.h>
> > > +#include "psmouse.h"
> > > +
> > > +struct psmouse_smbus_dev {
> > > +	struct i2c_board_info board;
> > > +	struct psmouse *psmouse;
> > > +	struct i2c_client *client;
> > > +	struct list_head node;
> > > +	bool dead;
> > > +};
> > > +
> > > +static LIST_HEAD(psmouse_smbus_list);
> > > +static DEFINE_MUTEX(psmouse_smbus_mutex);
> > > +
> > > +static void psmouse_smbus_check_adapter(struct i2c_adapter *adapter)
> > > +{
> > > +	struct psmouse_smbus_dev *smbdev;
> > > +
> > > +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_HOST_NOTIFY))
> > > +		return;
> > > +
> > > +	mutex_lock(&psmouse_smbus_mutex);
> > > +
> > > +	list_for_each_entry(smbdev, &psmouse_smbus_list, node) {
> > > +		if (smbdev->dead)
> > > +			continue;
> > > +
> > > +		if (smbdev->client)
> > > +			continue;
> > > +
> > > +		if (i2c_probe_func_quick_read(adapter, smbdev->board.addr) < 0)
> > > +			continue;
> > > +
> > > +		/* Device seems to be there, let's try switching over */
> > > +		psmouse_dbg(smbdev->psmouse,
> > > +			    "SMBus companion appeared, triggering rescan\n");
> > > +		serio_rescan(smbdev->psmouse->ps2dev.serio);
> > > +	}
> > > +
> > > +	mutex_unlock(&psmouse_smbus_mutex);
> > > +}
> > > +
> > > +static void psmouse_smbus_detach_i2c_client(struct i2c_client *client)
> > > +{
> > > +	struct psmouse_smbus_dev *smbdev;
> > > +
> > > +	mutex_lock(&psmouse_smbus_mutex);
> > > +
> > > +	list_for_each_entry(smbdev, &psmouse_smbus_list, node) {
> > > +		if (smbdev->client == client) {
> > > +			psmouse_dbg(smbdev->psmouse,
> > > +				    "Marking SMBus companion %s as gone\n",
> > > +				    dev_name(&smbdev->client->dev));
> > > +			smbdev->client = NULL;
> > > +			smbdev->dead = true;
> > > +			serio_rescan(smbdev->psmouse->ps2dev.serio);
> > > +		}
> > > +	}
> > > +
> > > +	kfree(client->dev.platform_data);
> > > +	client->dev.platform_data = NULL;
> > 
> > I realized (thanks to an oops) that this is a little bit too much :)
> > 
> > We are freeing whatever platform_data for *all* I2C devices :/
> 
> Doh!
> 
> > 
> > I would say the following patch should be working, but I haven't spent too
> > much time on it yet:
> > 
> > ---
> > 
> > diff --git a/drivers/input/mouse/psmouse-smbus.c b/drivers/input/mouse/psmouse-smbus.c
> > index 061c1cc..b77263e 100644
> > --- a/drivers/input/mouse/psmouse-smbus.c
> > +++ b/drivers/input/mouse/psmouse-smbus.c
> > @@ -61,24 +61,30 @@ static void psmouse_smbus_check_adapter(struct i2c_adapter *adapter)
> >  
> >  static void psmouse_smbus_detach_i2c_client(struct i2c_client *client)
> >  {
> > -	struct psmouse_smbus_dev *smbdev;
> > +	struct psmouse_smbus_dev *smbdev, *tmp;
> >  
> >  	mutex_lock(&psmouse_smbus_mutex);
> >  
> > -	list_for_each_entry(smbdev, &psmouse_smbus_list, node) {
> > +	list_for_each_entry_safe(smbdev, tmp, &psmouse_smbus_list, node) {
> >  		if (smbdev->client == client) {
> >  			psmouse_dbg(smbdev->psmouse,
> >  				    "Marking SMBus companion %s as gone\n",
> >  				    dev_name(&smbdev->client->dev));
> >  			smbdev->client = NULL;
> >  			smbdev->dead = true;
> > +
> > +			kfree(client->dev.platform_data);
> > +			client->dev.platform_data = NULL;
> 
> The client may continue using platform data until it dies, so we can't
> do it here.
> 
> > +
> > +			mutex_lock(&psmouse_smbus_mutex);
> > +			list_del(&smbdev->node);
> > +			mutex_unlock(&psmouse_smbus_mutex);
> 
> There is double-lock right here.

Ouch

> 
> > +
> > +			kfree(smbdev);
> >  			serio_rescan(smbdev->psmouse->ps2dev.serio);
> 
> And use-after-free...

Doh!

Clearly not tested enough :)

Thanks for pushing out a better patch.

Cheers,
Benjamin

> 
> >  		}
> >  	}
> >  
> > -	kfree(client->dev.platform_data);
> > -	client->dev.platform_data = NULL;
> > -
> >  	mutex_unlock(&psmouse_smbus_mutex);
> >  }
> >  
> > @@ -161,17 +167,19 @@ static void psmouse_smbus_disconnect(struct psmouse *psmouse)
> >  {
> >  	struct psmouse_smbus_dev *smbdev = psmouse->private;
> >  
> > -	mutex_lock(&psmouse_smbus_mutex);
> > -	list_del(&smbdev->node);
> > -	mutex_unlock(&psmouse_smbus_mutex);
> > -
> >  	if (smbdev->client) {
> >  		psmouse_dbg(smbdev->psmouse,
> >  			    "posting removal request for SMBus companion %s\n",
> >  			    dev_name(&smbdev->client->dev));
> >  		psmouse_smbus_schedule_remove(smbdev->client);
> > +		psmouse->private = NULL;
> > +		return;
> >  	}
> >  
> > +	mutex_lock(&psmouse_smbus_mutex);
> > +	list_del(&smbdev->node);
> > +	mutex_unlock(&psmouse_smbus_mutex);
> > +
> >  	kfree(smbdev);
> >  	psmouse->private = NULL;
> >  }
> > 
> > ---
> > 
> > I am just dumping my diff that seems to be OK here. Feel free to
> > integrate in a proper patch or wait next week for a more formal
> > submission from me.
> 
> I think we simply need a 2nd list with "dead" smbclient, let me see if I
> can write something.
> 
> Thanks.
> 
> -- 
> Dmitry
