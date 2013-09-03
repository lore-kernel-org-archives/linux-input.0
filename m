From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Behaviour of input-polldev?
Date: Tue, 3 Sep 2013 11:03:37 -0700
Message-ID: <20130903180337.GA25985@core.coreip.homeip.net>
References: <5225CA65.7030104@butterbrot.org>
 <CANq1E4Tr4gigvtTA7mqDgqjGfjGaLM477D2uW4qdFGkySaGPWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:42133 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759413Ab3ICSDp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Sep 2013 14:03:45 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so6319847pdj.26
        for <linux-input@vger.kernel.org>; Tue, 03 Sep 2013 11:03:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANq1E4Tr4gigvtTA7mqDgqjGfjGaLM477D2uW4qdFGkySaGPWA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Florian Echtler <floe@butterbrot.org>, linux-input <linux-input@vger.kernel.org>

On Tue, Sep 03, 2013 at 01:54:45PM +0200, David Herrmann wrote:
> Hi Florian
> 
> On Tue, Sep 3, 2013 at 1:39 PM, Florian Echtler <floe@butterbrot.org> wrote:
> > Hello everyone,
> >
> > I'm in the process of writing an input driver for the Microsoft
> > Pixelsense (formerly Surface 2.0). The device only has bulk endpoints
> > and consequently needs to be polled regularly. My beta driver uses
> > input-polldev for this, and it appears to work nicely, however, I
> > couldn't find out how input-polldev behaves if one polling cycle takes
> > longer than expected and a new poll would already be triggered while the
> > first one is still running?

With input-polldev new poll can not get scheduled until driver's poll()
method returns:

static void input_polled_device_work(struct work_struct *work)
{
	struct input_polled_dev *dev =
		container_of(work, struct input_polled_dev, work.work);

	dev->poll(dev);
	input_polldev_queue_work(dev);
}

The expectation here is that poll function is quick and does not
introduce much skew into scheduling of polls (although of course error
is accumulating).

-- 
Dmitry
