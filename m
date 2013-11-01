From: Tommy Will <tommywill2011@gmail.com>
Subject: Re: [PATCH v4 1/1] Input: Improve the performance of alps
 v5-protocol's touchpad
Date: Fri, 1 Nov 2013 14:00:15 +0800
Message-ID: <CA+F6ckPto96MeDn81DmGSUPyz2V+EW=GER5MhhRX_Drvri1giw@mail.gmail.com>
References: <1382355711-3211-1-git-send-email-yunkang.tang@cn.alps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f54.google.com ([74.125.83.54]:61739 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002Ab3KAGAR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Nov 2013 02:00:17 -0400
Received: by mail-ee0-f54.google.com with SMTP id c50so1140364eek.27
        for <linux-input@vger.kernel.org>; Thu, 31 Oct 2013 23:00:15 -0700 (PDT)
In-Reply-To: <1382355711-3211-1-git-send-email-yunkang.tang@cn.alps.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Niels de Vos <ndevos@redhat.com>, Yunkang Tang <yunkang.tang@cn.alps.com>, david turvene <dturvene@dahetral.com>, Kevin Cernekee <cernekee@gmail.com>

Hi Dmitry,

Could you please share me your opinion of below patch. Thanks


2013/10/21 Yunkang Tang <tommywill2011@gmail.com>:
> Hi all,
>
> Here is the 4th version of supporting ALPS v5 protocol's device.
>
> Change since v3:
> - Fix the bug that Finger1's coordinate data will always be (0,0) when finger
>   number is more than 1.
>
> Change since v2:
> - Merge two patches into one patch because they're all for improving v5 device.
> - Modify the source code according to Kevin's suggestions.
>   1) Simplify the alps_process_bitmap() function by using ffs() and fls().
>   2) Simplify the alps_decode_dolphin() function by using u64 for the palm data.
>   3) Reuse the alps_process_touchpad_packet_v3() for v5 device.
>   4) Add an sample for calculating touchpad's x_max&y_max by using sensor line number.
>
> Self test with v5 device:
> - Checked on both 32-bit & 64-bit environment.
> - Cursor moves correctly.
> - 1Finger Tap/Drag works well.
> - 2Finger Tap works well.
> - 2Finger Scroll works well.
> - L/R Buttons do function
>
> Signed-off-by: Yunkang Tang <yunkang.tang@cn.alps.com>
> ---
>  drivers/input/mouse/alps.c | 217 ++++++++++++++++++++++++++++++++++++---------
>  drivers/input/mouse/alps.h |   7 +-
>  2 files changed, 183 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index ca7a26f..93f412d 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -257,6 +257,50 @@ static void alps_process_packet_v1_v2(struct psmouse *psmouse)
>  }
>
>  /*
> + * Process bitmap data for V5 protocols. Return value is null.
> + *
> + * The bitmaps don't have enough data to track fingers, so this function
> + * only generates points representing a bounding box of at most two contacts.
> + * These two points are returned in x1, y1, x2, and y2.
> + */
> +static void alps_process_bitmap_dolphin(struct alps_data *priv,
> +                                       struct alps_fields *fields,
> +                                       int *x1, int *y1, int *x2, int *y2)
> +{
> +       int box_middle_x, box_middle_y;
> +       unsigned int x_map, y_map;
> +       unsigned char start_bit, end_bit;
> +
> +       x_map = fields->x_map;
> +       y_map = fields->y_map;
> +
> +       if (!x_map || !y_map)
> +               return;
> +
> +       /* Most-significant bit should never exceed max sensor line number */
> +       if (fls(x_map) > priv->x_bits || fls(y_map) > priv->y_bits)
> +               return;
> +
> +       *x1 = *y1 = *x2 = *y2 = 0;
> +
> +       if (fields->fingers > 1) {
> +               start_bit = priv->x_bits - fls(x_map);
> +               end_bit = priv->x_bits - ffs(x_map);
> +               box_middle_x = (priv->x_max * (start_bit + end_bit)) /
> +                               (2 * (priv->x_bits - 1));
> +
> +               start_bit = ffs(y_map) - 1;
> +               end_bit = fls(y_map) - 1;
> +               box_middle_y = (priv->y_max * (start_bit + end_bit)) /
> +                               (2 * (priv->y_bits - 1));
> +               *x1 = fields->x;
> +               *y1 = fields->y;
> +               *x2 = 2 * box_middle_x - *x1;
> +               *y2 = 2 * box_middle_y - *y1;
> +       }
> +}
> +
> +/*
>   * Process bitmap data from v3 and v4 protocols. Returns the number of
>   * fingers detected. A return value of 0 means at least one of the
>   * bitmaps was empty.
> @@ -461,7 +505,8 @@ static void alps_decode_buttons_v3(struct alps_fields *f, unsigned char *p)
>         f->ts_middle = !!(p[3] & 0x40);
>  }
>
> -static void alps_decode_pinnacle(struct alps_fields *f, unsigned char *p)
> +static void alps_decode_pinnacle(struct alps_fields *f, unsigned char *p,
> +                                struct psmouse *psmouse)
>  {
>         f->first_mp = !!(p[4] & 0x40);
>         f->is_mp = !!(p[0] & 0x40);
> @@ -482,48 +527,61 @@ static void alps_decode_pinnacle(struct alps_fields *f, unsigned char *p)
>         alps_decode_buttons_v3(f, p);
>  }
>
> -static void alps_decode_rushmore(struct alps_fields *f, unsigned char *p)
> +static void alps_decode_rushmore(struct alps_fields *f, unsigned char *p,
> +                                struct psmouse *psmouse)
>  {
> -       alps_decode_pinnacle(f, p);
> +       alps_decode_pinnacle(f, p, psmouse);
>
>         f->x_map |= (p[5] & 0x10) << 11;
>         f->y_map |= (p[5] & 0x20) << 6;
>  }
>
> -static void alps_decode_dolphin(struct alps_fields *f, unsigned char *p)
> +static void alps_decode_dolphin(struct alps_fields *f, unsigned char *p,
> +                               struct psmouse *psmouse)
>  {
> +       u64 palm_data = 0;
> +       struct alps_data *priv = psmouse->private;
> +
>         f->first_mp = !!(p[0] & 0x02);
>         f->is_mp = !!(p[0] & 0x20);
>
> -       f->fingers = ((p[0] & 0x6) >> 1 |
> +       if (!f->is_mp) {
> +               f->x = ((p[1] & 0x7f) | ((p[4] & 0x0f) << 7));
> +               f->y = ((p[2] & 0x7f) | ((p[4] & 0xf0) << 3));
> +               f->z = (p[0] & 4) ? 0 : p[5] & 0x7f;
> +               alps_decode_buttons_v3(f, p);
> +       } else {
> +               f->fingers = ((p[0] & 0x6) >> 1 |
>                      (p[0] & 0x10) >> 2);
> -       f->x_map = ((p[2] & 0x60) >> 5) |
> -                  ((p[4] & 0x7f) << 2) |
> -                  ((p[5] & 0x7f) << 9) |
> -                  ((p[3] & 0x07) << 16) |
> -                  ((p[3] & 0x70) << 15) |
> -                  ((p[0] & 0x01) << 22);
> -       f->y_map = (p[1] & 0x7f) |
> -                  ((p[2] & 0x1f) << 7);
> -
> -       f->x = ((p[1] & 0x7f) | ((p[4] & 0x0f) << 7));
> -       f->y = ((p[2] & 0x7f) | ((p[4] & 0xf0) << 3));
> -       f->z = (p[0] & 4) ? 0 : p[5] & 0x7f;
>
> -       alps_decode_buttons_v3(f, p);
> +               palm_data = (p[1] & 0x7f) |
> +                           ((p[2] & 0x7f) << 7) |
> +                           ((p[4] & 0x7f) << 14) |
> +                           ((p[5] & 0x7f) << 21) |
> +                           ((p[3] & 0x07) << 28) |
> +                           (((u64)p[3] & 0x70) << 27) |
> +                           (((u64)p[0] & 0x01) << 34);
> +
> +               /* Y-profile is stored in P(0) to p(n-1), n = y_bits; */
> +               f->y_map = palm_data & (BIT(priv->y_bits) - 1);
> +
> +               /* X-profile is stored in p(n) to p(n+m-1), m = x_bits; */
> +               f->x_map = (palm_data >> priv->y_bits) &
> +                          (BIT(priv->x_bits) - 1);
> +       }
>  }
>
> -static void alps_process_touchpad_packet_v3(struct psmouse *psmouse)
> +static void alps_process_touchpad_packet_v3_v5(struct psmouse *psmouse)
>  {
>         struct alps_data *priv = psmouse->private;
>         unsigned char *packet = psmouse->packet;
>         struct input_dev *dev = psmouse->dev;
>         struct input_dev *dev2 = priv->dev2;
>         int x1 = 0, y1 = 0, x2 = 0, y2 = 0;
> -       int fingers = 0, bmap_fingers;
> -       struct alps_fields f;
> +       int fingers = 0, bmap_fn;
> +       struct alps_fields f = {0};
>
> -       priv->decode_fields(&f, packet);
> +       priv->decode_fields(&f, packet, psmouse);
>
>         /*
>          * There's no single feature of touchpad position and bitmap packets
> @@ -540,19 +598,38 @@ static void alps_process_touchpad_packet_v3(struct psmouse *psmouse)
>                  */
>                 if (f.is_mp) {
>                         fingers = f.fingers;
> -                       bmap_fingers = alps_process_bitmap(priv,
> -                                                          f.x_map, f.y_map,
> -                                                          &x1, &y1, &x2, &y2);
> -
> -                       /*
> -                        * We shouldn't report more than one finger if
> -                        * we don't have two coordinates.
> -                        */
> -                       if (fingers > 1 && bmap_fingers < 2)
> -                               fingers = bmap_fingers;
> -
> -                       /* Now process position packet */
> -                       priv->decode_fields(&f, priv->multi_data);
> +                       if (priv->proto_version == ALPS_PROTO_V3) {
> +                               bmap_fn = alps_process_bitmap(priv, f.x_map,
> +                                                             f.y_map, &x1, &y1,
> +                                                             &x2, &y2);
> +
> +                               /*
> +                                * We shouldn't report more than one finger if
> +                                * we don't have two coordinates.
> +                                */
> +                               if (fingers > 1 && bmap_fn < 2)
> +                                       fingers = bmap_fn;
> +
> +                               /* Now process position packet */
> +                               priv->decode_fields(&f, priv->multi_data,
> +                                                   psmouse);
> +                       } else {
> +                               /*
> +                                * Because Dolphin uses position packet's
> +                                * coordinate data as Pt1 and uses it to
> +                                * calculate Pt2, so we need to do position
> +                                * packet decode first.
> +                                */
> +                               priv->decode_fields(&f, priv->multi_data,
> +                                                   psmouse);
> +
> +                               /*
> +                                * Since Dolphin's finger number is reliable,
> +                                * there is no need to compare with bmap_fn.
> +                                */
> +                               alps_process_bitmap_dolphin(priv, &f, &x1, &y1,
> +                                                           &x2, &y2);
> +                       }
>                 } else {
>                         priv->multi_packet = 0;
>                 }
> @@ -642,7 +719,7 @@ static void alps_process_packet_v3(struct psmouse *psmouse)
>                 return;
>         }
>
> -       alps_process_touchpad_packet_v3(psmouse);
> +       alps_process_touchpad_packet_v3_v5(psmouse);
>  }
>
>  static void alps_process_packet_v4(struct psmouse *psmouse)
> @@ -742,6 +819,17 @@ static void alps_process_packet_v4(struct psmouse *psmouse)
>         input_sync(dev);
>  }
>
> +static void alps_process_packet_v5(struct psmouse *psmouse)
> +{
> +       unsigned char *packet = psmouse->packet;
> +
> +       /* Ignore stick point data */
> +       if (packet[0] == 0xD8)
> +               return;
> +
> +       alps_process_touchpad_packet_v3_v5(psmouse);
> +}
> +
>  static void alps_report_bare_ps2_packet(struct psmouse *psmouse,
>                                         unsigned char packet[],
>                                         bool report_buttons)
> @@ -1519,6 +1607,53 @@ error:
>         return -1;
>  }
>
> +static int alps_dolphin_get_device_area(struct psmouse *psmouse,
> +                                       struct alps_data *priv)
> +{
> +       struct ps2dev *ps2dev = &psmouse->ps2dev;
> +       unsigned char param[4] = {0};
> +       int num_x_electrode, num_y_electrode;
> +
> +       if (alps_enter_command_mode(psmouse))
> +               return -1;
> +
> +       if (ps2_command(ps2dev, NULL, 0x00EC) ||
> +           ps2_command(ps2dev, NULL, 0x00F0) ||
> +           ps2_command(ps2dev, NULL, 0x00F0) ||
> +           ps2_command(ps2dev, NULL, 0x00F3) ||
> +           ps2_command(ps2dev, NULL, 0x000A) ||
> +           ps2_command(ps2dev, NULL, 0x00F3) ||
> +           ps2_command(ps2dev, NULL, 0x000A))
> +               return -1;
> +
> +       if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
> +               return -1;
> +
> +       /*
> +        * Dolphin's sensor line number is not fixed. It can be calculated
> +        * by adding the device's register value with DOLPHIN_PROFILE_X/YOFFSET.
> +        * Further more, we can get device's x_max and y_max by multiplying
> +        * sensor line number with DOLPHIN_COUNT_PER_ELECTRODE.
> +        *
> +        * e.g. When we get register's sensor_x = 11 & sensor_y = 8,
> +        *      real sensor line number X = 11 + 8 = 19, and
> +        *      real sensor line number Y = 8 + 1 = 9.
> +        *      So, x_max = (19 - 1) * 64 = 1152, and
> +        *          y_max = (9 - 1) * 64 = 512.
> +        */
> +       num_x_electrode = DOLPHIN_PROFILE_XOFFSET + (param[2] & 0x0F);
> +       num_y_electrode = DOLPHIN_PROFILE_YOFFSET + ((param[2] >> 4) & 0x0F);
> +       priv->x_bits = num_x_electrode;
> +       priv->y_bits = num_y_electrode;
> +       priv->x_max = (num_x_electrode - 1) * DOLPHIN_COUNT_PER_ELECTRODE;
> +       priv->y_max = (num_y_electrode - 1) * DOLPHIN_COUNT_PER_ELECTRODE;
> +
> +       if (alps_exit_command_mode(psmouse))
> +               return -1;
> +
> +       return 0;
> +}
> +
>  static int alps_hw_init_dolphin_v1(struct psmouse *psmouse)
>  {
>         struct ps2dev *ps2dev = &psmouse->ps2dev;
> @@ -1571,7 +1706,7 @@ static void alps_set_defaults(struct alps_data *priv)
>                 break;
>         case ALPS_PROTO_V5:
>                 priv->hw_init = alps_hw_init_dolphin_v1;
> -               priv->process_packet = alps_process_packet_v3;
> +               priv->process_packet = alps_process_packet_v5;
>                 priv->decode_fields = alps_decode_dolphin;
>                 priv->set_abs_params = alps_set_abs_params_mt;
>                 priv->nibble_commands = alps_v3_nibble_commands;
> @@ -1645,11 +1780,13 @@ static int alps_identify(struct psmouse *psmouse, struct alps_data *priv)
>         if (alps_match_table(psmouse, priv, e7, ec) == 0) {
>                 return 0;
>         } else if (e7[0] == 0x73 && e7[1] == 0x03 && e7[2] == 0x50 &&
> -                  ec[0] == 0x73 && ec[1] == 0x01) {
> +                  ec[0] == 0x73 && (ec[1] == 0x01 || ec[1] == 0x02)) {
>                 priv->proto_version = ALPS_PROTO_V5;
>                 alps_set_defaults(priv);
> -
> -               return 0;
> +               if (alps_dolphin_get_device_area(psmouse, priv))
> +                       return -EIO;
> +               else
> +                       return 0;
>         } else if (ec[0] == 0x88 && ec[1] == 0x08) {
>                 priv->proto_version = ALPS_PROTO_V3;
>                 alps_set_defaults(priv);
> diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
> index eee5985..c5c53f4 100644
> --- a/drivers/input/mouse/alps.h
> +++ b/drivers/input/mouse/alps.h
> @@ -18,6 +18,10 @@
>  #define ALPS_PROTO_V4  4
>  #define ALPS_PROTO_V5  5
>
> +#define DOLPHIN_COUNT_PER_ELECTRODE    64
> +#define DOLPHIN_PROFILE_XOFFSET                8       /* x-electrode offset */
> +#define DOLPHIN_PROFILE_YOFFSET                1       /* y-electrode offset */
> +
>  /**
>   * struct alps_model_info - touchpad ID table
>   * @signature: E7 response string to match.
> @@ -145,7 +149,8 @@ struct alps_data {
>
>         int (*hw_init)(struct psmouse *psmouse);
>         void (*process_packet)(struct psmouse *psmouse);
> -       void (*decode_fields)(struct alps_fields *f, unsigned char *p);
> +       void (*decode_fields)(struct alps_fields *f, unsigned char *p,
> +                             struct psmouse *psmouse);
>         void (*set_abs_params)(struct alps_data *priv, struct input_dev *dev1);
>
>         int prev_fin;
> --
> 1.8.1.2
>



-- 
Best Regards,
Tommy
