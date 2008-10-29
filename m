From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: gpio_keys: Polling mode support.
Date: Tue, 28 Oct 2008 23:51:23 -0400
Message-ID: <20081029035123.GB27906@anvil.corenet.prv>
References: <20081021083816.GA29345@linux-sh.org> <20081028101857.GA25523@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f18.google.com ([209.85.217.18]:46233 "EHLO
	mail-gx0-f18.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbYJ2Dv3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Oct 2008 23:51:29 -0400
Received: by gxk11 with SMTP id 11so2305455gxk.13
        for <linux-input@vger.kernel.org>; Tue, 28 Oct 2008 20:51:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20081028101857.GA25523@linux-sh.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>, linux-input@vger.kernel.org, linux-sh@vger.kernel.org

Hi Paul,

On Tue, Oct 28, 2008 at 07:18:57PM +0900, Paul Mundt wrote:
> Ping.
> 
> On Tue, Oct 21, 2008 at 05:38:16PM +0900, Paul Mundt wrote:
> > This implements an optional polling mode for the gpio_keys driver,
> > necessary for GPIOs that are not able to generate IRQs.
> > 
> > Polling mode is done device granular, and can not be toggled for
> > individual GPIOs in order to maintain simplicity. Platforms with both
> > IRQ capable and incapable GPIOs are required to register multiple
> > times, once for each case.
> > 
> >  
> > -	input_unregister_device(input);
> > +	if (pdata->polling)
> > +		input_unregister_polled_device(poll_dev);

You also need to do input_free_polled_device (but not input_free_device
 - yeah, I know, its confusing... The reason is that input_dev is
   refcounted while input_polled_dev is not).
> > +	else
> > +		input_unregister_device(poll_dev->input);
> >  

I also concerned with unconditionally polling INPUT_POLLDEV for all
users of gpio-keys. Maybe we could make polling support optional?

-- 
Dmitry
