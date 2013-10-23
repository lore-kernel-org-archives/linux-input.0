From: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH v3 1/1] Input: Improve the performance of alps
 v5-protocol's touchpad
Date: Tue, 22 Oct 2013 17:09:05 -0700
Message-ID: <CAJiQ=7DpFa+zxZ0EAQ48u3KLTJuh6OK4QdJqcfoeMm7EBZHU4w@mail.gmail.com>
References: <1382250180-3579-1-git-send-email-yunkang.tang@cn.alps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:58009 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526Ab3JWAJH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Oct 2013 20:09:07 -0400
Received: by mail-pa0-f42.google.com with SMTP id kx10so231702pab.29
        for <linux-input@vger.kernel.org>; Tue, 22 Oct 2013 17:09:05 -0700 (PDT)
In-Reply-To: <1382250180-3579-1-git-send-email-yunkang.tang@cn.alps.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yunkang Tang <tommywill2011@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, david turvene <dturvene@dahetral.com>, linux-input@vger.kernel.org, Niels de Vos <ndevos@redhat.com>, yunkang.tang@cn.alps.com

On Sat, Oct 19, 2013 at 11:23 PM, Yunkang Tang <tommywill2011@gmail.com> wrote:
>  /*
> + * Process bitmap data for V5 protocols. Return value is null.
> + *
> + * The bitmaps don't have enough data to track fingers, so this function
> + * only generates points representing a bounding box of at most two contacts.
> + * These two points are returned in x1, y1, x2, and y2.
> + */
> +static void alps_process_bitmap_dolphin(struct alps_data *priv,
> +                                        struct alps_fields *fields,
> +                                        int *x1, int *y1, int *x2, int *y2)
> +{
> +        int box_middle_x, box_middle_y;
> +        unsigned int x_map, y_map;
> +        unsigned char start_bit, end_bit;
> +
> +        x_map = fields->x_map;
> +        y_map = fields->y_map;
> +
> +        if (!x_map || !y_map)
> +                return;
> +
> +        /* Most-significant bit should never exceed max sensor line number */
> +        if (fls(x_map) > priv->x_bits || fls(y_map) > priv->y_bits)
> +                return;

fls() does require a little computation, so it might be preferable to
calculate it once and store the result.

> +
> +        *x1 = *y1 = *x2 = *y2 = 0;
> +
> +        if (fields->fingers > 1) {
> +                start_bit = priv->x_bits - fls(x_map);
> +                end_bit = priv->x_bits - ffs(x_map);
> +                box_middle_x = (priv->x_max * (start_bit + end_bit)) /
> +                                (2 * (priv->x_bits - 1));
> +
> +                start_bit = ffs(y_map) - 1;
> +                end_bit = fls(y_map) - 1;
> +                box_middle_y = (priv->y_max * (start_bit + end_bit)) /
> +                                (2 * (priv->y_bits - 1));

The revised logic looks good to me.

> +                *x1 = fields->x;
> +                *y1 = fields->y;
> +                *x2 = 2 * box_middle_x - *x1;
> +                *y2 = 2 * box_middle_y - *y1;
> +        }
> +}
> +
> +/*
>   * Process bitmap data from v3 and v4 protocols. Returns the number of
>   * fingers detected. A return value of 0 means at least one of the
>   * bitmaps was empty.
> @@ -461,7 +505,8 @@ static void alps_decode_buttons_v3(struct alps_fields *f, unsigned char *p)
>          f->ts_middle = !!(p[3] & 0x40);
>  }
>
> -static void alps_decode_pinnacle(struct alps_fields *f, unsigned char *p)
> +static void alps_decode_pinnacle(struct alps_fields *f, unsigned char *p,
> +                                 struct psmouse *psmouse)
>  {
>          f->first_mp = !!(p[4] & 0x40);
>          f->is_mp = !!(p[0] & 0x40);
> @@ -482,48 +527,61 @@ static void alps_decode_pinnacle(struct alps_fields *f, unsigned char *p)
>          alps_decode_buttons_v3(f, p);
>  }
>
> -static void alps_decode_rushmore(struct alps_fields *f, unsigned char *p)
> +static void alps_decode_rushmore(struct alps_fields *f, unsigned char *p,
> +                                 struct psmouse *psmouse)
>  {
> -        alps_decode_pinnacle(f, p);
> +        alps_decode_pinnacle(f, p, psmouse);
>
>          f->x_map |= (p[5] & 0x10) << 11;
>          f->y_map |= (p[5] & 0x20) << 6;
>  }
>
> -static void alps_decode_dolphin(struct alps_fields *f, unsigned char *p)
> +static void alps_decode_dolphin(struct alps_fields *f, unsigned char *p,
> +                                struct psmouse *psmouse)
>  {
> +        u64 palm_data = 0;
> +        struct alps_data *priv = psmouse->private;
> +
>          f->first_mp = !!(p[0] & 0x02);
>          f->is_mp = !!(p[0] & 0x20);
>
> -        f->fingers = ((p[0] & 0x6) >> 1 |
> +        if (!f->is_mp) {
> +                f->x = ((p[1] & 0x7f) | ((p[4] & 0x0f) << 7));
> +                f->y = ((p[2] & 0x7f) | ((p[4] & 0xf0) << 3));
> +                f->z = (p[0] & 4) ? 0 : p[5] & 0x7f;
> +                alps_decode_buttons_v3(f, p);
> +        } else {
> +                f->fingers = ((p[0] & 0x6) >> 1 |
>                       (p[0] & 0x10) >> 2);
> -        f->x_map = ((p[2] & 0x60) >> 5) |
> -                   ((p[4] & 0x7f) << 2) |
> -                   ((p[5] & 0x7f) << 9) |
> -                   ((p[3] & 0x07) << 16) |
> -                   ((p[3] & 0x70) << 15) |
> -                   ((p[0] & 0x01) << 22);
> -        f->y_map = (p[1] & 0x7f) |
> -                   ((p[2] & 0x1f) << 7);
> -
> -        f->x = ((p[1] & 0x7f) | ((p[4] & 0x0f) << 7));
> -        f->y = ((p[2] & 0x7f) | ((p[4] & 0xf0) << 3));
> -        f->z = (p[0] & 4) ? 0 : p[5] & 0x7f;
>
> -        alps_decode_buttons_v3(f, p);
> +                palm_data = (p[1] & 0x7f) |
> +                            ((p[2] & 0x7f) << 7) |
> +                            ((p[4] & 0x7f) << 14) |
> +                            ((p[5] & 0x7f) << 21) |
> +                            ((p[3] & 0x07) << 28) |
> +                            (((u64)p[3] & 0x70) << 27) |
> +                            (((u64)p[0] & 0x01) << 34);
> +
> +                /* Y-profile is stored in P(0) to p(n-1), n = y_bits; */
> +                f->y_map = palm_data & (BIT(priv->y_bits) - 1);
> +
> +                /* X-profile is stored in p(n) to p(n+m-1), m = x_bits; */
> +                f->x_map = (palm_data >> priv->y_bits) &
> +                           (BIT(priv->x_bits) - 1);
> +        }

