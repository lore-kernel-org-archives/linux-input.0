From: Tommy Will <tommywill2011@gmail.com>
Subject: Re: [PATCH v2] Input:Add support for DualPoint device on Dell XT2 model
Date: Wed, 27 Nov 2013 16:19:05 +0800
Message-ID: <CA+F6ckOPi2tmQxLtsWkcyvEb3ZnP2BK50Jj-9iZrXpBm11M56A@mail.gmail.com>
References: <1384524702-3411-1-git-send-email-yunkang.tang@cn.alps.com>
	<20131127001822.GB15452@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:63976 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754869Ab3K0ITH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Nov 2013 03:19:07 -0500
Received: by mail-we0-f170.google.com with SMTP id w61so6507194wes.29
        for <linux-input@vger.kernel.org>; Wed, 27 Nov 2013 00:19:05 -0800 (PST)
In-Reply-To: <20131127001822.GB15452@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kevin Cernekee <cernekee@gmail.com>, david turvene <dturvene@dahetral.com>, linux-input@vger.kernel.org, Niels de Vos <ndevos@redhat.com>, Justin Clift <jclift@redhat.com>, Yunkang Tang <yunkang.tang@cn.alps.com>

Hi Dmitry,

Thanks for your reply.

>
> It would help greatly if you could document what parameters the new
> initialization routine sets.
>
Ok, please let me explain what I did in initialization.

>+static int alps_hw_init_v6(struct psmouse *psmouse)
>+{
>+     unsigned char param[2] = {0xC8, 0x14};
>+
>+     /* Enter passthrough mode to let trackpoint enter 6byte raw mode */
>+     if (alps_passthrough_mode_v2(psmouse, true))
>+             return -1;

In order to initialize the trackpoint, we must first send command to
enter passthrough mode so that the following
command can directly be sent to trackpoint device.

+
>+     if (ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSCALE11) ||
>+         ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSCALE11) ||
>+         ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSCALE11) ||
>+         ps2_command(&psmouse->ps2dev, &param[0], PSMOUSE_CMD_SETRATE) ||
>+         ps2_command(&psmouse->ps2dev, &param[1], PSMOUSE_CMD_SETRATE))
>+             return -1;
>+

Here are the commands to let trackpoint device enter 6byte raw mode.
Because of the special MPU being
used in this device, trackpoint's packet would always be encapsulated
to the same packet size as Touchpad's.
So, when touchpad is in 6byte mode, we should also let trackpoint in
6byte mode or trackpoint's output data would be messed.
That's what spec requested.

+     if (alps_passthrough_mode_v2(psmouse, false))
+             return -1;
+

Stop talking with trackpoint.

+     if (alps_absolute_mode_v6(psmouse)) {
+             psmouse_err(psmouse, "Failed to enable absolute mode\n");
+             return -1;
+     }
+

Let touchpad enter 6byte raw mode.

+     return 0;
+}

And in alps_absolute_mode_v6() function. Please notice that there are
two kinds of
6byte mode for this device. Let's temporary define them as RawModeA & RawModeB.
Method to enter RawModeA:   Send ALPS magic knock commad [F5 F5 F5
F5]. (Same as protocol v2)
Method to enter RawModeB:   Write 0x181 to 0x000 register. (New)

I checked spec and found RawModeB was suggested and now being used in
Windows driver.
Maybe the reason is it could provide a more accurate data output.
In RawModeA, data output range is X:[0-1023], Y:[0-767], but
in RawModeB, its range is X:[0-2047], Y:[0-1535].

#Probably have any other reason that I did not know, so, I chose a
safety way that was suggested
by the spec although it needs adding much more source code.


> +static int alps_absolute_mode_v6(struct psmouse *psmouse)
> +{
> +     u16 reg_val = 0x181;
> +     int ret = -1;
> +

What we want to do is write 0x181 to 0x000 register. That would let
device enter RawModeB.

> +     /* enter monitor mode, to write the register */
> +     if (alps_monitor_mode(psmouse, true))
> +             return -1;
> +
> +     ret = alps_monitor_mode_write_reg(psmouse, 0x000, reg_val);
> +
> +     if (alps_monitor_mode(psmouse, false))
> +             ret = -1;
> +
> +     return ret;
> +}


