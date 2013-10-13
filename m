From: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH v2 1/2] Add an additional argument for decode routine,
 change secondary device name
Date: Sun, 13 Oct 2013 09:23:24 -0700
Message-ID: <CAJiQ=7D9ZBKJcGgYT+3se92t2zn6nzJ8645CzWdB2xh1S60+nQ@mail.gmail.com>
References: <1379045010-3347-1-git-send-email-yunkang.tang@cn.alps.com>
	<1379045010-3347-2-git-send-email-yunkang.tang@cn.alps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:60654 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275Ab3JMQXZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Oct 2013 12:23:25 -0400
Received: by mail-pd0-f180.google.com with SMTP id y10so6377687pdj.11
        for <linux-input@vger.kernel.org>; Sun, 13 Oct 2013 09:23:24 -0700 (PDT)
In-Reply-To: <1379045010-3347-2-git-send-email-yunkang.tang@cn.alps.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yunkang Tang <tommywill2011@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, yunkang.tang@cn.alps.com, linux-input@vger.kernel.org, david turvene <dturvene@dahetral.com>

> [PATCH v2 2/2] Improve the performance of alps v5-protocol's touchpad
>
> From: Yunkang Tang <yunkang.tang@xxxxxxxxxxx>
>
> - Calculate the device's dimension in alps_identify().
> - Change the logic of packet decoding.
> - Add the new data process logic.
>
> Signed-off-by: Yunkang Tang <yunkang.tang@xxxxxxxxxxx>

Hmm, somehow the [2/2] patch made it into the linux-input list
archives, but linux-input did not forward it to my inbox so I missed
it the first time around.

But thanks for sending these changes.  There has been a great deal of
interest in enhancing ALPS touchpad support, especially for the
Dolphin models.

Some review comments follow:

