From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 2/2] Fix the issue that V8 Button pad Stick button does
 not work
Date: Mon, 13 Mar 2017 15:39:08 +0100
Message-ID: <20170313143908.GD20046@pali>
References: <20170313070410.4710-1-masaki.ota@jp.alps.com>
 <20170313070410.4710-2-masaki.ota@jp.alps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35137 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752099AbdCMOjM (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 13 Mar 2017 10:39:12 -0400
Content-Disposition: inline
In-Reply-To: <20170313070410.4710-2-masaki.ota@jp.alps.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masaki Ota <012nexus@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-kernel@paulsd.com, nick.m.fletcher@gmail.com, joseph.salisbury@canonical.com, ben@smart-cactus.org, mhocko@suse.com, rydberg@bitmath.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, masaki.ota@jp.alps.com

On Monday 13 March 2017 16:04:10 Masaki Ota wrote:
> From: Masaki Ota <masaki.ota@jp.alps.com>
> - V8 Button pad Stick Right and Middle button don't work.
> - Alps stick devices have physical buttons absolutely, so delete "ALPS_BUTTONPAD" check Flag from Stick button process.
> 
> Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>

Acked-by: Pali Rohár <pali.rohar@gmail.com>

> ---
>  drivers/input/mouse/alps.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index a70c860..a13404f 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -1287,10 +1287,8 @@ static int alps_decode_ss4_v2(struct alps_fields *f,
>  	/* handle buttons */
>  	if (pkt_id == SS4_PACKET_ID_STICK) {
>  		f->ts_left = !!(SS4_BTN_V2(p) & 0x01);
> -		if (!(priv->flags & ALPS_BUTTONPAD)) {
> -			f->ts_right = !!(SS4_BTN_V2(p) & 0x02);
> -			f->ts_middle = !!(SS4_BTN_V2(p) & 0x04);
> -		}
> +		f->ts_right = !!(SS4_BTN_V2(p) & 0x02);
> +		f->ts_middle = !!(SS4_BTN_V2(p) & 0x04);
>  	} else {
>  		f->left = !!(SS4_BTN_V2(p) & 0x01);
>  		if (!(priv->flags & ALPS_BUTTONPAD)) {

-- 
Pali Rohár
pali.rohar@gmail.com
