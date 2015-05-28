From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH 2/9] input: goodix: fix variable length array warning
Date: Thu, 28 May 2015 17:57:53 +0200
Message-ID: <20150528175753.1f85723b5b880ecf02fd4a79@ao2.it>
References: <1432817265-23891-1-git-send-email-irina.tirdea@intel.com>
	<1432817265-23891-3-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:2599 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754137AbbE1P6S (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 28 May 2015 11:58:18 -0400
In-Reply-To: <1432817265-23891-3-git-send-email-irina.tirdea@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 28 May 2015 15:47:38 +0300
Irina Tirdea <irina.tirdea@intel.com> wrote:

> Fix sparse warning:
> drivers/input/touchscreen/goodix.c:182:26: warning:
> Variable length array is used.
> 
> Replace the variable length array with fixed length.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> ---
>  drivers/input/touchscreen/goodix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> index c2e785c..dac1b3c 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -147,7 +147,7 @@ static void goodix_ts_report_touch(struct goodix_ts_data *ts, u8 *coor_data)
>   */
>  static void goodix_process_events(struct goodix_ts_data *ts)
>  {
> -	u8  point_data[1 + GOODIX_CONTACT_SIZE * ts->max_touch_num];
> +	u8  point_data[1 + GOODIX_CONTACT_SIZE * GOODIX_MAX_CONTACTS];

Hi,

this fixes the warning from sparse, but also changes the semantics of
the code: ts->max_touch_num is less that GOODIX_MAX_CONTACTS for 5
touches devices and in this case we'll end up using more memory than is
necessary.

Thanks,
   Antonio

>  	int touch_num;
>  	int i;
>  
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
