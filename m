From: "vojtech@ucw.cz" <vojtech@ucw.cz>
Subject: Re: [PATCH] Input: joystick: adi - change msleep to usleep_range for
 small msecs
Date: Mon, 28 Nov 2016 12:53:41 +0100
Message-ID: <20161128115341.GA27136@suse.com>
References: <CGME20161128114356epcms5p836ef0c36a1cbb8b68638ed046afbb777@epcms5p8>
 <20161128114356epcms5p836ef0c36a1cbb8b68638ed046afbb777@epcms5p8>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161128114356epcms5p836ef0c36a1cbb8b68638ed046afbb777@epcms5p8>
Sender: linux-kernel-owner@vger.kernel.org
To: Aniroop Mathur <a.mathur@samsung.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, SAMUEL SEQUEIRA <s.samuel@samsung.com>, Rahul Mahale <r.mahale@samsung.com>, "aniroop.mathur@gmail.com" <aniroop.mathur@gmail.com>
List-Id: linux-input@vger.kernel.org

Hi.

ADI_INIT_DELAY/ADI_DATA_DELAY doesn't have to be exact, and a longer
sleep doesn't matter. In the initilization sequence - first chunk of
your patch - a way too long delay could in theory make the device fail
to initialize. What's critical is that the mdelay() calls are precise.

One day I'll open my box of old joystick and re-test these drivers to
see if they survived the years of kernel infrastructure updates ...

Vojtech

On Mon, Nov 28, 2016 at 11:43:56AM +0000, Aniroop Mathur wrote:
> msleep(1~20) may not do what the caller intends, and will often sleep longer.
> (~20 ms actual sleep for any value given in the 1~20ms range)
> This is not the desired behaviour for many cases like device resume time,
> device suspend time, device enable time, data reading time, etc.
> Thus, change msleep to usleep_range for precise wakeups.
> 
> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
> ---
>  joystick/adi.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/joystick/adi.c b/joystick/adi.c
> index d09cefa..6799bd9 100644
> --- a/joystick/adi.c
> +++ b/joystick/adi.c
> @@ -47,8 +47,8 @@ MODULE_LICENSE("GPL");
>  
>  #define ADI_MAX_START		200	/* Trigger to packet timeout [200us] */
>  #define ADI_MAX_STROBE		40	/* Single bit timeout [40us] */
> -#define ADI_INIT_DELAY		10	/* Delay after init packet [10ms] */
> -#define ADI_DATA_DELAY		4	/* Delay after data packet [4ms] */
> +#define ADI_INIT_DELAY		10000	/* Delay after init packet [10ms] */
> +#define ADI_DATA_DELAY		4000	/* Delay after data packet [4000us] */
>  
>  #define ADI_MAX_LENGTH		256
>  #define ADI_MIN_LENGTH		8
> @@ -319,7 +319,7 @@ static void adi_init_digital(struct gameport *gameport)
>  	for (i = 0; seq[i]; i++) {
>  		gameport_trigger(gameport);
>  		if (seq[i] > 0)
> -			msleep(seq[i]);
> +			usleep_range(seq[i] * 1000, (seq[i] * 1000) + 100);
>  		if (seq[i] < 0) {
>  			mdelay(-seq[i]);
>  			udelay(-seq[i]*14);	/* It looks like mdelay() is off by approx 1.4% */
> @@ -512,9 +512,9 @@ static int adi_connect(struct gameport *gameport, struct gameport_driver *drv)
>  	gameport_set_poll_handler(gameport, adi_poll);
>  	gameport_set_poll_interval(gameport, 20);
>  
> -	msleep(ADI_INIT_DELAY);
> +	usleep_range(ADI_INIT_DELAY, ADI_INIT_DELAY + 100);
>  	if (adi_read(port)) {
> -		msleep(ADI_DATA_DELAY);
> +		usleep_range(ADI_DATA_DELAY, ADI_DATA_DELAY + 100);
>  		adi_read(port);
>  	}
>  
> -- 
> 2.6.4.windows.1


-- 
Vojtech Pavlik
