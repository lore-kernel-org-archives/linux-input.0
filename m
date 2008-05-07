From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH][RESEND] gpio-keys debouncing support
Date: Wed, 7 May 2008 13:20:10 -0400
Message-ID: <20080507131649.ZZRA012@mailhub.coreip.homeip.net>
References: <20080502112048.GA8664@doriath.ww600.siemens.net> <20080506095530.ZZRA012@mailhub.coreip.homeip.net> <bc64b4640805070921o2f036252m9c03b830a1b1e759@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.185]:23998 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbYEGRUR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 May 2008 13:20:17 -0400
Received: by ti-out-0910.google.com with SMTP id b6so125936tic.23
        for <linux-input@vger.kernel.org>; Wed, 07 May 2008 10:20:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <bc64b4640805070921o2f036252m9c03b830a1b1e759@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry <dbaryshkov@gmail.com>
Cc: linux-input@vger.kernel.org

On Wed, May 07, 2008 at 08:21:27PM +0400, Dmitry wrote:
> Hi, Dmitry,
> 
> 2008/5/6, Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> > Hi Dmitry,
> >
> >
> >  On Fri, May 02, 2008 at 03:20:48PM +0400, Dmitry Baryshkov wrote:
> >  > Sometimes gpio line can generate jitter while transitioning from one state
> >  > to another one. Implement a way to filter such noise during transitions.
> >  >
> >
> >
> > I don't think we need to do both count and interval and you don't
> >  really need to track state... What do you think about the patch below?
> 
> I would say it's pretty different from what I meant. You patch only
> delays the decision about the status of the pin while mine does really
> "average" the status
> of the pin. E.g. in my tosa PDA the headphones jack is a bit noisy. So
> the input layer shouldn't react to the noise.

The userspace will not see the new event until gpio stabilizes,
that's all that is needed.

> And with your patch each
> time the GPIO irq is generated the input layer will get input_sync.

That I think I need to fix in input core. I think we used to not reset
sync flag on ignored events.

-- 
Dmitry
