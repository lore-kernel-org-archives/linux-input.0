From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: wacom: Use unaligned access where necessary
Date: Wed, 14 May 2014 16:59:07 -0700
Message-ID: <20140514235907.GA22731@core.coreip.homeip.net>
References: <1400111184-18878-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:56836 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbaENX7K (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 May 2014 19:59:10 -0400
Received: by mail-pb0-f43.google.com with SMTP id up15so268818pbc.2
        for <linux-input@vger.kernel.org>; Wed, 14 May 2014 16:59:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400111184-18878-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, pingc@wacom.com

On Wed, May 14, 2014 at 04:46:24PM -0700, Jason Gerecke wrote:
> A few caes of incorrectly using 'le16_to_cpup' instead of
> 'get_unaligned_le16' have been noticed and fixed.
> 
> Signed-off-by: Jason Gerecke <killertofu@gmail.com>

Applied, thank you.

> ---
>  drivers/input/tablet/wacom_wac.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
> index 1c779a6..20ea522 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -988,12 +988,12 @@ static int wacom_24hdt_irq(struct wacom_wac *wacom)
>  		input_mt_report_slot_state(input, MT_TOOL_FINGER, touch);
>  
>  		if (touch) {
> -			int t_x = le16_to_cpup((__le16 *)&data[offset + 2]);
> -			int c_x = le16_to_cpup((__le16 *)&data[offset + 4]);
> -			int t_y = le16_to_cpup((__le16 *)&data[offset + 6]);
> -			int c_y = le16_to_cpup((__le16 *)&data[offset + 8]);
> -			int w = le16_to_cpup((__le16 *)&data[offset + 10]);
> -			int h = le16_to_cpup((__le16 *)&data[offset + 12]);
> +			int t_x = get_unaligned_le16(&data[offset + 2]);
> +			int c_x = get_unaligned_le16(&data[offset + 4]);
> +			int t_y = get_unaligned_le16(&data[offset + 6]);
> +			int c_y = get_unaligned_le16(&data[offset + 8]);
> +			int w = get_unaligned_le16(&data[offset + 10]);
> +			int h = get_unaligned_le16(&data[offset + 12]);
>  
>  			input_report_abs(input, ABS_MT_POSITION_X, t_x);
>  			input_report_abs(input, ABS_MT_POSITION_Y, t_y);
> @@ -1038,7 +1038,7 @@ static int wacom_mt_touch(struct wacom_wac *wacom)
>  	for (i = 0; i < contacts_to_send; i++) {
>  		int offset = (WACOM_BYTES_PER_MT_PACKET + x_offset) * i + 3;
>  		bool touch = data[offset] & 0x1;
> -		int id = le16_to_cpup((__le16 *)&data[offset + 1]);
> +		int id = get_unaligned_le16(&data[offset + 1]);
>  		int slot = input_mt_get_slot_by_key(input, id);
>  
>  		if (slot < 0)
> @@ -1047,8 +1047,8 @@ static int wacom_mt_touch(struct wacom_wac *wacom)
>  		input_mt_slot(input, slot);
>  		input_mt_report_slot_state(input, MT_TOOL_FINGER, touch);
>  		if (touch) {
> -			int x = le16_to_cpup((__le16 *)&data[offset + x_offset + 7]);
> -			int y = le16_to_cpup((__le16 *)&data[offset + x_offset + 9]);
> +			int x = get_unaligned_le16(&data[offset + x_offset + 7]);
> +			int y = get_unaligned_le16(&data[offset + x_offset + 9]);
>  			input_report_abs(input, ABS_MT_POSITION_X, x);
>  			input_report_abs(input, ABS_MT_POSITION_Y, y);
>  		}
> -- 
> 1.9.2
> 

-- 
Dmitry
