From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 3/3] goldfish: multitouch: no extra EV_SYN
Date: Tue, 01 Mar 2016 23:27:13 +0000
Message-ID: <1456874833.7064.22.camel@linux.intel.com>
References: <20160226184908.3539.48691.stgit@localhost.localdomain>
	 <20160226185007.3539.83946.stgit@localhost.localdomain>
	 <20160226195746.GA3769@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:60857 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750850AbcCAX13 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 1 Mar 2016 18:27:29 -0500
In-Reply-To: <20160226195746.GA3769@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, jinqian@android.com

> >  	input_event(edev->input, type, code, value);
> > -	input_sync(edev->input);
> > +	/*
> > +	 * Send an extra (EV_SYN, SYN_REPORT, 0x0) event
> > +	 * if a key was pressed. Some keyboard device
> > +	 * drivers may only send the EV_KEY event and
> > +	 * not EV_SYN.
> 
> That would be error in that keyboard driver and should be fixed.

Agreed but it's still the case that current and long standing Goldfish
behaviour requires the above.

> > +	 * Note that sending an extra SYN_REPORT is not
> > +	 * necessary nor correct protocol with other
> > +	 * devices such as touchscreens, which will send
> > +	 * their own SYN_REPORT's when sufficient event
> > +	 * information has been collected (e.g., for
> > +	 * touchscreens, when pressure and X/Y coordinates
> > +	 * have been received). Hence, we will only send
> > +	 * this extra SYN_REPORT if type == EV_KEY.
> > +	 */
> > +	if (type == EV_KEY)
> > +		input_sync(edev->input);
> 
> 
> I'd rather we always rely on the host to send the SYN event.

That would certainly make sense for the future.

> > +
> >  	return IRQ_HANDLED;
> >  }
> >  
> > @@ -154,6 +173,15 @@ static int events_probe(struct platform_device
> > *pdev)
> >  
> >  	input_dev->name = edev->name;
> >  	input_dev->id.bustype = BUS_HOST;
> > +	/*
> > +	 * Set the Goldfish Device to be multi-touch.
> > +	 * If we do not issue input_mt_init_slots,
> > +	 * the kernel will filter out needed ABS_MT_SLOT
> > +	 * events when we touch the screen in more than one place,
> > +	 * preventing multi-touch with more than one finger from
> > working.
> > +	 * See drivers/input/input.c:input_handle_abs_event.
> > +	 */
> > +	input_mt_init_slots(input_dev, GOLDFISH_MAX_FINGERS, 0);
> 
> Can we use data retrieved by events_import_abs_params() to set up
> correct number of slots? Also we need error handling. And possibly
> retrieve correct properties to set pass to input_mt_init_slots()...

Again - I agree that makes sense for future versions of Goldfish

Alan

