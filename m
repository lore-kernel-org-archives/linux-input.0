From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: zforce - don't overwrite the stack
Date: Mon, 13 Jul 2015 10:02:25 -0700
Message-ID: <20150713170225.GA5039@dtor-ws>
References: <1436791512-21027-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:36017 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbbGMRCa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jul 2015 13:02:30 -0400
Received: by igbij6 with SMTP id ij6so26578427igb.1
        for <linux-input@vger.kernel.org>; Mon, 13 Jul 2015 10:02:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1436791512-21027-1-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: linux-input@vger.kernel.org, Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>

On Mon, Jul 13, 2015 at 02:45:12PM +0200, Dirk Behme wrote:
> From: Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>
> 
> If we get a corrupted packet with PAYLOAD_LENGTH > FRAME_MAXSIZE, we
> will silently overwrite the stack.
> 
> Signed-off-by: Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/zforce_ts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
> index c4cffcf..32749db 100644
> --- a/drivers/input/touchscreen/zforce_ts.c
> +++ b/drivers/input/touchscreen/zforce_ts.c
> @@ -441,7 +441,7 @@ static int zforce_read_packet(struct zforce_ts *ts, u8 *buf)
>  		goto unlock;
>  	}
>  
> -	if (buf[PAYLOAD_LENGTH] == 0) {
> +	if (buf[PAYLOAD_LENGTH] == 0 || buf[PAYLOAD_LENGTH] > FRAME_MAXSIZE) {
>  		dev_err(&client->dev, "invalid payload length: %d\n",
>  			buf[PAYLOAD_LENGTH]);
>  		ret = -EIO;
> -- 
> 2.3.4
> 

-- 
Dmitry
