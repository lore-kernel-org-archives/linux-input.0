From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v2 2/8] input: goodix: fix variable length array warning
Date: Tue, 09 Jun 2015 17:35:44 +0200
Message-ID: <1433864144.5707.5.camel@hadess.net>
References: <1433774273-23103-1-git-send-email-irina.tirdea@intel.com>
	 <1433774273-23103-3-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:39062 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbbFIPfu (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2015 11:35:50 -0400
In-Reply-To: <1433774273-23103-3-git-send-email-irina.tirdea@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>

On Mon, 2015-06-08 at 17:37 +0300, Irina Tirdea wrote:
> Fix sparse warning:
> drivers/input/touchscreen/goodix.c:182:26: warning:
> Variable length array is used.
> 
> Replace the variable length array with fixed length.
> 
> Some Goodix devices have maximum 5 touch points, while
> others have 10 touch points. Using the maximum length
> (80 bytes) for all devices will lead to wasting 40 bytes
> when using devices with maximum 5 touch points. However,
> that is prefferable to using kmalloc which will use even
          ^^^^^^^^^^^
preferable

> more resources.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>

Acked-by: Bastien Nocera <hadess@hadess.net>

> ---
>  drivers/input/touchscreen/goodix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/goodix.c 
> b/drivers/input/touchscreen/goodix.c
> index a65e4d9..18557e4 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -147,7 +147,7 @@ static void goodix_ts_report_touch(struct 
> goodix_ts_data *ts, u8 *coor_data)
>   */
>  static void goodix_process_events(struct goodix_ts_data *ts)
>  {
> -     u8  point_data[1 + GOODIX_CONTACT_SIZE * ts->max_touch_num];
> +     u8  point_data[1 + GOODIX_CONTACT_SIZE * 
> GOODIX_MAX_CONTACTS];
>       int touch_num;
>       int i;
>  
