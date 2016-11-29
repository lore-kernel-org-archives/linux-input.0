From: Aniroop Mathur <a.mathur@samsung.com>
Subject: Re: [PATCH] Input: mouse: navpoint - Change msleep to usleep_range
 for small msecs
Date: Wed, 30 Nov 2016 02:10:28 +0530
Message-ID: <CAOXgUe1ducNSMU8hSCGNB+ZUOG3Dp5-88WpPpUqigLtJUGH1sQ@mail.gmail.com>
References: <1480354085-1885-1-git-send-email-a.mathur@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1480354085-1885-1-git-send-email-a.mathur@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lost.distance@yahoo.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, s.samuel@samsung.com, r.mahale@samsung.com, Aniroop Mathur <aniroop.mathur@gmail.com>, Aniroop Mathur <a.mathur@samsung.com>
List-Id: linux-input@vger.kernel.org

Dear Mr. Paul Parsons,

I am Aniroop Mathur from Samsung R&D Institute, India.

I have submitted one patch as below for review to Linux Open Source.
The problem is that we do not have the hardware available with us to
test it and we would like to test it before actually applying it.

If you have the hardware available, could you please help to test this patch?
or could you provide contact points of individuals who could support to test it?


Thank you!

BR,
Aniroop Mathur

On Mon, Nov 28, 2016 at 10:58 PM, Aniroop Mathur <a.mathur@samsung.com> wrote:
> msleep(1~20) may not do what the caller intends, and will often sleep longer.
> (~20 ms actual sleep for any value given in the 1~20ms range)
> This is not the desired behaviour for many cases like device resume time,
> device suspend time, device enable time, retry logic, etc.
> Thus, change msleep to usleep_range for precise wakeups.
>
> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
> ---
>  drivers/input/mouse/navpoint.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/mouse/navpoint.c b/drivers/input/mouse/navpoint.c
> index d6e8f58..2ede00b 100644
> --- a/drivers/input/mouse/navpoint.c
> +++ b/drivers/input/mouse/navpoint.c
> @@ -166,7 +166,7 @@ static void navpoint_up(struct navpoint *navpoint)
>         for (timeout = 100; timeout != 0; --timeout) {
>                 if (!(pxa_ssp_read_reg(ssp, SSSR) & SSSR_CSS))
>                         break;
> -               msleep(1);
> +               usleep_range(1000, 1100);
>         }
>
>         if (timeout == 0)
> --
> 2.6.2
>
