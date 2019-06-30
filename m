From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: joydev - extend absolute mouse detection
Date: Sun, 30 Jun 2019 00:32:21 -0700
Message-ID: <20190630073221.GF91171@dtor-ws>
References: <20190623234456.4074-1-alexander@tsoy.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190623234456.4074-1-alexander@tsoy.me>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Tsoy <alexander@tsoy.me>
Cc: linux-input@vger.kernel.org, Thomas Hellstrom <thellstrom@vmware.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jun 24, 2019 at 02:44:56AM +0300, Alexander Tsoy wrote:
> Extend event signature matching to catch more input devices emulated by
> BMC firmwares, QEMU and VMware.
> 
> Signed-off-by: Alexander Tsoy <alexander@tsoy.me>

Applied, thank you.

> ---
>  drivers/input/joydev.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
> index ac21c050fdb0..a2b5fbba2d3b 100644
> --- a/drivers/input/joydev.c
> +++ b/drivers/input/joydev.c
> @@ -808,6 +808,7 @@ static bool joydev_dev_is_blacklisted(struct input_dev *dev)
>  static bool joydev_dev_is_absolute_mouse(struct input_dev *dev)
>  {
>  	DECLARE_BITMAP(jd_scratch, KEY_CNT);
> +	bool ev_match = false;
>  
>  	BUILD_BUG_ON(ABS_CNT > KEY_CNT || EV_CNT > KEY_CNT);
>  
> @@ -826,17 +827,36 @@ static bool joydev_dev_is_absolute_mouse(struct input_dev *dev)
>  	 * considered to be an absolute mouse if the following is
>  	 * true:
>  	 *
> -	 * 1) Event types are exactly EV_ABS, EV_KEY and EV_SYN.
> +	 * 1) Event types are exactly
> +	 *      EV_ABS, EV_KEY and EV_SYN
> +	 *    or
> +	 *      EV_ABS, EV_KEY, EV_SYN and EV_MSC
> +	 *    or
> +	 *      EV_ABS, EV_KEY, EV_SYN, EV_MSC and EV_REL.
>  	 * 2) Absolute events are exactly ABS_X and ABS_Y.
>  	 * 3) Keys are exactly BTN_LEFT, BTN_RIGHT and BTN_MIDDLE.
>  	 * 4) Device is not on "Amiga" bus.
>  	 */
>  
>  	bitmap_zero(jd_scratch, EV_CNT);
> +	/* VMware VMMouse, HP ILO2 */
>  	__set_bit(EV_ABS, jd_scratch);
>  	__set_bit(EV_KEY, jd_scratch);
>  	__set_bit(EV_SYN, jd_scratch);
> -	if (!bitmap_equal(jd_scratch, dev->evbit, EV_CNT))
> +	if (bitmap_equal(jd_scratch, dev->evbit, EV_CNT))
> +		ev_match = true;
> +
> +	/* HP ILO2, AMI BMC firmware */
> +	__set_bit(EV_MSC, jd_scratch);
> +	if (bitmap_equal(jd_scratch, dev->evbit, EV_CNT))
> +		ev_match = true;
> +
> +	/* VMware Virtual USB Mouse, QEMU USB Tablet, ATEN BMC firmware */
> +	__set_bit(EV_REL, jd_scratch);
> +	if (bitmap_equal(jd_scratch, dev->evbit, EV_CNT))
> +		ev_match = true;
> +
> +	if (!ev_match)
>  		return false;
>  
>  	bitmap_zero(jd_scratch, ABS_CNT);
> -- 
> 2.21.0
> 

-- 
Dmitry
