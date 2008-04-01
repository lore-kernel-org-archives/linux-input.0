From: Dmitry <dbaryshkov@gmail.com>
Subject: Re: [PATCH] Fix tosakbd suspend
Date: Tue, 1 Apr 2008 16:27:38 +0300
Message-ID: <bc64b4640804010627n172be3fbi9a43eb392c487358@mail.gmail.com>
References: <20080331213801.GA9372@doriath.ww600.siemens.net>
	 <20080401034903.GB18041@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:50843 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758006AbYDAN1j (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Apr 2008 09:27:39 -0400
Received: by py-out-1112.google.com with SMTP id u52so3059739pyb.10
        for <linux-input@vger.kernel.org>; Tue, 01 Apr 2008 06:27:38 -0700 (PDT)
In-Reply-To: <20080401034903.GB18041@anvil.corenet.prv>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi, Dmitry,

2008/4/1, Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> Hi Dmitry,
>
>
>  On Tue, Apr 01, 2008 at 01:38:01AM +0400, Dmitry Baryshkov wrote:
>  > Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
>  > ---
>  >  drivers/input/keyboard/tosakbd.c |    3 +++
>  >  1 files changed, 3 insertions(+), 0 deletions(-)
>  >
>  > diff --git a/drivers/input/keyboard/tosakbd.c b/drivers/input/keyboard/tosakbd.c
>  > index 3884d1e..306cbe8 100644
>  > --- a/drivers/input/keyboard/tosakbd.c
>  > +++ b/drivers/input/keyboard/tosakbd.c
>  > @@ -210,6 +210,9 @@ static int tosakbd_suspend(struct platform_device *dev, pm_message_t state)
>  >
>  >       del_timer_sync(&tosakbd->timer);
>  >
>
>
> What if interrupt comes here? The whole suspend path seems racy with
>  interrup handler/timer.

What is the best way to fix it? Moving from suspend to suspend_late
seems to be a hack.
Should I call a bunch of disable_irq or just introduce an atomic flag?

>
>
>  > +     PGSR1 = (PGSR1 & ~TOSA_GPIO_LOW_STROBE_BIT);
>  > +     PGSR2 = (PGSR2 & ~TOSA_GPIO_HIGH_STROBE_BIT);
>  > +
>  >       return 0;
>  >  }
>  >
>
>  --
>
> Dmitry
>


-- 
With best wishes
Dmitry
