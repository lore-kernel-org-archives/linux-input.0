From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 5/5] Input: zforce_ts: Fix dual touch recognition
Date: Mon, 25 Apr 2016 14:08:43 -0700
Message-ID: <20160425210843.GC26059@dtor-ws>
References: <1461135285-17582-1-git-send-email-dirk.behme@de.bosch.com>
 <1461135285-17582-5-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35103 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964811AbcDYVIs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Apr 2016 17:08:48 -0400
Received: by mail-pf0-f181.google.com with SMTP id n1so73602084pfn.2
        for <linux-input@vger.kernel.org>; Mon, 25 Apr 2016 14:08:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1461135285-17582-5-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Knut Wohlrab <Knut.Wohlrab@de.bosch.com>, Oleksij Rempel <linux@rempel-privat.de>

On Wed, Apr 20, 2016 at 08:54:45AM +0200, Dirk Behme wrote:
> From: Knut Wohlrab <Knut.Wohlrab@de.bosch.com>
> 
> A wrong decoding of the touch coordinate message causes a wrong touch
> ID. Touch ID for dual touch must be 0 or 1.
> 
> According to the actual Neonode nine byte touch coordinate coding,
> the state is transported in the lower nibble and the touch ID in
> the higher nibble of payload byte five.
> 
> Signed-off-by: Knut Wohlrab <Knut.Wohlrab@de.bosch.com>
> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/zforce_ts.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
> index fd435fe..9790d7a 100644
> --- a/drivers/input/touchscreen/zforce_ts.c
> +++ b/drivers/input/touchscreen/zforce_ts.c
> @@ -412,8 +412,8 @@ static int zforce_touch_event(struct zforce_ts *ts, u8 *payload)
>  			point.coord_x = point.coord_y = 0;
>  		}
>  
> -		point.state = payload[9 * i + 5] & 0x03;
> -		point.id = (payload[9 * i + 5] & 0xfc) >> 2;
> +		point.state = payload[9 * i + 5] & 0x0f;
> +		point.id = (payload[9 * i + 5] & 0xf0) >> 4;
>  
>  		/* determine touch major, minor and orientation */
>  		point.area_major = max(payload[9 * i + 6],
> -- 
> 2.8.0
> 

-- 
Dmitry
