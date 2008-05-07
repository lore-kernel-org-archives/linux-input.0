From: Dmitry <dbaryshkov@gmail.com>
Subject: Re: [PATCH][RESEND] gpio-keys debouncing support
Date: Wed, 7 May 2008 20:21:27 +0400
Message-ID: <bc64b4640805070921o2f036252m9c03b830a1b1e759@mail.gmail.com>
References: <20080502112048.GA8664@doriath.ww600.siemens.net>
	 <20080506095530.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:60572 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754347AbYEGQVb (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 May 2008 12:21:31 -0400
Received: by py-out-1112.google.com with SMTP id u52so487584pyb.10
        for <linux-input@vger.kernel.org>; Wed, 07 May 2008 09:21:28 -0700 (PDT)
In-Reply-To: <20080506095530.ZZRA012@mailhub.coreip.homeip.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi, Dmitry,

2008/5/6, Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> Hi Dmitry,
>
>
>  On Fri, May 02, 2008 at 03:20:48PM +0400, Dmitry Baryshkov wrote:
>  > Sometimes gpio line can generate jitter while transitioning from one state
>  > to another one. Implement a way to filter such noise during transitions.
>  >
>
>
> I don't think we need to do both count and interval and you don't
>  really need to track state... What do you think about the patch below?

I would say it's pretty different from what I meant. You patch only
delays the decision about the status of the pin while mine does really
"average" the status
of the pin. E.g. in my tosa PDA the headphones jack is a bit noisy. So
the input layer shouldn't react to the noise. And with your patch each
time the GPIO irq is generated the input layer will get input_sync.

-- 
With best wishes
Dmitry
