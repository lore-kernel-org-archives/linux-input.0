From: Aniroop Mathur <a.mathur@samsung.com>
Subject: Re: [PATCH] Input: mouse: synaptics - change msleep to usleep_range
 for small msecs
Date: Wed, 30 Nov 2016 02:32:50 +0530
Message-ID: <CAOXgUe0FPkByE-0piMeNLaU3iTd_k0Nj_pZzEU4pv_9WzBzt1w@mail.gmail.com>
References: <1480362924-5224-1-git-send-email-a.mathur@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1480362924-5224-1-git-send-email-a.mathur@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mike@compulab.co.il, grinberg@compulab.co.il, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: s.samuel@samsung.com, r.mahale@samsung.com, Aniroop Mathur <aniroop.mathur@gmail.com>, Aniroop Mathur <a.mathur@samsung.com>
List-Id: linux-input@vger.kernel.org

Dear Mike Rapoport, Igor Grinberg,
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

On Tue, Nov 29, 2016 at 1:25 AM, Aniroop Mathur <a.mathur@samsung.com> wrote:
> msleep(1~20) may not do what the caller intends, and will often sleep longer.
> (~20 ms actual sleep for any value given in the 1~20ms range)
> This is not the desired behaviour for many cases like device resume time,
> device suspend time, device enable time, retry logic, etc.
> Thus, change msleep to usleep_range for precise wakeups.
>
> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
> ---
>  drivers/input/mouse/synaptics_i2c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
> index aa7c5da..4d688a6 100644
> --- a/drivers/input/mouse/synaptics_i2c.c
> +++ b/drivers/input/mouse/synaptics_i2c.c
> @@ -29,7 +29,7 @@
>   * after soft reset, we should wait for 1 ms
>   * before the device becomes operational
>   */
> -#define SOFT_RESET_DELAY_MS    3
> +#define SOFT_RESET_DELAY_US    3000
>  /* and after hard reset, we should wait for max 500ms */
>  #define HARD_RESET_DELAY_MS    500
>
> @@ -311,7 +311,7 @@ static int synaptics_i2c_reset_config(struct i2c_client *client)
>         if (ret) {
>                 dev_err(&client->dev, "Unable to reset device\n");
>         } else {
> -               msleep(SOFT_RESET_DELAY_MS);
> +               usleep_range(SOFT_RESET_DELAY_US, SOFT_RESET_DELAY_US + 100);
>                 ret = synaptics_i2c_config(client);
>                 if (ret)
>                         dev_err(&client->dev, "Unable to config device\n");
> --
> 2.6.2
>
