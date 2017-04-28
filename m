From: Andi Shyti <andi.shyti@samsung.com>
Subject: Re: [PATCH v3 2/2] Input: add support for the STMicroelectronics
 FingerTip touchscreen
Date: Fri, 28 Apr 2017 09:07:51 +0900
Message-ID: <20170428000751.z66rgjiwjjsmonig@gangnam.samsung>
References: <20170327130743.27783-1-andi.shyti@samsung.com>
 <CGME20170327130756epcas1p321726d525c31814c3f76895b895739cd@epcas1p3.samsung.com>
 <20170327130743.27783-3-andi.shyti@samsung.com>
 <20170427003918.GA1236@dtor-glaptop>
 <20170427234156.glh2lchwr57fllmo@gangnam.samsung>
 <20170427235645.GB33675@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:38481 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755613AbdD1AHy (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 Apr 2017 20:07:54 -0400
Content-disposition: inline
In-reply-to: <20170427235645.GB33675@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Andrzej Hajda <a.hajda@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>, javier@dowhile0.org

Hi Dmitry,

On Thu, Apr 27, 2017 at 04:56:45PM -0700, Dmitry Torokhov wrote:
> On Fri, Apr 28, 2017 at 08:41:56AM +0900, Andi Shyti wrote:
> > On Wed, Apr 26, 2017 at 05:39:18PM -0700, Dmitry Torokhov wrote:
> > > On Mon, Mar 27, 2017 at 10:07:43PM +0900, Andi Shyti wrote:
> > > > +static irqreturn_t stmfts_irq_handler(int irq, void *dev)
> > > > +{
> > > > +	struct stmfts_data *sdata = dev;
> > > > +	int ret;
> > > > +
> > > > +	mutex_lock(&sdata->mutex);
> > > > +	ret = i2c_smbus_read_i2c_block_data(sdata->client,
> > > > +						STMFTS_READ_ONE_EVENT,
> > > > +						STMFTS_EVENT_SIZE, sdata->data);
> > > > +
> > > > +	if (ret < 0 || ret != STMFTS_EVENT_SIZE)
> > > > +		goto exit;
> > > 
> > > Why do we split read into 2 chunks? Can we issue STMFTS_READ_ALL_EVENT
> > > right away instead of reading first event, analyzing it, and then (maybe)
> > > fetching the rest?
> > 
> > The reason is that I don't need to read all the events at once
> > anytime, for example debug events or confirmation events normally
> > occur with a single event in the fifo. In this case I would read
> > only 32bytes instead of 256bytes.
> > 
> > Unfortunately there are no other ways to know how many events are
> > in the queue beforehand.
> > 
> > There are some "magic" commands to figure that out, but this is
> > specific to the Samsung's version of the stmfts and I don't want
> > to push it to everyone else.
> > 
> > The difference between this version of the driver and the
> > previous one is that in this one if I stress-use of the
> > touchscreen, the throughput is optimised (e.g. if I use more
> > fingers).
> > Before I was reading single events at time, establishing for each
> > read an i2c "handshake", this was de-synchronizing the protocol.
> > 
> > > Also, why do we use smbus protocol for the first event and i2c for the
> > > rest?
> > 
> > Standing to the datasheet, the device is smbus compatible and it
> > should use smbus all the time. The problem is that here the
> > protocol is broken in case I want to read out the full FIFO,
> > which has a total of 256bytes and I have to force the read by
> > using the function "stmfts_read_i2c_block_data()".
> > 
> > Personally I don't like these kind of i2c reads, because they
> > duplicate code, the SMBUS does that already, this is why in the
> > previous version I was reading the events one by one.
> > 
> > Do you think it is better to make a single read of all the fifo?
> 
> It depends on what the common case is. It looks like for touch data you
> always do 2 i2c transactions per interrupt. I wonder if doing it once
> and paying the price of overhead for debug a nd confirmation events is
> not worth it.

makes sense, indeed, because I do it all the time when for touch
events (which are the most) not only when the FIFO is not full.
I will do it this way, then... Thanks!

Andi