> ---
>  drivers/input/mouse/alps.c | 278 ++++++++++++++++++++++++++++++++++++++++++---
>  drivers/input/mouse/alps.h |   4 +
>  2 files changed, 264 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 7e8a4fb..86c956a 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -257,6 +257,75 @@ static void alps_process_packet_v1_v2(struct psmouse *psmouse)
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
> +                    struct alps_fields *fields,
> +                    int *x1, int *y1, int *x2, int *y2)
> +{
> +    struct alps_palm_bitmap {
> +        int start_bit;
> +        int end_bit;
> +    };
> +
> +    int i;
> +    int box_middle_x, box_middle_y;
> +    unsigned int x_map, y_map;
> +    struct alps_palm_bitmap x_bitmap = {0}, y_bitmap = {0};
> +
> +    x_map = fields->x_map;
> +    y_map = fields->y_map;
> +
> +    if (!x_map || !y_map)
> +        return;
> +
> +    *x1 = *y1 = *x2 = *y2 = 0;
> +
> +    if (fields->fingers > 1) {
> +        for (i = 0;  i < 32; i++) {

Extra space after "i = 0;"

> +            if (x_map & (1 << i)) {
> +                x_bitmap.end_bit = priv->x_bits - i;
> +                break;
> +            }
> +        }
> +
> +        for (i = 31; i >= 0; i--) {
> +            if (x_map & (1 << i)) {
> +                x_bitmap.start_bit = priv->x_bits - i;
> +                break;
> +            }
> +        }
> +
> +        for (i = 0;  i < 32; i++) {

Same here

> +            if (y_map & (1 << i)) {
> +                y_bitmap.start_bit = i;
> +                break;
> +            }
> +        }

So, assuming x_bits == y_bits == 8, and both x_map and y_map are in
the range 0x00..0xff:

y_bitmap.* lies in the range 0..7
x_bitmap.* lies in the range 1..8

Is that correct, or is x_bitmap off by one?

> +        for (i = 31; i >= 0; i--) {
> +            if (y_map & (1 << i)) {
> +                y_bitmap.end_bit = i;
> +                break;
> +            }
> +        }

I suspect that this whole function could be simplified a bit.

Would it be possible to use ffs() and fls() instead of loops?

Just a personal preference, but if you calculated X first and then Y,
it may require fewer temporary variables and the alps_palm_bitmap
struct could be removed.

> +
> +        box_middle_x = (priv->x_max * (x_bitmap.start_bit + x_bitmap.end_bit)) /
> +                (2 * (priv->x_bits - 1));
> +        box_middle_y = (priv->y_max * (y_bitmap.start_bit + y_bitmap.end_bit)) /
> +                (2 * (priv->y_bits - 1));

These lines look a bit long - suggest running through checkpatch.pl

I assume start_bit and end_bit can never be negative, because the code
that calculates e.g. x_map will populate at most bits 0..(x_bits-1)?

> +        *x1 = fields->x;
> +        *y1 = fields->y;
> +        *x2 = 2 * box_middle_x - *x1;
> +        *y2 = 2 * box_middle_y - *y1;
> +    }
> +}
> +
> +/*
>   * Process bitmap data from v3 and v4 protocols. Returns the number of
>   * fingers detected. A return value of 0 means at least one of the
>   * bitmaps was empty.
> @@ -495,25 +564,55 @@ static void alps_decode_rushmore(struct alps_fields *f, unsigned char *p,
>  static void alps_decode_dolphin(struct alps_fields *f, unsigned char *p,
>                  struct psmouse *psmouse)
>  {
> +    unsigned int palm_high = 0, palm_low = 0, palm_mask = 0;
> +    int i, remain_xbits;
> +    struct alps_data *priv = psmouse->private;
> +
>      f->first_mp = !!(p[0] & 0x02);
>      f->is_mp = !!(p[0] & 0x20);
>
> -    f->fingers = ((p[0] & 0x6) >> 1 |
> +    if (!f->is_mp) {
> +        f->x = ((p[1] & 0x7f) | ((p[4] & 0x0f) << 7));
> +        f->y = ((p[2] & 0x7f) | ((p[4] & 0xf0) << 3));
> +        f->z = (p[0] & 4) ? 0 : p[5] & 0x7f;
> +        alps_decode_buttons_v3(f, p);
> +    } else {
> +        f->fingers = ((p[0] & 0x6) >> 1 |
>               (p[0] & 0x10) >> 2);
> -    f->x_map = ((p[2] & 0x60) >> 5) |
> -           ((p[4] & 0x7f) << 2) |
> -           ((p[5] & 0x7f) << 9) |
> -           ((p[3] & 0x07) << 16) |
> -           ((p[3] & 0x70) << 15) |
> -           ((p[0] & 0x01) << 22);
> -    f->y_map = (p[1] & 0x7f) |
> -           ((p[2] & 0x1f) << 7);
> -
> -    f->x = ((p[1] & 0x7f) | ((p[4] & 0x0f) << 7));
> -    f->y = ((p[2] & 0x7f) | ((p[4] & 0xf0) << 3));
> -    f->z = (p[0] & 4) ? 0 : p[5] & 0x7f;
>
> -    alps_decode_buttons_v3(f, p);
> +        palm_low = (p[1] & 0x7f) |
> +               ((p[2] & 0x7f) << 7) |
> +               ((p[4] & 0x7f) << 14) |
> +               ((p[5] & 0x7f) << 21) |
> +               ((p[3] & 0x07) << 28) | ((p[3] & 0x10) << 27);
> +        palm_high = ((p[3] & 0x60) >> 5) | ((p[0] & 0x01) << 2);
> +
> +        for (i = 0; i < priv->y_bits; i++)
> +            palm_mask |= 1 << i;
> +
> +        /* Y-profile is stored in P(0) to p(n), n = y_bits; */
> +        f->y_map = palm_low & palm_mask;

Suggest something like:

f->y_map = palm_low & (BIT(priv->y_bits) - 1);

> +
> +        /* X-profile is stored in p(n) to p(n+x_bits). */
> +        palm_mask = 0;
> +        for (i = priv->y_bits; i < 32 && i < priv->y_bits + priv->x_bits; i++)
> +            palm_mask |= 1 << i;
> +
> +        f->x_map = ((palm_low & (palm_mask)) >> priv->y_bits);

Likewise, maybe use:

f->x_map = (palm_low >> priv->y_bits) & (BIT(priv->x_bits) - 1);

(but double-check my math first)

