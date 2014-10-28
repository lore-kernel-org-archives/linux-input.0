From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: driver for the Goodix touchpanel
Date: Tue, 28 Oct 2014 12:14:46 -0700
Message-ID: <20141028191446.GA7461@dtor-ws>
References: <1411569838.29315.22.camel@hadess.net>
 <20141007205803.GJ16469@dtor-ws>
 <1414518921.2406.11.camel@hadess.net>
 <20141028180538.GA22157@dtor-ws>
 <1414522745.2406.14.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:45779 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbaJ1TOv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Oct 2014 15:14:51 -0400
Received: by mail-pd0-f178.google.com with SMTP id fp1so1311975pdb.23
        for <linux-input@vger.kernel.org>; Tue, 28 Oct 2014 12:14:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1414522745.2406.14.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>

On Tue, Oct 28, 2014 at 07:59:05PM +0100, Bastien Nocera wrote:
> On Tue, 2014-10-28 at 11:05 -0700, Dmitry Torokhov wrote:
> > On Tue, Oct 28, 2014 at 06:55:21PM +0100, Bastien Nocera wrote:
> > > On Tue, 2014-10-07 at 13:58 -0700, Dmitry Torokhov wrote:
> > > > On Wed, Sep 24, 2014 at 04:43:58PM +0200, Bastien Nocera wrote:
> > > > > +static irqreturn_t goodix_ts_irq_handler(int irq, void *dev_id)
> > > > > +{
> > > > > +	struct goodix_ts_data *ts = dev_id;
> > > > > +	u8  end_cmd[1] = {0};
> > > > > +
> > > > > +	goodix_process_events(ts);
> > > > > +
> > > > > +	if (goodix_i2c_write(ts->client,
> > > > > +				GOODIX_READ_COOR_ADDR, end_cmd, 1) < 0)
> > > > > +		dev_err(&ts->client->dev, "I2C write end_cmd error");
> > > > 
> > > > I am not happy that we need to allocate/deallocate memory for each
> > > > interrupt. We only write one command to the driver, we could simply use
> > > > i2c_master_send() with a constant buffer.
> > > 
> > > Sure. But I've split up the patch you sent us, and committed the
> > > different bits separately in:
> > > https://github.com/hadess/gt9xx/commits/master
> > > 
> > > And this one commit about removing goodix_i2c_write():
> > > https://github.com/hadess/gt9xx/commit/146b4cc2eed5c67bcf1cb91e845bf9f97da4be1e
> > > 
> > > Breaks the driver.
> > 
> > Ah, I see. In end_cmd I encoded the address as little endian, whereas it
> > needs to be beg endian. Just swap "GOODIX_READ_COOR_ADDR & 0xff" and
> > "GOODIX_READ_COOR_ADDR >> 8" around and I thin kit will work.
> 
> Indeed, fixed in:
> https://github.com/hadess/gt9xx/commit/18e507c5c455a3d3d745380c4d0d561ea470a091
> 
> As for the various FIXMEs, could you (that includes Benjamin that
> probably knows the driver more than he would like to) check whether
> that's sensible?
> https://github.com/hadess/gt9xx/commit/35b94f327edc04d95a7208a667553566faa871e3
> 
> If it is, I'll respin the patch and send it for merging.

No, the "header" is not 10 bytes as far as I can see. IIUIC the device
sends packet with 1st byte containing number of contacts + (n_contacts *
GOODIX_CONTACT_SIZE) worth of data. The driver tries to optimize for
single-touch scenario and reads the counter and the very first contact
data and if the counter indicates more than one contact it will issue
second i2c transaction to read in the rest.

Your change did not alter the actual code, it just converted constant 10
into a define.

Please try changing FIXMEs exactly as they were and see if the driver
still works properly.

Thanks.

-- 
Dmitry
