From: "Tirdea, Irina" <irina.tirdea@intel.com>
Subject: RE: [PATCH RFC V2 2/3] Input: goodix - use "inverted_[xy]" flags
 instead of "rotated_screen"
Date: Tue, 13 Oct 2015 07:01:42 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F0FE4D9@irsmsx105.ger.corp.intel.com>
References: <1444413352-24529-1-git-send-email-merker@debian.org>
 <1444413352-24529-3-git-send-email-merker@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:55042 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751884AbbJMHBs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Oct 2015 03:01:48 -0400
In-Reply-To: <1444413352-24529-3-git-send-email-merker@debian.org>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Karsten Merker <merker@debian.org>, Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aleksei Mamlin <mamlinav@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>



> -----Original Message-----
> From: Karsten Merker [mailto:merker@debian.org]
> Sent: 09 October, 2015 20:56
> To: Bastien Nocera; Dmitry Torokhov; Tirdea, Irina; Aleksei Mamlin; linux-input@vger.kernel.org; Ian Campbell
> Cc: devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Chen-Yu Tsai; Karsten Merker
> Subject: [PATCH RFC V2 2/3] Input: goodix - use "inverted_[xy]" flags instead of "rotated_screen"
> 
> The goodix touchscreen driver uses a "rotated_screen" flag for
> systems on which the touchscreen is mounted rotated by 180
> degrees with respect to the display.  With the addition of
> support for the dt properties "touchscreen-inverted-x" and
> "touchscreen-inverted-y", a separate "rotated_screen" flag
> is not necessary any more. This patch replaces it by setting
> the inverted_x and inverted_y flags instead.
> 
> Signed-off-by: Karsten Merker <merker@debian.org>
> ---

Reviewed-by: Irina Tirdea <irina.tirdea@intel.com>

>  drivers/input/touchscreen/goodix.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> index a05bdad..d910b27 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -40,7 +40,6 @@ struct goodix_ts_data {
>  	int abs_y_max;
>  	unsigned int max_touch_num;
>  	unsigned int int_trigger_type;
> -	bool rotated_screen;
>  	int cfg_len;
>  	struct gpio_desc *gpiod_int;
>  	struct gpio_desc *gpiod_rst;
> @@ -270,11 +269,6 @@ static void goodix_ts_report_touch(struct goodix_ts_data *ts, u8 *coor_data)
>  	int input_y = get_unaligned_le16(&coor_data[3]);
>  	int input_w = get_unaligned_le16(&coor_data[5]);
> 
> -	if (ts->rotated_screen) {
> -		input_x = ts->abs_x_max - input_x;
> -		input_y = ts->abs_y_max - input_y;
> -	}
> -
>  	/* Inversions have to happen before axis swapping */
>  	if (ts->inverted_x)
>  		input_x = ts->abs_x_max - input_x;
> @@ -701,10 +695,12 @@ static void goodix_read_config(struct goodix_ts_data *ts)
>  		ts->max_touch_num = GOODIX_MAX_CONTACTS;
>  	}
> 
> -	ts->rotated_screen = dmi_check_system(rotated_screen);
> -	if (ts->rotated_screen)
> +	if (dmi_check_system(rotated_screen)) {
> +		ts->inverted_x = true;
> +		ts->inverted_y = true;
>  		dev_dbg(&ts->client->dev,
>  			 "Applying '180 degrees rotated screen' quirk\n");
> +	}
>  }
> 
>  /**
> --
> 2.1.4

