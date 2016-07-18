From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v8 2/4] i2c-smbus: add SMBus Host Notify support
Date: Mon, 18 Jul 2016 17:59:02 +0200
Message-ID: <20160718155902.GS4663@mail.corp.redhat.com>
References: <1465484030-28838-1-git-send-email-benjamin.tissoires@redhat.com>
 <1465484030-28838-3-git-send-email-benjamin.tissoires@redhat.com>
 <20160718113721.2eaa86d3@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54466 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320AbcGRP7O (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jul 2016 11:59:14 -0400
Content-Disposition: inline
In-Reply-To: <20160718113721.2eaa86d3@endymion>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, Jonathan Corbet <corbet@lwn.net>, Corey Minyard <minyard@acm.org>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Jul 18 2016 or thereabouts, Jean Delvare wrote:
> [As it doesn't look like this message was delivered, I am sending it
> again. I apologize if this is a duplicate for some of you.]
> 
> Hi Benjamin, Wolfram,
> 
> Sorry for being late to the party. I finally found some time to look at
> the patches. Looks good overall, with just two minor comments:
> 
> On jeu., 2016-06-09 at 16:53 +0200, Benjamin Tissoires wrote:
> > SMBus Host Notify allows a slave device to act as a master on a bus to
> > notify the host of an interrupt. On Intel chipsets, the functionality
> > is directly implemented in the firmware. We just need to export a
> > function to call .alert() on the proper device driver.
> > 
> > i2c_handle_smbus_host_notify() behaves like i2c_handle_smbus_alert().
> > When called, it schedules a task that will be able to sleep to go through
> > the list of devices attached to the adapter.
> > 
> > The current implementation allows one Host Notification to be scheduled
> > while an other is running.
> > 
> > Tested-by: Andrew Duggan <aduggan@synaptics.com>
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > ---
> > (...)
> > diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
> > index 3b6765a..f574995 100644
> > --- a/drivers/i2c/i2c-smbus.c
> > +++ b/drivers/i2c/i2c-smbus.c
> > (...)
> > +/**
> > + * i2c_handle_smbus_host_notify - Forward a Host Notify event to the correct
> > + * I2C client.
> > + * @host_notify: the struct host_notify attached to the relevant adapter
> > + * @data: the Host Notify data which contains the payload and address of the
> > + * client
> 
> Doesn't look correct. The data parameter doesn't contain the address,
> that would be in the (undocumented) address parameter. I'll send a
> patch.

Thanks for the fixup patch already :)

> 
> > diff --git a/include/linux/i2c-smbus.h b/include/linux/i2c-smbus.h
> > index 8f1b086..4ac95bb 100644
> > --- a/include/linux/i2c-smbus.h
> > +++ b/include/linux/i2c-smbus.h
> > (...)
> > +#if IS_ENABLED(CONFIG_I2C_SMBUS)
> > +struct smbus_host_notify *i2c_setup_smbus_host_notify(struct i2c_adapter *adap);
> > +int i2c_handle_smbus_host_notify(struct smbus_host_notify *host_notify,
> > +				 unsigned short addr, unsigned int data);
> > +#else
> > +static inline struct smbus_host_notify *
> > +i2c_setup_smbus_host_notify(struct i2c_adapter *adap)
> > +{
> > +	return NULL;
> > +}
> > +
> > +static inline int
> > +i2c_handle_smbus_host_notify(struct smbus_host_notify *host_notify,
> > +			     unsigned short addr, unsigned int data)
> > +{
> > +	return 0;
> > +}
> > +#endif /* I2C_SMBUS */
> 
> You provide stubs for SMBus Host Notify support if CONFIG_I2C_SMBUS is
> not selected. There are no such stubs for SMBus Alert support, for which
> I assumed drivers would select I2C_SMBUS if they have support. Which is
> what you are actually doing for i2c-i801 in a latter patch.
> 
> Is there any reason for this difference? For consistency I'd rather
> provide stubs for all or none. My preference being for none, unless you
> have a use case which requires them.

Looks like you are right. There is no need for the stubs and they can be
dropped. I think I had them in the first place for a previous
implementation, and they just stayed here.

Given that you already sent a few cleanup patches, do you want to send
this fix also, or do you expect me to send it? (I don't think there will
be a conflict, so either is fine).


Cheers,
Benjamin

> 
> -- 
> Jean Delvare
> SUSE L3 Support
