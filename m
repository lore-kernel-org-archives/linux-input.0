From: "Magnus Damm" <magnus.damm@gmail.com>
Subject: Re: [PATCH] Touch screen driver for the SuperH MigoR board V2
Date: Fri, 25 Apr 2008 19:29:28 +0900
Message-ID: <aec7e5c30804250329m5fc62921y4da1cd0f6ee6b215@mail.gmail.com>
References: <20080328095101.8825.48353.sendpatchset@rx1.opensource.se>
	 <20080402060819.GB14189@anvil.corenet.prv>
	 <aec7e5c30804040121k584a0ae5o909b48fbd970245d@mail.gmail.com>
	 <20080404120837.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20080404120837.ZZRA012@mailhub.coreip.homeip.net>
Content-Disposition: inline
Sender: linux-sh-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-sh@vger.kernel.org, lethal@linux-sh.org, broonie@sirena.org.uk, akpm@linux-foundation.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

Thanks for all your help with this driver.

On Sat, Apr 5, 2008 at 1:14 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>  On Fri, Apr 04, 2008 at 05:21:48PM +0900, Magnus Damm wrote:
>  > I just tested using latest sh-2.6 git with evtest. Everything seems to
>  > work well. The patch is much cleaner now. Please apply.
>  >
>
>  I was just looking the driver over one more time before applying it
>  and I think there is a race in migor_ts_remove():
>
>  +       /* cancel pending work and wait for migor_ts_poscheck() to finish */
>
> +       cancel_delayed_work_sync(&priv->work);
>  +
>
>  What if interrupt comes here, before we got a chance to shut off the
>  device? IRQ is still enabled and it will schedule migor_ts_poscheck()
>  again. I think we need to call disable_irq() before canceling the work.
>  Since the driver does not support sharing IRQs that should be allright.
>  What do you think?

I think you are right. Doing a disable_irq() before canceling the work
sounds good. Can you please add that, or do you want me to fix and
repost?

Thank you!

/ magnus