>>    3. Add new packet process logic.
>
> I am curious why we need the new packet processing logic. Apparently the
> touchpad can work in the original mode that we already know how to
> parse; we just need to make sure the trackpoint is initialized properly.
> Or yet another protocol flavor is a must?
>
Yes, you're right, as long as initialized trackpoint to 6byte raw mode
and add decode logic into
alps_process_packet_v1_v2(), both touchpad and trackpoint can work correctly.

However, as I wrote in previous, spec suggested me to use another
protocol to co-work with
trackpoint's 6byte mode. So, I just did follow the spec.

BTW, could you please let me know if you have any concern of adding a
new protocol?
In my opinion, assume that there would be no side-effect by using
original touchpad
protocol + new 6byte trackpoint protocol, although I could reuse the
alps_process_packet_v1_v2(),
I had to add a new flag to adjust the original logic to support
trackpoint's 6byte decoding,
which would also make source code harder to understand.

Please kindly share me your opinion of that. Thanks!

Best Regards,
Tommy Will



> Thanks!
>
>>    # Touchpad's dimension is 2047*1535.
>>
>> SelfTest:
>>  1. Move on touchpad -- OK
>>  2. Vertical/Horizontal wheel on touchpad -- OK
>>  3. Tap / Tap and drag on touchpad -- OK
>>  4. Click with touchpad's L/R button -- OK
>>  5. Move on touchpad with pressing touchpad's button -- OK
>>  6. Move on trackpoint -- OK
>>  7. Click with trackpoint's L/R button -- OK
>>  8. Move on trackpoint with pressing trackpoint's button -- OK
>>  9. Move cursor with both touchpad and trackpoint -- OK
>>  10. Move on touchpad with pressing trackpoint's button -- OK
>>  11. Move on trackpoint with pressing touchpad's button -- OK
>>
>>  Thanks
>>
>> Signed-off-by: Yunkang Tang <yunkang.tang@cn.alps.com>
>> ---
>>  drivers/input/mouse/alps.c | 206 ++++++++++++++++++++++++++++++++++++++++++++-
>>  drivers/input/mouse/alps.h |   1 +
>>  2 files changed, 204 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
>> index ca7a26f..5cf62e3 100644
>> --- a/drivers/input/mouse/alps.c
>> +++ b/drivers/input/mouse/alps.c
>> @@ -70,6 +70,25 @@ static const struct alps_nibble_commands alps_v4_nibble_commands[] = {
>>       { PSMOUSE_CMD_SETSCALE11,       0x00 }, /* f */
>>  };
>>
>> +static const struct alps_nibble_commands alps_v6_nibble_commands[] = {
>> +     { PSMOUSE_CMD_ENABLE,           0x00 }, /* 0 */
>> +     { PSMOUSE_CMD_SETRATE,          0x0a }, /* 1 */
>> +     { PSMOUSE_CMD_SETRATE,          0x14 }, /* 2 */
>> +     { PSMOUSE_CMD_SETRATE,          0x28 }, /* 3 */
>> +     { PSMOUSE_CMD_SETRATE,          0x3c }, /* 4 */
>> +     { PSMOUSE_CMD_SETRATE,          0x50 }, /* 5 */
>> +     { PSMOUSE_CMD_SETRATE,          0x64 }, /* 6 */
>> +     { PSMOUSE_CMD_SETRATE,          0xc8 }, /* 7 */
>> +     { PSMOUSE_CMD_GETID,            0x00 }, /* 8 */
>> +     { PSMOUSE_CMD_GETINFO,          0x00 }, /* 9 */
>> +     { PSMOUSE_CMD_SETRES,           0x00 }, /* a */
>> +     { PSMOUSE_CMD_SETRES,           0x01 }, /* b */
>> +     { PSMOUSE_CMD_SETRES,           0x02 }, /* c */
>> +     { PSMOUSE_CMD_SETRES,           0x03 }, /* d */
>> +     { PSMOUSE_CMD_SETSCALE21,       0x00 }, /* e */
>> +     { PSMOUSE_CMD_SETSCALE11,       0x00 }, /* f */
>> +};
>> +
>>
>>  #define ALPS_DUALPOINT               0x02    /* touchpad has trackstick */
>>  #define ALPS_PASS            0x04    /* device has a pass-through port */
>> @@ -103,6 +122,7 @@ static const struct alps_model_info alps_model_data[] = {
>>       /* Dell Latitude E5500, E6400, E6500, Precision M4400 */
>>       { { 0x62, 0x02, 0x14 }, 0x00, ALPS_PROTO_V2, 0xcf, 0xcf,
>>               ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED },
>> +     { { 0x73, 0x00, 0x14 }, 0x00, ALPS_PROTO_V6, 0xff, 0xff, ALPS_DUALPOINT },              /* Dell XT2 */
>>       { { 0x73, 0x02, 0x50 }, 0x00, ALPS_PROTO_V2, 0xcf, 0xcf, ALPS_FOUR_BUTTONS },           /* Dell Vostro 1400 */
>>       { { 0x52, 0x01, 0x14 }, 0x00, ALPS_PROTO_V2, 0xff, 0xff,
>>               ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED },                            /* Toshiba Tecra A11-11L */
>> @@ -645,6 +665,76 @@ static void alps_process_packet_v3(struct psmouse *psmouse)
>>       alps_process_touchpad_packet_v3(psmouse);
>>  }
>>
>> +static void alps_process_packet_v6(struct psmouse *psmouse)
>> +{
>> +     struct alps_data *priv = psmouse->private;
>> +     unsigned char *packet = psmouse->packet;
>> +     struct input_dev *dev = psmouse->dev;
>> +     struct input_dev *dev2 = priv->dev2;
>> +     int x, y, z, left, right, middle;
>> +
>> +     /*
>> +      * We can use Byte5 to distinguish if the packet is from Touchpad
>> +      * or Trackpoint.
>> +      * Touchpad:    0 - 0x7E
>> +      * Trackpoint:  0x7F
>> +      */
>> +     if (packet[5] == 0x7F) {
>> +             /* It should be a DualPoint when received Trackpoint packet */
>> +             if (!(priv->flags & ALPS_DUALPOINT))
>> +                     return;
>> +
>> +             /* Trackpoint packet */
>> +             x = packet[1] | ((packet[3] & 0x20) << 2);
>> +             y = packet[2] | ((packet[3] & 0x40) << 1);
>> +             z = packet[4];
>> +             left = packet[3] & 0x01;
>> +             right = packet[3] & 0x02;
>> +             middle = packet[3] & 0x04;
>> +
>> +             /* To prevent the cursor jump when finger lifted */
>> +             if (x == 0x7F && y == 0x7F && z == 0x7F)
>> +                     x = y = z = 0;
>> +
>> +             /* Divide 4 since trackpoint's speed is too fast */
>> +             input_report_rel(dev2, REL_X, (char)x / 4);
>> +             input_report_rel(dev2, REL_Y, -((char)y / 4));
>> +
>> +             input_report_key(dev2, BTN_LEFT, left);
>> +             input_report_key(dev2, BTN_RIGHT, right);
>> +             input_report_key(dev2, BTN_MIDDLE, middle);
>> +
>> +             input_sync(dev2);
>> +             return;
>> +     }
>> +
>> +     /* Touchpad packet */
>> +     x = packet[1] | ((packet[3] & 0x78) << 4);
>> +     y = packet[2] | ((packet[4] & 0x78) << 4);
>> +     z = packet[5];
>> +     left = packet[3] & 0x01;
>> +     right = packet[3] & 0x02;
>> +
>> +     if (z > 30)
>> +             input_report_key(dev, BTN_TOUCH, 1);
>> +     if (z < 25)
>> +             input_report_key(dev, BTN_TOUCH, 0);
>> +
>> +     if (z > 0) {
>> +             input_report_abs(dev, ABS_X, x);
>> +             input_report_abs(dev, ABS_Y, y);
>> +     }
>> +
>> +     input_report_abs(dev, ABS_PRESSURE, z);
>> +     input_report_key(dev, BTN_TOOL_FINGER, z > 0);
>> +
>> +     /* v6 touchpad does not have middle button */
>> +     input_report_key(dev, BTN_LEFT, left);
>> +     input_report_key(dev, BTN_RIGHT, right);
>> +
>> +     input_sync(dev);
>> +}
>> +
>>  static void alps_process_packet_v4(struct psmouse *psmouse)
>>  {
>>       struct alps_data *priv = psmouse->private;
>> @@ -897,7 +987,7 @@ static psmouse_ret_t alps_process_byte(struct psmouse *psmouse)
>>       }
>>
>>       /* Bytes 2 - pktsize should have 0 in the highest bit */
>> -     if (priv->proto_version != ALPS_PROTO_V5 &&
>> +     if ((priv->proto_version < ALPS_PROTO_V5) &&
>>           psmouse->pktcnt >= 2 && psmouse->pktcnt <= psmouse->pktsize &&
>>           (psmouse->packet[psmouse->pktcnt - 1] & 0x80)) {
>>               psmouse_dbg(psmouse, "refusing packet[%i] = %x\n",
>> @@ -1085,6 +1175,80 @@ static int alps_absolute_mode_v1_v2(struct psmouse *psmouse)
>>       return ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETPOLL);
>>  }
>>
>> +static int alps_monitor_mode_send_word(struct psmouse *psmouse, u16 word)
>> +{
>> +     int i, nibble;
>> +
>> +     /*
>> +      * b0-b11 are valid bits, send sequence is inverse.
>> +      * e.g. when word = 0x0123, nibble send sequence is 3, 2, 1
>> +      */
>> +     for (i = 0; i <= 8; i += 4) {
>> +             nibble = (word >> i) & 0xf;
>> +             if (alps_command_mode_send_nibble(psmouse, nibble))
>> +                     return -1;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int alps_monitor_mode_write_reg(struct psmouse *psmouse,
>> +                                    u16 addr, u16 value)
>> +{
>> +     struct ps2dev *ps2dev = &psmouse->ps2dev;
>> +
>> +     /* 0x0A0 is the command to write the word */
>> +     if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_ENABLE) ||
>> +         alps_monitor_mode_send_word(psmouse, 0x0A0) ||
>> +         alps_monitor_mode_send_word(psmouse, addr) ||
>> +         alps_monitor_mode_send_word(psmouse, value) ||
>> +         ps2_command(ps2dev, NULL, PSMOUSE_CMD_DISABLE))
>> +             return -1;
>> +
>> +     return 0;
>> +}
>> +
>> +static int alps_monitor_mode(struct psmouse *psmouse, bool enable)
>> +{
>> +     struct ps2dev *ps2dev = &psmouse->ps2dev;
>> +
>> +     if (enable) {
>> +             /* EC E9 F5 F5 E7 E6 E7 E9 to enter monitor mode */
>> +             if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_RESET_WRAP) ||
>> +                 ps2_command(ps2dev, NULL, PSMOUSE_CMD_GETINFO) ||
>> +                 ps2_command(ps2dev, NULL, PSMOUSE_CMD_DISABLE) ||
>> +                 ps2_command(ps2dev, NULL, PSMOUSE_CMD_DISABLE) ||
>> +                 ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE21) ||
>> +                 ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE11) ||
>> +                 ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE21) ||
>> +                 ps2_command(ps2dev, NULL, PSMOUSE_CMD_GETINFO))
>> +                     return -1;
>> +     } else {
>> +             /* EC to exit monitor mode */
>> +             if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_RESET_WRAP))
>> +                     return -1;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int alps_absolute_mode_v6(struct psmouse *psmouse)
>> +{
>> +     u16 reg_val = 0x181;
>> +     int ret = -1;
>> +
>> +     /* enter monitor mode, to write the register */
>> +     if (alps_monitor_mode(psmouse, true))
>> +             return -1;
>> +
>> +     ret = alps_monitor_mode_write_reg(psmouse, 0x000, reg_val);
>> +
>> +     if (alps_monitor_mode(psmouse, false))
>> +             ret = -1;
>> +
>> +     return ret;
>> +}
>> +
>>  static int alps_get_status(struct psmouse *psmouse, char *param)
>>  {
>>       /* Get status: 0xF5 0xF5 0xF5 0xE9 */
>> @@ -1189,6 +1353,32 @@ static int alps_hw_init_v1_v2(struct psmouse *psmouse)
>>       return 0;
>>  }
>>
>> +static int alps_hw_init_v6(struct psmouse *psmouse)
>> +{
>> +     unsigned char param[2] = {0xC8, 0x14};
>> +
>> +     /* Enter passthrough mode to let trackpoint enter 6byte raw mode */
>> +     if (alps_passthrough_mode_v2(psmouse, true))
>> +             return -1;
>> +
>> +     if (ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSCALE11) ||
>> +         ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSCALE11) ||
>> +         ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSCALE11) ||
>> +         ps2_command(&psmouse->ps2dev, &param[0], PSMOUSE_CMD_SETRATE) ||
>> +         ps2_command(&psmouse->ps2dev, &param[1], PSMOUSE_CMD_SETRATE))
>> +             return -1;
>> +
>> +     if (alps_passthrough_mode_v2(psmouse, false))
>> +             return -1;
>> +
>> +     if (alps_absolute_mode_v6(psmouse)) {
>> +             psmouse_err(psmouse, "Failed to enable absolute mode\n");
>> +             return -1;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>>  /*
>>   * Enable or disable passthrough mode to the trackstick.
>>   */
>> @@ -1553,6 +1743,8 @@ static void alps_set_defaults(struct alps_data *priv)
>>               priv->hw_init = alps_hw_init_v1_v2;
>>               priv->process_packet = alps_process_packet_v1_v2;
>>               priv->set_abs_params = alps_set_abs_params_st;
>> +             priv->x_max = 1023;
>> +             priv->y_max = 767;
>>               break;
>>       case ALPS_PROTO_V3:
>>               priv->hw_init = alps_hw_init_v3;
>> @@ -1584,6 +1776,14 @@ static void alps_set_defaults(struct alps_data *priv)
>>               priv->x_bits = 23;
>>               priv->y_bits = 12;
>>               break;
>> +     case ALPS_PROTO_V6:
>> +             priv->hw_init = alps_hw_init_v6;
>> +             priv->process_packet = alps_process_packet_v6;
>> +             priv->set_abs_params = alps_set_abs_params_st;
>> +             priv->nibble_commands = alps_v6_nibble_commands;
>> +             priv->x_max = 2047;
>> +             priv->y_max = 1535;
>> +             break;
>>       }
>>  }
>>
>> @@ -1705,8 +1905,8 @@ static void alps_disconnect(struct psmouse *psmouse)
>>  static void alps_set_abs_params_st(struct alps_data *priv,
>>                                  struct input_dev *dev1)
>>  {
>> -     input_set_abs_params(dev1, ABS_X, 0, 1023, 0, 0);
>> -     input_set_abs_params(dev1, ABS_Y, 0, 767, 0, 0);
>> +     input_set_abs_params(dev1, ABS_X, 0, priv->x_max, 0, 0);
>> +     input_set_abs_params(dev1, ABS_Y, 0, priv->y_max, 0, 0);
>>  }
>>
>>  static void alps_set_abs_params_mt(struct alps_data *priv,
>> diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
>> index eee5985..704f0f9 100644
>> --- a/drivers/input/mouse/alps.h
>> +++ b/drivers/input/mouse/alps.h
>> @@ -17,6 +17,7 @@
>>  #define ALPS_PROTO_V3        3
>>  #define ALPS_PROTO_V4        4
>>  #define ALPS_PROTO_V5        5
>> +#define ALPS_PROTO_V6        6
>>
>>  /**
>>   * struct alps_model_info - touchpad ID table
>> --
>> 1.8.1.2
>>
>
> --
> Dmitry
