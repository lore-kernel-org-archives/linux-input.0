From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v8 2/4] i2c-smbus: add SMBus Host Notify support
Date: Mon, 18 Jul 2016 18:35:19 +0200
Message-ID: <20160718163519.GT4663@mail.corp.redhat.com>
References: <1465484030-28838-1-git-send-email-benjamin.tissoires@redhat.com>
 <1465484030-28838-3-git-send-email-benjamin.tissoires@redhat.com>
 <20160718163109.4d2190e9@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49107 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751888AbcGRQfZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jul 2016 12:35:25 -0400
Content-Disposition: inline
In-Reply-To: <20160718163109.4d2190e9@endymion>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, Jonathan Corbet <corbet@lwn.net>, Corey Minyard <minyard@acm.org>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Jul 18 2016 or thereabouts, Jean Delvare wrote:
> Hi Benjamin, Wolfram,
> 
> Now that I have reviewed the i2c-i801 part of the implementation, I'm
> wondering...
> 
> On Thu,  9 Jun 2016 16:53:48 +0200, Benjamin Tissoires wrote:
> > +/**
> > + * i2c_setup_smbus_host_notify - Allocate a new smbus_host_notify for the given
> > + * I2C adapter.
> > + * @adapter: the adapter we want to associate a Host Notify function
> > + *
> > + * Returns a struct smbus_host_notify pointer on success, and NULL on failure.
> > + * The resulting smbus_host_notify must not be freed afterwards, it is a
> > + * managed resource already.
> > + */
> > +struct smbus_host_notify *i2c_setup_smbus_host_notify(struct i2c_adapter *adap)
> > +{
> > +	struct smbus_host_notify *host_notify;
> > +
> > +	host_notify = devm_kzalloc(&adap->dev, sizeof(struct smbus_host_notify),
> > +				   GFP_KERNEL);
> > +	if (!host_notify)
> > +		return NULL;
> > +
> > +	host_notify->adapter = adap;
> > +
> > +	spin_lock_init(&host_notify->lock);
> > +	INIT_WORK(&host_notify->work, smbus_host_notify_work);
> 
> Here we initialize a workqueue.
> 
> > +
> > +	return host_notify;
> > +}
> > +EXPORT_SYMBOL_GPL(i2c_setup_smbus_host_notify);
> > +
> > +/**
> > + * i2c_handle_smbus_host_notify - Forward a Host Notify event to the correct
> > + * I2C client.
> > + * @host_notify: the struct host_notify attached to the relevant adapter
> > + * @data: the Host Notify data which contains the payload and address of the
> > + * client
> > + * Context: can't sleep
> > + *
> > + * Helper function to be called from an I2C bus driver's interrupt
> > + * handler. It will schedule the Host Notify work, in turn calling the
> > + * corresponding I2C device driver's alert function.
> > + *
> > + * host_notify should be a valid pointer previously returned by
> > + * i2c_setup_smbus_host_notify().
> > + */
> > +int i2c_handle_smbus_host_notify(struct smbus_host_notify *host_notify,
> > +				 unsigned short addr, unsigned int data)
> > +{
> > +	unsigned long flags;
> > +	struct i2c_adapter *adapter;
> > +
> > +	if (!host_notify || !host_notify->adapter)
> > +		return -EINVAL;
> > +
> > +	adapter = host_notify->adapter;
> > +
> > +	spin_lock_irqsave(&host_notify->lock, flags);
> > +
> > +	if (host_notify->pending) {
> > +		spin_unlock_irqrestore(&host_notify->lock, flags);
> > +		dev_warn(&adapter->dev, "Host Notify already scheduled.\n");
> > +		return -EBUSY;
> > +	}
> > +
> > +	host_notify->payload = data;
> > +	host_notify->addr = addr;
> > +
> > +	/* Mark that there is a pending notification and release the lock */
> > +	host_notify->pending = true;
> > +	spin_unlock_irqrestore(&host_notify->lock, flags);
> > +
> > +	return schedule_work(&host_notify->work);
> 
> And here we use it.
> 
> > +}
> > +EXPORT_SYMBOL_GPL(i2c_handle_smbus_host_notify);
> 
> But what happens on i2c_adapter removal? What prevents the following
> sequence from happening?
> 
> 1* A Host Notify event happens.
> 2* The event is handled and queued by i2c_handle_smbus_host_notify().
> 3* Someone tears down the underlying i2c_adapter (for example "rmmod
>    i2c-i801".)
> 4* The workqueue is processed, accessing memory which has already been
>    freed.
> 
> Of course it would be back luck, but that's pretty much the definition
> of a race condition ;-)

Yes, you are right :(
Sorry for not doing things properly :/

> 
> To be on the safe side, don't we need a teardown function in i2c-smbus,
> that could be called before i2c_del_adapter, which would remove the
> host notify handle and flush the workqueue?

I was thinking at adding a devm action on the release of the struct
smbus_host_notify, but it's actually a bad idea because some other
resources (children moslty) might already be released when the devres
action will be called.

I think it might be easier to add a i2c_remove_host_notify() (or such)
which would make sure we call the cancel_work_sync() function. It would
be the responsibility of the caller to call it once
i2c_setup_smbus_host_notify() has been called. I'd say it has the
advantage of not adding any hidden data in the adapter to the cost of a
small pain in the adapter driver.

Cheers,
Benjamin

> 
> -- 
> Jean Delvare
> SUSE L3 Support
