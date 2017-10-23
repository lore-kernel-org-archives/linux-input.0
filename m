From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: ad7877: Convert timers to use timer_setup()
Date: Mon, 23 Oct 2017 14:54:43 -0700
Message-ID: <20171023215443.5caqiqpdgbkxmqra@dtor-ws>
References: <CABCPcVXPOrHziTY18oSP9FCjto5skMj3HazGH8oeCv1cyPSZ7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CABCPcVXPOrHziTY18oSP9FCjto5skMj3HazGH8oeCv1cyPSZ7g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: stephen lu <lumotuwe@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Oct 23, 2017 at 04:40:27PM +0800, stephen lu wrote:
> In preparation for unconditionally passing the struct
>  timer_list pointer to all timer callbacks, switch to using the new
>  timer_setup() and from_timer() to pass the timer pointer explicitly.
> 
> Signed-off-by: Stephen Lu <lumotuwe@gmail.com>

Applied after fixing up the mangled patch.

> 
> ---
>  drivers/input/touchscreen/ad7877.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ad7877.c
> b/drivers/input/touchscreen/ad7877.c
> index 9c250ae..0381c78 100644
> --- a/drivers/input/touchscreen/ad7877.c
> +++ b/drivers/input/touchscreen/ad7877.c
> @@ -385,9 +385,9 @@ static inline void ad7877_ts_event_release(struct
> ad7877 *ts)
>         input_sync(input_dev);
>  }
> 
> -static void ad7877_timer(unsigned long handle)
> +static void ad7877_timer(struct timer_list *t)
>  {
> -       struct ad7877 *ts = (void *)handle;
> +       struct ad7877 *ts = from_timer(ts, t, timer);
>         unsigned long flags;
> 
>         spin_lock_irqsave(&ts->lock, flags);
> @@ -718,7 +718,7 @@ static int ad7877_probe(struct spi_device *spi)
>         ts->spi = spi;
>         ts->input = input_dev;
> 
> -       setup_timer(&ts->timer, ad7877_timer, (unsigned long) ts);
> +       timer_setup(&ts->timer, ad7877_timer, 0);
>         mutex_init(&ts->mutex);
>         spin_lock_init(&ts->lock);
> 
> -- 
> 1.9.1

-- 
Dmitry
