From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 1/2] input/joystick: new
	AD7142driver
Date: Wed, 15 Jul 2009 08:29:01 -0700
Message-ID: <20090715152901.GC21611@dtor-d630.eng.vmware.com>
References: <1247592827-16878-1-git-send-email-vapier@gentoo.org> <20090714180309.GC14661@dtor-d630.eng.vmware.com> <0F1B54C89D5F954D8535DB252AF412FA046225E3@chinexm1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:60202 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755454AbZGOP3F (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Jul 2009 11:29:05 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1049490rvb.1
        for <linux-input@vger.kernel.org>; Wed, 15 Jul 2009 08:29:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <0F1B54C89D5F954D8535DB252AF412FA046225E3@chinexm1.ad.analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Song, Barry" <Barry.Song@analog.com>
Cc: Mike Frysinger <vapier@gentoo.org>, uclinux-dist-devel@blackfin.uclinux.org, "Hennerich, Michael" <Michael.Hennerich@analog.com>, linux-input@vger.kernel.org

Hi Barry,

On Wed, Jul 15, 2009 at 06:01:49PM +0800, Song, Barry wrote:
> > +
> > +	/* Start workqueue for defer message transfer */
> > +	INIT_WORK(&data->work, ad7142_work);
> > +
> > +	if (client->irq > 0) {
> > +		rc = request_irq(client->irq, ad7142_interrupt,
> > +				IRQF_TRIGGER_LOW, "ad7142_joystick",
> data);
> 
> > Let's use threaded IRQs, they are so nice for devices like this one.
> Do you mean use request_threaded_irq to request irq and return
> IRQ_THREAD_WAKE in hardware interrupt to wake-up thread_fn in process
> context?  But there is almost no device using this way after a grep.
> Or just create a single-thread workqueue? Or just create a thread to
> handle bottom-half?
> 

I was talking about request_threaded_irq(). It is very new but fits this
driver usage and takes care of proper and raceless shutting down
interrupt/worker pair.

-- 
Dmitry