> +
> +        /*
> +         * In some cases, palm_low's 32bit is not enough to save
> +         * all X&Y-profiles, we need to use palm_high.
> +         */
> +        remain_xbits = priv->x_bits + priv->y_bits - 32;
> +        if (remain_xbits > 0) {
> +            palm_mask = 0;
> +            for (i = 0; i < remain_xbits; i++)
> +                palm_mask |= 1 << i;
> +
> +            f->x_map |= ((palm_high & palm_mask) << (32 - priv->y_bits));

Would it be cleaner to just use a u64 for the palm data, instead of
splitting into low/high?  (If so you'll probably want to compile-test
a 32-bit kernel.)

> +        }
> +    }
>  }
>
>  static void alps_process_touchpad_packet_v3(struct psmouse *psmouse)
> @@ -745,6 +844,112 @@ static void alps_process_packet_v4(struct psmouse *psmouse)
>      input_sync(dev);
>  }
>
> +
> +static void alps_process_touchpad_packet_v5(struct psmouse *psmouse)
> +{
> +    struct alps_data *priv = psmouse->private;
> +    unsigned char *packet = psmouse->packet;
> +    struct input_dev *dev = psmouse->dev;
> +    int x1 = 0, y1 = 0, x2 = 0, y2 = 0;
> +    int fingers = 0;
> +    struct alps_fields f;
> +
> +    priv->decode_fields(&f, packet, psmouse);
> +
> +    /*
> +     * There's no single feature of touchpad position and bitmap packets
> +     * that can be used to distinguish between them. We rely on the fact
> +     * that a bitmap packet should always follow a position packet with
> +     * bit 6 of packet[4] set.
> +     */
> +    if (priv->multi_packet) {
> +        /*
> +         * Sometimes a position packet will indicate a multi-packet
> +         * sequence, but then what follows is another position
> +         * packet. Check for this, and when it happens process the
> +         * position packet as usual.
> +         */
> +        if (f.is_mp) {
> +            fingers = f.fingers;
> +            priv->decode_fields(&f, priv->multi_data, psmouse);
> +            alps_process_bitmap_dolphin(priv, &f, &x1, &y1,
> +                            &x2, &y2);

Aside from this clause, alps_process_touchpad_packet_v5() is virtually
identical to alps_process_touchpad_packet_v3().  It would be good to
find a way to reuse more of the code.

> +        } else {
> +            priv->multi_packet = 0;
> +        }
> +    }
> +
> +    /*
> +     * Bit 6 of byte 0 is not usually set in position packets. The only
> +     * times it seems to be set is in situations where the data is
> +     * suspect anyway, e.g. a palm resting flat on the touchpad. Given
> +     * this combined with the fact that this bit is useful for filtering
> +     * out misidentified bitmap packets, we reject anything with this
> +     * bit set.
> +     */
> +    if (f.is_mp)
> +        return;
> +
> +    if (!priv->multi_packet && f.first_mp) {
> +        priv->multi_packet = 1;
> +        memcpy(priv->multi_data, packet, sizeof(priv->multi_data));
> +        return;
> +    }
> +
> +    priv->multi_packet = 0;
> +
> +    /*
> +     * Sometimes the hardware sends a single packet with z = 0
> +     * in the middle of a stream. Real releases generate packets
> +     * with x, y, and z all zero, so these seem to be flukes.
> +     * Ignore them.
> +     */
> +    if (f.x && f.y && !f.z)
> +        return;
> +
> +    /*
> +     * If we don't have MT data or the bitmaps were empty, we have
> +     * to rely on ST data.
> +     */
> +    if (!fingers) {
> +        x1 = f.x;
> +        y1 = f.y;
> +        fingers = f.z > 0 ? 1 : 0;
> +    }
> +
> +    if (f.z >= 64)
> +        input_report_key(dev, BTN_TOUCH, 1);
> +    else
> +        input_report_key(dev, BTN_TOUCH, 0);
> +
> +    alps_report_semi_mt_data(dev, fingers, x1, y1, x2, y2);
> +
> +    input_mt_report_finger_count(dev, fingers);
> +
> +    input_report_key(dev, BTN_LEFT, f.left);
> +    input_report_key(dev, BTN_RIGHT, f.right);
> +    input_report_key(dev, BTN_MIDDLE, f.middle);
> +
> +    if (f.z > 0) {
> +        input_report_abs(dev, ABS_X, f.x);
> +        input_report_abs(dev, ABS_Y, f.y);
> +    }
> +    input_report_abs(dev, ABS_PRESSURE, f.z);
> +
> +    input_sync(dev);
> +}
> +
> +static void alps_process_packet_v5(struct psmouse *psmouse)
> +{
> +    unsigned char *packet = psmouse->packet;
> +
> +    /* Ignore stick point data */
> +    if (packet[0] == 0xD8)
> +        return;
> +
> +    alps_process_touchpad_packet_v5(psmouse);
> +}
> +
>  static void alps_report_bare_ps2_packet(struct psmouse *psmouse,
>                      unsigned char packet[],
>                      bool report_buttons)
> @@ -1522,6 +1727,41 @@ error:
>      return -1;
>  }
>
> +static int alps_dolphin_get_device_area(struct psmouse *psmouse,
> +                    struct alps_data *priv)
> +{
> +    struct ps2dev *ps2dev = &psmouse->ps2dev;
> +    unsigned char param[4] = {0};
> +    int num_x_electrode, num_y_electrode;
> +
> +    if (alps_enter_command_mode(psmouse))
> +        return -1;
> +
> +    if (ps2_command(ps2dev, NULL, 0x00EC) ||
> +        ps2_command(ps2dev, NULL, 0x00F0) ||
> +        ps2_command(ps2dev, NULL, 0x00F0) ||
> +        ps2_command(ps2dev, NULL, 0x00F3) ||
> +        ps2_command(ps2dev, NULL, 0x000A) ||
> +        ps2_command(ps2dev, NULL, 0x00F3) ||
> +        ps2_command(ps2dev, NULL, 0x000A))
> +        return -1;
> +
> +    if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
> +        return -1;
> +
> +    num_x_electrode = DOLPHIN_PROFILE_XOFFSET + (param[2] & 0x0F);
> +    num_y_electrode = DOLPHIN_PROFILE_YOFFSET + ((param[2] >> 4) & 0x0F);

This is strictly optional, but adding a comment indicating typical
values for num_x_electrode and num_y_electrode could aid in
understanding the math.

> +    priv->x_bits = num_x_electrode;
> +    priv->y_bits = num_y_electrode;
> +    priv->x_max = (num_x_electrode - 1) * DOLPHIN_COUNT_PER_ELECTRODE;
> +    priv->y_max = (num_y_electrode - 1) * DOLPHIN_COUNT_PER_ELECTRODE;
> +
> +    if (alps_exit_command_mode(psmouse))
> +        return -1;
> +
> +    return 0;
> +}
> +
>  static int alps_hw_init_dolphin_v1(struct psmouse *psmouse)
>  {
>      struct ps2dev *ps2dev = &psmouse->ps2dev;
> @@ -1574,7 +1814,7 @@ static void alps_set_defaults(struct alps_data *priv)
>          break;
>      case ALPS_PROTO_V5:
>          priv->hw_init = alps_hw_init_dolphin_v1;
> -        priv->process_packet = alps_process_packet_v3;
> +        priv->process_packet = alps_process_packet_v5;
>          priv->decode_fields = alps_decode_dolphin;
>          priv->set_abs_params = alps_set_abs_params_mt;
>          priv->nibble_commands = alps_v3_nibble_commands;
> @@ -1648,11 +1888,13 @@ static int alps_identify(struct psmouse *psmouse, struct alps_data *priv)
>      if (alps_match_table(psmouse, priv, e7, ec) == 0) {
>          return 0;
>      } else if (e7[0] == 0x73 && e7[1] == 0x03 && e7[2] == 0x50 &&
> -           ec[0] == 0x73 && ec[1] == 0x01) {
> +           ec[0] == 0x73 && (ec[1] == 0x01 || ec[1] == 0x02)) {
>          priv->proto_version = ALPS_PROTO_V5;
>          alps_set_defaults(priv);
> -
> -        return 0;
> +        if (alps_dolphin_get_device_area(psmouse, priv))
> +            return -EIO;
> +        else
> +            return 0;
>      } else if (ec[0] == 0x88 && ec[1] == 0x08) {
>          priv->proto_version = ALPS_PROTO_V3;
>          alps_set_defaults(priv);
> diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
> index cdc10f3..43d89fc7 100644
> --- a/drivers/input/mouse/alps.h
> +++ b/drivers/input/mouse/alps.h
> @@ -18,6 +18,10 @@
>  #define ALPS_PROTO_V4    4
>  #define ALPS_PROTO_V5    5
>
> +#define DOLPHIN_COUNT_PER_ELECTRODE    64
> +#define DOLPHIN_PROFILE_XOFFSET        8    /* x-electrode offset */
> +#define DOLPHIN_PROFILE_YOFFSET        1    /* y-electrode offset */
> +
>  /**
>   * struct alps_model_info - touchpad ID table
>   * @signature: E7 response string to match.
