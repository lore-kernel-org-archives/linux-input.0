From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v4 2/3] Input: ALPS - Clean up TrackStick handling for
 SS5 hardware
Date: Wed, 9 Nov 2016 13:14:43 +0100
Message-ID: <20161109121443.GC19557@pali>
References: <20161024210122.GA2919@TopQuark.net>
 <20161108151430.GN2927@TopQuark.net>
 <20161108151621.GO2927@TopQuark.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33905 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbcKIMOq (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 9 Nov 2016 07:14:46 -0500
Received: by mail-wm0-f65.google.com with SMTP id p190so28883305wmp.1
        for <linux-input@vger.kernel.org>; Wed, 09 Nov 2016 04:14:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161108151621.GO2927@TopQuark.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Donohue <linux-kernel@PaulSD.com>
Cc: linux-input@vger.kernel.org, Ben Gamari <ben@smart-cactus.org>, Michal Hocko <mhocko@suse.com>

On Tuesday 08 November 2016 10:16:21 Paul Donohue wrote:
> For consistency and clarity, the input_report_*() functions should
> be called by alps_process_packet_ss4_v2() instead of by
> alps_decode_ss4_v2().
>     
> Signed-off-by: Paul Donohue <linux-kernel@PaulSD.com>
> 
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index b93fe83..12376d2 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -1267,18 +1267,11 @@ static int alps_decode_ss4_v2(struct alps_fields *f,
>  		break;
>  
>  	case SS4_PACKET_ID_STICK:
> -		if (!(priv->flags & ALPS_DUALPOINT)) {
> -			psmouse_warn(psmouse,
> -				     "Rejected trackstick packet from non DualPoint device");
> -		} else {
> -			int x = (s8)(((p[0] & 1) << 7) | (p[1] & 0x7f));
> -			int y = (s8)(((p[3] & 1) << 7) | (p[2] & 0x7f));
> -			int pressure = (s8)(p[4] & 0x7f);
> -
> -			input_report_rel(priv->dev2, REL_X, x);
> -			input_report_rel(priv->dev2, REL_Y, -y);
> -			input_report_abs(priv->dev2, ABS_PRESSURE, pressure);
> -		}
> +		f->st.x = (s8)(((p[0] & 1) << 7) | (p[1] & 0x7f));
> +		f->st.y = -(s8)(((p[3] & 1) << 7) | (p[2] & 0x7f));
> +		f->pressure = (s8)(p[4] & 0x7f);

This is not correct. Those fields values are used for single touch
events from touchpad -- not from trackstick.

Btw, you have access to packet also in process functions, so you can
extract x, y and pressure in process function too.

-- 
Pali Rohár
pali.rohar@gmail.com
