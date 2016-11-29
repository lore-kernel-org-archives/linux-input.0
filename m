From: Aniroop Mathur <a.mathur@samsung.com>
Subject: Re: [PATCH] Input: touchscreen: w90p910 - change msleep to
 usleep_range for small msecs
Date: Wed, 30 Nov 2016 02:27:09 +0530
Message-ID: <CAOXgUe3sBD3uqfGgE63EyEai0t90sgETiHCEJf7Agx-ZmS49=w@mail.gmail.com>
References: <1480358582-2954-1-git-send-email-a.mathur@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1480358582-2954-1-git-send-email-a.mathur@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ZongShun Wan <mcuos.com@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, s.samuel@samsung.com, r.mahale@samsung.com, Aniroop Mathur <aniroop.mathur@gmail.com>, Aniroop Mathur <a.mathur@samsung.com>
List-Id: linux-input@vger.kernel.org

Dear Wan ZongShun,
Greetings!

I am Aniroop Mathur from Samsung R&D Institute, India.

I have submitted one patch as below for review to Linux Open Source.
The problem is that we do not have the hardware available with us to
test it and we would like to test it before actually applying it.
As you are the author of this driver, I am contacting you to request you
provide your feedback upon this patch.

Also if you have the hardware available, could you please help to
test this patch on your hardware? or could you provide contact points
of individuals who could support to test it?

Thank you!

BR,
Aniroop Mathur

On Tue, Nov 29, 2016 at 12:13 AM, Aniroop Mathur <a.mathur@samsung.com> wrote:
> msleep(1~20) may not do what the caller intends, and will often sleep longer.
> (~20 ms actual sleep for any value given in the 1~20ms range)
> This is not the desired behaviour for many cases like device resume time,
> device suspend time, device enable time, retry logic, etc.
> Thus, change msleep to usleep_range for precise wakeups.
>
> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
> ---
>  drivers/input/touchscreen/w90p910_ts.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/touchscreen/w90p910_ts.c b/drivers/input/touchscreen/w90p910_ts.c
> index da6004e..3f14b5a 100644
> --- a/drivers/input/touchscreen/w90p910_ts.c
> +++ b/drivers/input/touchscreen/w90p910_ts.c
> @@ -171,9 +171,9 @@ static int w90p910_open(struct input_dev *dev)
>         clk_enable(w90p910_ts->clk);
>
>         __raw_writel(ADC_RST1, w90p910_ts->ts_reg);
> -       msleep(1);
> +       usleep_range(1000, 1100);
>         __raw_writel(ADC_RST0, w90p910_ts->ts_reg);
> -       msleep(1);
> +       usleep_range(1000, 1100);
>
>         /* set delay and screen type */
>         val = __raw_readl(w90p910_ts->ts_reg + 0x04);
> --
> 2.6.2
>
