From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v4] hid-multitouch: migrate 3M PCT touch screens to
 hid-multitouch
Date: Tue, 22 Mar 2011 17:58:15 +0100
Message-ID: <20110322165815.GA6706@polaris.bitmath.org>
References: <AANLkTimFF3pgMMgOcEhYnRm5adgsCL5S6Hjkz+GFcpCT@mail.gmail.com>
 <1300811641-3327-1-git-send-email-benjamin.tissoires@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp04.sth.basefarm.net ([80.76.153.5]:33166 "EHLO
	ch-smtp04.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752265Ab1CVRDM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Mar 2011 13:03:12 -0400
Content-Disposition: inline
In-Reply-To: <1300811641-3327-1-git-send-email-benjamin.tissoires@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Mar 22, 2011 at 05:34:01PM +0100, Benjamin Tissoires wrote:
> This patch merges the hid-3m-pct driver into hid-multitouch.
> To keep devices working the same way they used to with hid-3m-pct,
> we need to add two signal/noise ratios for width and height.
> We also need to work on width/height to send proper
> ABS_MT_ORIENTATION flag.
>=20
> Importing 3M into hid-multitouch also solved the bug in which
> devices handling width and height in their report descriptors
> did not show ABS_MT_TOUCH_MAJOR and ABS_MT_TOUCH_MINOR.
>=20
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
> Reviewed-by: St=E9phane Chatty <chatty@enac.fr>
> ---
[...]
> Henrik, do I still have your Reviewed-and-tested-by ?

Yep, looks good. One more thing, though:

> @@ -332,11 +351,18 @@ static void mt_emit_event(struct mt_device *td,=
 struct input_dev *input)
>  		input_mt_report_slot_state(input, MT_TOOL_FINGER,
>  			s->touch_state);
>  		if (s->touch_state) {
> +			/* this finger is on the screen */
> +			int wide =3D (s->w > s->h);
> +			/* divided by two to match visual scale of touch */
> +			int major =3D max(s->w, s->h) >> 1;
> +			int minor =3D min(s->w, s->h) >> 1;

This scaling is most likely not correct for all devices. I went
through a set of devices some time ago, running mtview on all of them,
visually inspecting the touch size. Some were low by a factor of two,
some were high by a factor of two. A confirmation that the other
devices supported by this driver seem right would be good. If not, a
quirk should probably be added here.

> +
>  			input_event(input, EV_ABS, ABS_MT_POSITION_X, s->x);
>  			input_event(input, EV_ABS, ABS_MT_POSITION_Y, s->y);
> +			input_event(input, EV_ABS, ABS_MT_ORIENTATION, wide);
>  			input_event(input, EV_ABS, ABS_MT_PRESSURE, s->p);
> -			input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, s->w);
> -			input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, s->h);
> +			input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, major);
> +			input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, minor);
>  		}
>  		s->seen_in_this_frame =3D false;

Thanks,
Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
