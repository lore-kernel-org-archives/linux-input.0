From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] input: add driver for pixcir i2c touchscreens
Date: Tue, 22 Feb 2011 17:31:12 -0800
Message-ID: <20110223013111.GA23939@opensource.wolfsonmicro.com>
References: <20110222034808.GC18299@sirena.org.uk>
 <4D632AAD.8040405@pixcir.com.cn>
 <f2894b.b085.12e500bb5f2.Coremail.jcbian@pixcir.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:43586 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752041Ab1BWBa6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Feb 2011 20:30:58 -0500
Content-Disposition: inline
In-Reply-To: <f2894b.b085.12e500bb5f2.Coremail.jcbian@pixcir.com.cn>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jcbian <jcbian@pixcir.com.cn>
Cc: linux-input@vger.kernel.org, dqmeng <dqmeng@pixcir.com.cn>, zlchen <zlchen@pixcir.com.cn>

On Wed, Feb 23, 2011 at 09:04:28AM +0800, jcbian wrote:
> > On Tue, Feb 22, 2011 at 11:17:01AM +0800, jcbian wrote:

> > If you can have a single global workqueue could you use the system one
> > and avoid having to create one at all?

> The system one is less efficient then the the creating one in my opioion,is it right?

Actually this is obsoleted by the comment below since you're using the
workqueue for interrupt handling only.

> > > + queue_work(pixcir_wq, &tsdata->work.work);

> > > + return IRQ_HANDLED;
> > > +}

> > Use a threaded IRQ handler - genirq can now implement this pattern for
> > you.

> I do not use genirq before, what the diffetence? Thanks!

genirq is the name of the standard kernel interrupt implementation.  If
you use a threaded IRQ handler using request_threaded_irq() then all the
workqueue stuff goes away.

> > > +static int pixcir_ts_open(struct input_dev *dev)
> > > +{
> > > + return 0;
> > > +}

> > You should have code to start the controller here, and matching shutdown
> > code in close().

> Yes normally should do like this,but this controller need any command to open,may be take come code
> to test the device working? 

If there's nothing at all to do I guess you can remove the code, though
at least disabling the IRQ while the device is closed would be nice.

> > > + dev_err(&tsdata->client->dev, "insmod successfully!\n");

> > No need for logs like this in production code, and the priority is all
> > wrong.

> I just want to show the correctly insmod.

It's not something that should be shown in production code.
