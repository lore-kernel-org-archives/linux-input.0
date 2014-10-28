From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: driver for the Goodix touchpanel
Date: Tue, 28 Oct 2014 11:05:38 -0700
Message-ID: <20141028180538.GA22157@dtor-ws>
References: <1411569838.29315.22.camel@hadess.net>
 <20141007205803.GJ16469@dtor-ws>
 <1414518921.2406.11.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:64703 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbaJ1SFn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Oct 2014 14:05:43 -0400
Received: by mail-pa0-f48.google.com with SMTP id ey11so1271370pad.21
        for <linux-input@vger.kernel.org>; Tue, 28 Oct 2014 11:05:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1414518921.2406.11.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>

On Tue, Oct 28, 2014 at 06:55:21PM +0100, Bastien Nocera wrote:
> On Tue, 2014-10-07 at 13:58 -0700, Dmitry Torokhov wrote:
> > On Wed, Sep 24, 2014 at 04:43:58PM +0200, Bastien Nocera wrote:
> > > +static irqreturn_t goodix_ts_irq_handler(int irq, void *dev_id)
> > > +{
> > > +	struct goodix_ts_data *ts = dev_id;
> > > +	u8  end_cmd[1] = {0};
> > > +
> > > +	goodix_process_events(ts);
> > > +
> > > +	if (goodix_i2c_write(ts->client,
> > > +				GOODIX_READ_COOR_ADDR, end_cmd, 1) < 0)
> > > +		dev_err(&ts->client->dev, "I2C write end_cmd error");
> > 
> > I am not happy that we need to allocate/deallocate memory for each
> > interrupt. We only write one command to the driver, we could simply use
> > i2c_master_send() with a constant buffer.
> 
> Sure. But I've split up the patch you sent us, and committed the
> different bits separately in:
> https://github.com/hadess/gt9xx/commits/master
> 
> And this one commit about removing goodix_i2c_write():
> https://github.com/hadess/gt9xx/commit/146b4cc2eed5c67bcf1cb91e845bf9f97da4be1e
> 
> Breaks the driver.

Ah, I see. In end_cmd I encoded the address as little endian, whereas it
needs to be beg endian. Just swap "GOODIX_READ_COOR_ADDR & 0xff" and
"GOODIX_READ_COOR_ADDR >> 8" around and I thin kit will work.

Thanks.

-- 
Dmitry
