From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] input: add driver for pixcir i2c touchscreens
Date: Tue, 22 Feb 2011 17:36:39 -0800
Message-ID: <20110223013639.GA891@core.coreip.homeip.net>
References: <20110222054057.GB11681@core.coreip.homeip.net>
 <1eeef53.91a4.12e4b7257f9.Coremail.jcbian@pixcir.com.cn>
 <1c85eba.b1cd.12e501cebb7.Coremail.jcbian@pixcir.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:40303 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755570Ab1BWBgs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Feb 2011 20:36:48 -0500
Received: by gxk8 with SMTP id 8so1223867gxk.19
        for <linux-input@vger.kernel.org>; Tue, 22 Feb 2011 17:36:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1c85eba.b1cd.12e501cebb7.Coremail.jcbian@pixcir.com.cn>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jcbian <jcbian@pixcir.com.cn>
Cc: linux-input@vger.kernel.org, dqmeng <dqmeng@pixcir.com.cn>, zlchen <zlchen@pixcir.com.cn>

On Wed, Feb 23, 2011 at 09:23:16AM +0800, jcbian wrote:
> > > +
> > > +static int pixcir_i2c_ts_remove(struct i2c_client *client)
> > > +{
> > > +	struct pixcir_i2c_ts_data *tsdata = dev_get_drvdata(&client->dev);
> > 
> > i2c_get_clientdata(). Also empty line between variable definitions and
> > code.
> > 
> Sorry,what's the meaning here?

1. Use i2c_get_clientdata() instead of dev_get_drvdata() to access
driver-private data

2. Add an empty line between variable definitions and the rest of the
code.

> > > +
> > > +	pixcir_wq = create_singlethread_workqueue("pixcir_wq");
> > 
> > Not needed if you use threaded IRQ.
> > 
> You mean the threaded IRQ is better than workqueue? If using the threaded IRQ should remove the request_irq()?   
> 

You request your IRQ to be serviced by a special thread by doing
request_threaded_irq(). Since interrupt processing will happen in a
thread you will be able to use sleeping functions directly in your
interrupt handler and won't need to rely on a separate workqueue
(and do not need to concern yourself with canceling/shutting down the
workqeue upon driver unload - which you did not do anyway ;) ).

Thanks.

-- 
Dmitry
