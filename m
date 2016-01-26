From: Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 2/3] input: touchscreen: ad7879: fix default x/y axis
 assignment
Date: Tue, 26 Jan 2016 08:58:44 +0100
Message-ID: <56A72734.9000303@analog.com>
References: <1453777477-29706-1-git-send-email-stefan@agner.ch>
 <1453777477-29706-2-git-send-email-stefan@agner.ch>
Reply-To: <michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453777477-29706-2-git-send-email-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>, dmitry.torokhov@gmail.com, robh+dt@kernel.org
Cc: mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, realmz6@gmail.com, broonie@kernel.org, jic23@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 01/26/2016 04:04 AM, Stefan Agner wrote:
> The measurements read from the controller which are temporary stored
> in conversion_data, are interpreted wrong. The first measurement X+
> contains the Y position, and the second measurement Y+ the X position
> (see also Table 11 Register Table in the data sheet).
>
> The problem is already known and a swap option has been introduced:
> commit 6680884a4420 ("Input: ad7879 - add option to correct xy axis")
>
> However, with that the meaning of the new boolean is inverted since
> the underlying values are already swapped. With this change, a true
> in swap_xy actually swaps the two axis.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Hi Michael,
>
> It seems that swap_xy is not used in any board which is in mainline,
> hence swap_xy is always false. Therefore, up until now all boards
> actually used swapped axis. However, I doubt that the blackfin boards
> really have those axis swapped, it is probably more likely that the
> userspace calibration took care of it.
>
> However, if they are really swapped, we should set the swap_xy flag
> to 1 for those board...
>
> Do you happen to now what is the case with those boards?
>


Hi Stefan,

I would be hesitant to invert the default behaviour of the driver.
Too many people in the field already using it as it is.

A XY swap can have multiple reasons.

Lot's of small VGA/QVGA TFTs have the option to switch the scan 
direction from Landscape to Portrait. In addition you can also rotate 
and flip or mirror using VDMA options. So it really depends on the use 
case, how the touch panel is mounted to the screen or how it is wired.

Regards,
Michael

> --
> Stefan
>
>   drivers/input/touchscreen/ad7879.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
> index a73934b..e290e7b 100644
> --- a/drivers/input/touchscreen/ad7879.c
> +++ b/drivers/input/touchscreen/ad7879.c
> @@ -94,8 +94,8 @@
>   #define AD7879_TEMP_BIT			(1<<1)
>
>   enum {
> -	AD7879_SEQ_XPOS  = 0,
> -	AD7879_SEQ_YPOS  = 1,
> +	AD7879_SEQ_YPOS  = 0,
> +	AD7879_SEQ_XPOS  = 1,
>   	AD7879_SEQ_Z1    = 2,
>   	AD7879_SEQ_Z2    = 3,
>   	AD7879_NR_SENSE  = 4,
>


-- 
Greetings,
Michael
