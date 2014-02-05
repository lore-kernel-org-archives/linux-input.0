From: Courtney Cavin <courtney.cavin@sonymobile.com>
Subject: Re: [PATCH 03/15] Input: synaptics-rmi4 - don't free devices directly
Date: Tue, 4 Feb 2014 18:28:51 -0800
Message-ID: <20140205022851.GC1706@sonymobile.com>
References: <1390521623-6491-1-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-2-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-3-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-4-git-send-email-courtney.cavin@sonymobile.com>
 <52F172E8.9040203@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([212.209.106.2]:13209 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752994AbaBEC1H (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Feb 2014 21:27:07 -0500
Content-Disposition: inline
In-Reply-To: <52F172E8.9040203@synaptics.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, linus.walleij@stericsson.com, linus.walleij@linaro.org

On Wed, Feb 05, 2014 at 12:08:24AM +0100, Christopher Heiny wrote:
> On 01/23/2014 04:00 PM, Courtney Cavin wrote:
> > Devices use a kobject to manage references, do not delete the memory
> > while still referenced.  Instead, call put_device() to release the
> > reference.
> 
> This is an interesting idea, but it should be done consistently for all 
> the device types.
> 

This is not an idea, just a bugfix.  The kernel will segfault on failure
in which results in the kfree().  I didn't notice any other
device_register() calls which have this particular issue, but I might
have missed something.

> >
> > Cc: Christopher Heiny <cheiny@synaptics.com>
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Signed-off-by: Courtney Cavin <courtney.cavin@sonymobile.com>
> > ---
> >   drivers/input/rmi4/rmi_bus.c    | 8 +++++---
> >   drivers/input/rmi4/rmi_driver.c | 6 +-----
> >   2 files changed, 6 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
> > index 8a939f3..cd7bfbd 100644
> > --- a/drivers/input/rmi4/rmi_bus.c
> > +++ b/drivers/input/rmi4/rmi_bus.c
> > @@ -94,8 +94,7 @@ int rmi_register_transport_device(struct rmi_transport_dev *xport)
> >   		return -EINVAL;
> >   	}
> >
> > -	rmi_dev = devm_kzalloc(xport->dev,
> > -				sizeof(struct rmi_device), GFP_KERNEL);
> > +	rmi_dev = kzalloc(sizeof(struct rmi_device), GFP_KERNEL);
> >   	if (!rmi_dev)
> >   		return -ENOMEM;
> >
> > @@ -112,8 +111,10 @@ int rmi_register_transport_device(struct rmi_transport_dev *xport)
> >   	rmi_physical_setup_debugfs(rmi_dev);
> >
> >   	error = device_register(&rmi_dev->dev);
> > -	if (error)
> > +	if (error) {
> > +		put_device(&rmi_dev->dev);
> >   		return error;
> > +	}
> >
> >   	dev_dbg(xport->dev, "%s: Registered %s as %s.\n", __func__,
> >   		pdata->sensor_name, dev_name(&rmi_dev->dev));
> > @@ -240,6 +241,7 @@ int rmi_register_function(struct rmi_function *fn)
> >   		dev_err(&rmi_dev->dev,
> >   			"Failed device_register function device %s\n",
> >   			dev_name(&fn->dev));
> > +		put_device(&fn->dev);
> >   		goto error_exit;
> >   	}
> >
> > diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> > index 5c6379c..4965589 100644
> > --- a/drivers/input/rmi4/rmi_driver.c
> > +++ b/drivers/input/rmi4/rmi_driver.c
> > @@ -557,15 +557,11 @@ static int create_function(struct rmi_device *rmi_dev,
> >
> >   	error = rmi_register_function(fn);
> >   	if (error)
> > -		goto err_free_mem;
> > +		return error;
> >
> >   	list_add_tail(&fn->node, &data->function_list);
> >
> >   	return 0;
> > -
> > -err_free_mem:
> > -	kfree(fn);
> > -	return error;
> >   }
> >
> >   /*
> >
