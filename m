From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v2] Input: driver for the Goodix touchpanel
Date: Tue, 28 Oct 2014 15:16:29 -0400
Message-ID: <CAN+gG=Hi1O9CFAzMa3YqYLd7Gydd2yw9QFL__Vu_P67q4+g-xg@mail.gmail.com>
References: <1411569838.29315.22.camel@hadess.net>
	<20141007205803.GJ16469@dtor-ws>
	<1414518921.2406.11.camel@hadess.net>
	<20141028180538.GA22157@dtor-ws>
	<1414522745.2406.14.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:48887 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526AbaJ1TQa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Oct 2014 15:16:30 -0400
Received: by mail-qg0-f42.google.com with SMTP id i50so136267qgf.29
        for <linux-input@vger.kernel.org>; Tue, 28 Oct 2014 12:16:29 -0700 (PDT)
In-Reply-To: <1414522745.2406.14.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input <linux-input@vger.kernel.org>

On Tue, Oct 28, 2014 at 2:59 PM, Bastien Nocera <hadess@hadess.net> wrote:
> On Tue, 2014-10-28 at 11:05 -0700, Dmitry Torokhov wrote:
>> On Tue, Oct 28, 2014 at 06:55:21PM +0100, Bastien Nocera wrote:
>> > On Tue, 2014-10-07 at 13:58 -0700, Dmitry Torokhov wrote:
>> > > On Wed, Sep 24, 2014 at 04:43:58PM +0200, Bastien Nocera wrote:
>> > > > +static irqreturn_t goodix_ts_irq_handler(int irq, void *dev_id)
>> > > > +{
>> > > > +       struct goodix_ts_data *ts = dev_id;
>> > > > +       u8  end_cmd[1] = {0};
>> > > > +
>> > > > +       goodix_process_events(ts);
>> > > > +
>> > > > +       if (goodix_i2c_write(ts->client,
>> > > > +                               GOODIX_READ_COOR_ADDR, end_cmd, 1) < 0)
>> > > > +               dev_err(&ts->client->dev, "I2C write end_cmd error");
>> > >
>> > > I am not happy that we need to allocate/deallocate memory for each
>> > > interrupt. We only write one command to the driver, we could simply use
>> > > i2c_master_send() with a constant buffer.
>> >
>> > Sure. But I've split up the patch you sent us, and committed the
>> > different bits separately in:
>> > https://github.com/hadess/gt9xx/commits/master
>> >
>> > And this one commit about removing goodix_i2c_write():
>> > https://github.com/hadess/gt9xx/commit/146b4cc2eed5c67bcf1cb91e845bf9f97da4be1e
>> >
>> > Breaks the driver.
>>
>> Ah, I see. In end_cmd I encoded the address as little endian, whereas it
>> needs to be beg endian. Just swap "GOODIX_READ_COOR_ADDR & 0xff" and
>> "GOODIX_READ_COOR_ADDR >> 8" around and I thin kit will work.
>
> Indeed, fixed in:
> https://github.com/hadess/gt9xx/commit/18e507c5c455a3d3d745380c4d0d561ea470a091
>
> As for the various FIXMEs, could you (that includes Benjamin that
> probably knows the driver more than he would like to) check whether
> that's sensible?
> https://github.com/hadess/gt9xx/commit/35b94f327edc04d95a7208a667553566faa871e3

IIRC, the device is rather simple: the I2C way of accessing it is
register driven. You give the register address and read from it. The
10 contacts are all banked together starting at GOODIX_READ_COOR_ADDR
after one byte which indicates the contact count.
For efficiency purpose, the first read checks both the contact count
and the first contact data, then it reads the rest of the contact
data.

So where I wanted to be is that GOODIX_CONTACTS_HEADER_SIZE does not
make sense IMO, and using (GOODIX_CONTACT_SIZE + 1) is more reliable
(if it still works, of course).

BTW, Dmitry said the same... I could have just waited instead of
writing this up :)

Cheers,
Benjamin

>
> If it is, I'll respin the patch and send it for merging.
>
> Cheers
>
