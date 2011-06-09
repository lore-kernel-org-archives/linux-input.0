From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] input: add driver for Bosch Sensortec's BMA150
 accelerometer
Date: Thu, 9 Jun 2011 17:32:03 +0100
Message-ID: <20110609173203.020d5017@lxorguk.ukuu.org.uk>
References: <1306857314-655-1-git-send-email-eric.andersson@unixphere.com>
	<20110531172320.0fcadfef@lxorguk.ukuu.org.uk>
	<20110609161224.GA7098@skinner>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:54386 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751556Ab1FIQaG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jun 2011 12:30:06 -0400
In-Reply-To: <20110609161224.GA7098@skinner>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Andersson <eric.andersson@unixphere.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, zhengguang.guo@bosch-sensortec.com, stefan.nilsson@unixphere.com, Albert Zhang <xu.zhang@bosch-sensortec.com>

> > What locks this SMBUS transaction against others
> True! I will look over the locking for the next version.

I have a suspicion the two drivers are distant relatives actually - the
bugs look similar !
> 
> > > +static int bma150_set_range(struct i2c_client *client, unsigned char range)
> > > +{
> > > +	int ret;
> > > +	unsigned char data;
> > > +
> > > +	if (range > BMA150_RANGE_8G)
> > > +		return -EINVAL;
> > 
> > This should be actual values not a register range
> It is an actual value. See chapter 3.1.2 in the BMA150 datasheet where the
> acceleration range values are defined.

It should specify the units and be in meaningful ones not register values
(I got moaned at for that in my submission too!)

> I will send an updated version of the driver once I've fixed it!

Cool - I really don't care btw which driver we end up with a mix of both,
I just need it to work on our platform too.

Dunno where Dmitry has gone - has he vanished ?
