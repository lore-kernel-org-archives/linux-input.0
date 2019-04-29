From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [Bug 203297] Synaptics touchpad TM-3127 functionality broken by
 PCI runtime power management patch on 4.20.2
Date: Mon, 29 Apr 2019 09:04:05 +0200
Message-ID: <CAJZ5v0iYYJBR77R51y1hVKsBQDmUpv5_dtSqMMiCoEZgC5cX=g@mail.gmail.com>
References: <20190422130814.GJ173520@google.com> <3a1139ef-10ed-6923-73c5-30fbf0c065c3@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3a1139ef-10ed-6923-73c5-30fbf0c065c3@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Keijo Vaara <ferdasyn@rocketmail.com>, Jean Delvare <jdelvare@suse.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux PM <linux-pm@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Apr 26, 2019 at 2:14 PM Jarkko Nikula
<jarkko.nikula@linux.intel.com> wrote:
>
> On 4/22/19 4:08 PM, Bjorn Helgaas wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=203297
> >
> > Regression, suspected but as yet unconfirmed cause:
> >
> >    c5eb1190074c ("PCI / PM: Allow runtime PM without callback functions")
> >
> > backported to 4.20 stable as 39e1be324c2f.
> >
> With help of Keijo it was confirmed above patch broke the Synaptics
> touchpad. Not bisected but touchpad works again by forcing the i2c-i801
> SMBus controller always on:
> "echo on >/sys/bus/pci/devices/0000\:00\:1f.3/power/control"
>
> Above patch is a generalized fix that fixed the runtime PM regression on
> i2c-i801 and re-allow the controller go to runtime suspend when idle. So
> most probably Synaptics touchpad was broken by i2c-i801 runtime PM also
> before but got unnoticed. Which is easy since on many platforms SMBus
> controller doesn't necessarily have the PCI PM capabilities.
>
> I would like to ask help from input subsystem experts what kind of SMBus
> power state dependency Synaptics RMI4 SMBus devices have since it cease
> to work if SMBus controllers idles between transfers and how this is
> best to fix?
>
> Instead of revert I think we'd need to have some method to force SMBus
> controller on whenever the touchpad is active, like when there is a
> userspace listening.
>
> I'm not expert in this area so as quick proof of concept I had a
> following hack which forces the I2C/SMBus adapter, and eventually the
> parent PCI device of it on when the RMI4 SMBus device is probed and let
> the SMBus controller to idle when removed.
>
> According to Keijo it fixes the issue but I like to hear input experts
> for better place to put these.
>
> diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
> index b6ccf39c6a7b..2b11d69be313 100644
> --- a/drivers/input/rmi4/rmi_smbus.c
> +++ b/drivers/input/rmi4/rmi_smbus.c
> @@ -16,6 +16,7 @@
>   #include <linux/lockdep.h>
>   #include <linux/module.h>
>   #include <linux/pm.h>
> +#include <linux/pm_runtime.h>
>   #include <linux/rmi.h>
>   #include <linux/slab.h>
>   #include "rmi_driver.h"
> @@ -332,6 +333,9 @@ static int rmi_smb_probe(struct i2c_client *client,
>
>         dev_info(&client->dev, "registering SMbus-connected sensor\n");
>
> +       /* Force SMBus adapter on while RMI4 device is connected */
> +       pm_runtime_get(&client->adapter->dev);

That should be pm_runtime_get_sync() IMO.

Otherwise, the rmi_register_transport_device() may be called before
completing the PM transition.

> +
>         error = rmi_register_transport_device(&rmi_smb->xport);
>         if (error) {
>                 dev_err(&client->dev, "failed to register sensor: %d\n", error);
> @@ -346,6 +350,7 @@ static int rmi_smb_remove(struct i2c_client *client)
>         struct rmi_smb_xport *rmi_smb = i2c_get_clientdata(client);
>
>         rmi_unregister_transport_device(&rmi_smb->xport);
> +       pm_runtime_put(&client->adapter->dev);
>
>         return 0;
>   }
>
> --
> Jarkko
