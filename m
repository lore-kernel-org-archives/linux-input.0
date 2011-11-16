From: <oskar.andero@sonyericsson.com>
Subject: Re: [PATCH v2] input: add driver support for Sharp gp2ap002a00f
 proximity sensor
Date: Wed, 16 Nov 2011 16:56:25 +0100
Message-ID: <20111116155625.GB3375@caracas.corpusers.net>
References: <1321285158-7123-1-git-send-email-oskar.andero@sonyericsson.com>
 <20111114170352.GA12659@core.coreip.homeip.net>
 <20111115073400.GD9307@caracas.corpusers.net>
 <1321457952.1790.16.camel@anish-Inspiron-N5050>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([212.209.106.2]:1531 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755233Ab1KPPzd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Nov 2011 10:55:33 -0500
Content-Disposition: inline
In-Reply-To: <1321457952.1790.16.camel@anish-Inspiron-N5050>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: anish kumar <anish198519851985@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jic23@cam.ac.uk" <jic23@cam.ac.uk>, "aghayal@codeaurora.org" <aghayal@codeaurora.org>, "Cavin, Courtney" <Courtney.Cavin@sonyericsson.com>

> > > > +#ifdef CONFIG_PM_SLEEP
> > > > +static int gp2a_suspend(struct device *dev)
> > > > +{
> > > > +	struct i2c_client *client = to_i2c_client(dev);
> > > > +	struct gp2a_data *dt = i2c_get_clientdata(client);
> > > > +	int error;
> > > > +
> > > > +	if (device_may_wakeup(&client->dev)) {
> > > > +		enable_irq_wake(client->irq);
> > > > +	} else {
> > > 
> > > This needs locking WRT open/close. Please acquire dt->device->mutex and
> > > only disable if dt->device->users != 0. Similar shoudl be done for
> > > resume.
> > 
> > I see what you mean. I will fix it. 
> Is my understanding correct?You are going to disable the device 
> only when there are users of the driver and not disable the device
> otherwise.As anyway if there are no users the driver would have been
> already disabled right?

Please, see PATCH v3 for the answer to your question.

-Oskar
