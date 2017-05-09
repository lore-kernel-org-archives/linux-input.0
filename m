From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: i2c: Call acpi_device_fix_up_power for
 ACPI-enumerated devices
Date: Tue, 9 May 2017 10:57:46 +0200
Message-ID: <20170509085746.GF19130@mail.corp.redhat.com>
References: <20170507214914.6013-1-hdegoede@redhat.com>
 <20170509071231.GA19130@mail.corp.redhat.com>
 <17ecd9cc-e802-ca85-1fe5-6814fa2007f3@redhat.com>
 <20170509073618.GC19130@mail.corp.redhat.com>
 <20f11f8a-2649-9ffa-6dd2-51efc5dedde1@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41722 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750969AbdEII5y (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 9 May 2017 04:57:54 -0400
Content-Disposition: inline
In-Reply-To: <20f11f8a-2649-9ffa-6dd2-51efc5dedde1@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-acpi <linux-acpi@vger.kernel.org>

On May 09 2017 or thereabouts, Hans de Goede wrote:
> Hi,
> 
> On 09-05-17 09:36, Benjamin Tissoires wrote:
> > On May 09 2017 or thereabouts, Hans de Goede wrote:
> > > Hi,
> > > 
> > > On 09-05-17 09:12, Benjamin Tissoires wrote:
> > > > Hi Hans,
> > > > 
> > > > On May 07 2017 or thereabouts, Hans de Goede wrote:
> > > > > ACPI devices which do not have a _PSC method are assumed to have been
> > > > > put in D0 by the BIOS, but for touchscreens that is not always true,
> > > > > so call acpi_device_fix_up_power to explicitly put devices without a
> > > > > _PSC method into D0 state.
> > > > > 
> > > > > This fixes the SIS0817 i2c-hid touchscreen on a Peaq C1010 2-in-1
> > > > > device failing to probe with a "hid_descr_cmd failed" error.
> > > > > 
> > > > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > > > > ---
> > > > >    drivers/hid/i2c-hid/i2c-hid.c | 13 +++++++++++++
> > > > >    1 file changed, 13 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> > > > > index ea3c3546cef7..c716d9605940 100644
> > > > > --- a/drivers/hid/i2c-hid/i2c-hid.c
> > > > > +++ b/drivers/hid/i2c-hid/i2c-hid.c
> > > > > @@ -960,6 +960,15 @@ static int i2c_hid_acpi_pdata(struct i2c_client *client,
> > > > >    	return 0;
> > > > >    }
> > > > > +static void i2c_hid_acpi_fix_up_power(struct device *dev)
> > > > > +{
> > > > > +	acpi_handle handle = ACPI_HANDLE(dev);
> > > > > +	struct acpi_device *adev;
> > > > > +
> > > > > +	if (handle && acpi_bus_get_device(handle, &adev) == 0)
> > > > > +		acpi_device_fix_up_power(adev);
> > > > 
> > > > I am wondering if this is not something that should be handled by
> > > > acpi-core or i2c-core. Looks like something pretty generic.
> > > 
> > > The acpi-core deliberately does not do this, as unconditionally
> > > doing this for all devices is known to break things on some
> > > platforms, see:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7cd8407
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b9e95fc65eded
> > > 
> > > So calling this is something which needs to be done an a device-by-device
> > > (usually actually on a driver-by-driver) basis.
> > > 
> > > I don't expect this to cause any problems for i2c-hid devices
> > > (as the above commits shown once it was done for all ACPI enumerated devices)
> > > and it is necessary for some i2c-hid devices.
> > > 
> > > > Also, isn't this also needed on resume (or reset_resume)?
> > > 
> > > After a suspend the device is in D3, so we will always execute _PS0
> > > to put it back in D0. This is about devices without a _PSC method
> > > (which allows querying the actual state) being in D3 on boot, rather
> > > then the expected (and assumed) D0. Note that for devices with a _PSC
> > > method calling acpi_device_fix_up_power() is a nop.
> > > 
> > 
> > Thanks for the extensive explanations.
> > 
> > Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> Thank you.
> 
> > Maybe we can add this to the commit message for future reference?
> 
> Ok, I'm about to send a v2 with an improved commit msg:
> 
> "For ACPI devices which do not have a _PSC method, the ACPI subsys cannot
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
> device failing to probe with a "hid_descr_cmd failed" error."

Works for me.

Thanks for the quick respin.

Cheers,
Benjamin

> 
> Regards,
> 
> Hans
> 
> 
> > 
> > Cheers,
> > Benjamin
> > 
> > > Regards,
> > > 
> > > Hans
> > > 
> > > > > +}
> > > > > +
> > > > >    static const struct acpi_device_id i2c_hid_acpi_match[] = {
> > > > >    	{"ACPI0C50", 0 },
> > > > >    	{"PNP0C50", 0 },
> > > > > @@ -972,6 +981,8 @@ static inline int i2c_hid_acpi_pdata(struct i2c_client *client,
> > > > >    {
> > > > >    	return -ENODEV;
> > > > >    }
> > > > > +
> > > > > +static inline void i2c_hid_acpi_fix_up_power(struct device *dev) {}
> > > > >    #endif
> > > > >    #ifdef CONFIG_OF
> > > > > @@ -1070,6 +1081,8 @@ static int i2c_hid_probe(struct i2c_client *client,
> > > > >    	if (ret < 0)
> > > > >    		goto err;
> > > > > +	i2c_hid_acpi_fix_up_power(&client->dev);
> > > > > +
> > > > >    	pm_runtime_get_noresume(&client->dev);
> > > > >    	pm_runtime_set_active(&client->dev);
> > > > >    	pm_runtime_enable(&client->dev);
> > > > > -- 
> > > > > 2.12.2
> > > > > 
