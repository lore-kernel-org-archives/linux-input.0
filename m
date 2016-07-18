From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v8 2/4] i2c-smbus: add SMBus Host Notify support
Date: Mon, 18 Jul 2016 22:47:43 +0200
Message-ID: <20160718224743.01b4a330@endymion>
References: <1465484030-28838-1-git-send-email-benjamin.tissoires@redhat.com>
	<1465484030-28838-3-git-send-email-benjamin.tissoires@redhat.com>
	<20160718163109.4d2190e9@endymion>
	<20160718163519.GT4663@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20160718163519.GT4663@mail.corp.redhat.com>
Sender: linux-doc-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Jonathan Corbet <corbet@lwn.net>, Corey Minyard <minyard@acm.org>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 18 Jul 2016 18:35:19 +0200, Benjamin Tissoires wrote:
> On Jul 18 2016 or thereabouts, Jean Delvare wrote:
> > But what happens on i2c_adapter removal? What prevents the following
> > sequence from happening?
> > 
> > 1* A Host Notify event happens.
> > 2* The event is handled and queued by i2c_handle_smbus_host_notify().
> > 3* Someone tears down the underlying i2c_adapter (for example "rmmod
> >    i2c-i801".)
> > 4* The workqueue is processed, accessing memory which has already been
> >    freed.
> > 
> > Of course it would be back luck, but that's pretty much the definition
> > of a race condition ;-)
> 
> Yes, you are right :(
> Sorry for not doing things properly :/

No worry. Bugs happen everywhere, we find them and fix them. That's
part of the process. If we only submit patches which we are 100%
certain are perfect, we never submit anything. I know something about
that...

> > To be on the safe side, don't we need a teardown function in i2c-smbus,
> > that could be called before i2c_del_adapter, which would remove the
> > host notify handle and flush the workqueue?
> 
> I was thinking at adding a devm action on the release of the struct
> smbus_host_notify, but it's actually a bad idea because some other
> resources (children moslty) might already be released when the devres
> action will be called.
> 
> I think it might be easier to add a i2c_remove_host_notify() (or such)
> which would make sure we call the cancel_work_sync() function. It would
> be the responsibility of the caller to call it once
> i2c_setup_smbus_host_notify() has been called. I'd say it has the
> advantage of not adding any hidden data in the adapter to the cost of a
> small pain in the adapter driver.

That's what I had in mind as well, but I'm open to any option which
solves the problem really.

-- 
Jean Delvare
SUSE L3 Support
