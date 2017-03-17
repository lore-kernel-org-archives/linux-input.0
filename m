From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Fix the issue that V8 Button pad Stick button does
 not work
Date: Fri, 17 Mar 2017 14:26:23 -0700
Message-ID: <20170317212623.GG26166@dtor-ws>
References: <20170314013413.7260-1-masaki.ota@jp.alps.com>
 <20170314013413.7260-2-masaki.ota@jp.alps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170314013413.7260-2-masaki.ota@jp.alps.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masaki Ota <012nexus@gmail.com>
Cc: linux-kernel@paulsd.com, nick.m.fletcher@gmail.com, joseph.salisbury@canonical.com, ben@smart-cactus.org, mhocko@suse.com, pali.rohar@gmail.com, rydberg@bitmath.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, masaki.ota@jp.alps.com
List-Id: linux-input@vger.kernel.org

On Tue, Mar 14, 2017 at 10:34:13AM +0900, Masaki Ota wrote:
> From: Masaki Ota <masaki.ota@jp.alps.com>
> - V8 Button pad Stick Right and Middle button don't work.
> - Alps stick devices have physical buttons absolutely, so delete "ALPS_BUTTONPAD" check Flag from Stick button process.
> 
> Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
> 
> Acked-by: Pali Rohar <pali.rohar@gmail.com>

Reworded commit message, marked for stable and applied, thank you.

> ---
>  drivers/input/mouse/alps.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 253f742..262d105 100644
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
> -- 
> 2.9.3
> 

-- 
Dmitry
