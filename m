From: Martin Kepplinger <martink@posteo.de>
Subject: Re: [PATCH] driver:st1633: fixed multitouch incorrect coordinates
Date: Thu, 22 Aug 2019 14:08:14 +0200
Message-ID: <8cfedf751fc87f5f1c660cfda69d36ce@posteo.de>
References: <1566209314-21767-1-git-send-email-dixitparmar19@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1566209314-21767-1-git-send-email-dixitparmar19@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: dmitry.torokhov@gmail.com, rydberg@bitmath.org, kuninori.morimoto.gx@renesas.com, robh@kernel.org, matthias.fend@wolfvision.net, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Am 19.08.2019 12:08 schrieb Dixit Parmar:
> From: Dixit Parmar <dixitparmar19@gmail.com>
> 
> For Sitronix st1633 multi-touch controller driver the co-ordinates 
> reported
> for multiple fingers were wrong.
> 
> So the below mentioned bug was filed,
> Bugzilla Bug ID: 204561
> 
> While reading co-ordinates from specified I2C registers, the X & Y
> co-ordinates should be read from proper I2C address for particular 
> finger as
> specified in chip specific datasheet.
> 
> for single touch this logic is working fine. However, for multi-touch
> scenario the logic of reading data from data buffer has issues.
> 
> This patch fixes the reading logic from data buffer.
> 
> Previous logic:
> * Offset of X & Y Lower byte coordinate is increased by i no. only(by 1 
> Byte)
>   for each finger.
> 
> New logic:
> * The logic of reading X & Y Lower Byte coordinate needs to be 
> increased
>   by i+y for each time/finger.
> 
> Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
> ---
>  drivers/input/touchscreen/st1232.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/st1232.c
> b/drivers/input/touchscreen/st1232.c
> index 3492339..1139714 100644
> --- a/drivers/input/touchscreen/st1232.c
> +++ b/drivers/input/touchscreen/st1232.c
> @@ -81,8 +81,10 @@ static int st1232_ts_read_data(struct st1232_ts_data 
> *ts)
>  	for (i = 0, y = 0; i < ts->chip_info->max_fingers; i++, y += 3) {
>  		finger[i].is_valid = buf[i + y] >> 7;
>  		if (finger[i].is_valid) {
> -			finger[i].x = ((buf[i + y] & 0x0070) << 4) | buf[i + 1];
> -			finger[i].y = ((buf[i + y] & 0x0007) << 8) | buf[i + 2];
> +			finger[i].x = ((buf[i + y] & 0x0070) << 4) |
> +					buf[i + y + 1];
> +			finger[i].y = ((buf[i + y] & 0x0007) << 8) |
> +					buf[i + y + 2];

Seems like you're right. It's simply +1 (for x) and +2 (for y) from the 
high-byte locations.
Not sure how that went wrong.

Thank you,

Reviewed-by: Martin Kepplinger <martink@posteo.de>


> 
>  			/* st1232 includes a z-axis / touch strength */
>  			if (ts->chip_info->have_z)