This also looks OK.  For a touchpad with x_bits = 23, the computed MT
X/Y maps look equivalent to the old code.

[snip]

> +static int alps_dolphin_get_device_area(struct psmouse *psmouse,
> +                                        struct alps_data *priv)
> +{
> +        struct ps2dev *ps2dev = &psmouse->ps2dev;
> +        unsigned char param[4] = {0};
> +        int num_x_electrode, num_y_electrode;
> +
> +        if (alps_enter_command_mode(psmouse))
> +                return -1;
> +
> +        if (ps2_command(ps2dev, NULL, 0x00EC) ||
> +            ps2_command(ps2dev, NULL, 0x00F0) ||
> +            ps2_command(ps2dev, NULL, 0x00F0) ||
> +            ps2_command(ps2dev, NULL, 0x00F3) ||
> +            ps2_command(ps2dev, NULL, 0x000A) ||
> +            ps2_command(ps2dev, NULL, 0x00F3) ||
> +            ps2_command(ps2dev, NULL, 0x000A))
> +                return -1;

The other ps2_command() calls in alps.c tend to use the PSMOUSE_*
constants instead of raw hex values.

(Sorry I didn't catch this the first time around.)

Everything else looks fine.  So:

Reviewed-by: Kevin Cernekee <cernekee@gmail.com>
