From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] drivers/input/mouse/elantech elantech driver for Lenovo
 L530 trackpoint
Date: Fri, 17 Jan 2014 18:19:11 +0100
Message-ID: <CANq1E4QQf62cvU0XXHRNqRCPqZfHH1PMV_MbKWNiSx-TEaxbOw@mail.gmail.com>
References: <1375220650.66420.YahooMailNeo@web120605.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:37179 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066AbaAQRTM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jan 2014 12:19:12 -0500
Received: by mail-ig0-f177.google.com with SMTP id k19so2135305igc.4
        for <linux-input@vger.kernel.org>; Fri, 17 Jan 2014 09:19:11 -0800 (PST)
In-Reply-To: <1375220650.66420.YahooMailNeo@web120605.mail.ne1.yahoo.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ulrik De Bie <ulrik_opensource-kernel@yahoo.com>, Jonathan Aquilina <eagles051387@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>

Hi

According to Jonathan this patch is still not applied, would anyone
care to resend it as proper git patch so we can review it and
eventually apply it?

Thanks
David

On Tue, Jul 30, 2013 at 11:44 PM, Ulrik De Bie
<ulrik_opensource-kernel@yahoo.com> wrote:
> Hi,
>
> I've a new work laptop Lenovo L530. For 3.2 and 3.9 kernel, the trackpoint
> does not work out of the box. It gives sync errors as shown below when the trackpoint
> or trackpoint mouse buttons are pressed and no input is received by userspace:
> [   29.010641] psmouse serio1: Touchpad at isa0060/serio1/input0 lost sync at byte 6
> The touchpad does work.
>
> The alternative is to do a downgrade to generic ps/2 mouse (modprobe psmouse proto=bare)
> but this has the disadvantage that touchpad can't be disabled (I want trackpoint, not touchpad).
>
> I did some analysis of the psmouse packets generated, and it became apparent that the
> generated packets are according to a very strict format as described in the elantech_report_trackpoint
> function in the patch below.
>
> With this patch, the trackpoint is provided as another input device; currently called 'My stick'
> The trackpoint now succesfully works and I can disable the touchpad with synclient TouchPadOff=1
> The patch will also output messages that do not follow the expected pattern.
> In the mean time I've seen 2 unknown packets occasionally:
> 0x04 , 0x00 , 0x00 , 0x00 , 0x00 , 0x00
> 0x00 , 0x00 , 0x00 , 0x02 , 0x00 , 0x00
> I don't know what those are for, but they can be safely ignored.
>
> Currently all packets that are not known to v3 touchpad and where packet[3] (the fourth byte) lowest
> nibble is 6 are now recognized as PACKET_TRACKPOINT and processed by the new elantech_report_trackpoint.
>
>
> The first feedback I would appreciate on the patch:
> 1a) Do you think that the creation of the extra input device is the correct way to go ? I saw also a synaptics-pt but I was not able to figure it out and the extra input gave me a desirable result fast.
>
> 1b) What would be the requirements for the name and the phys parameter of the device ?
>
>
> 2) Is the patch correct with regards to ps/2 protocol semantics ? Should it be more restrictive; maybe limited to the 4 patterns used to dump unexpected packets ?
>
> 3) Would a 'trackpoint' detection be required ? I have no idea how to do this because I have a lack of elantech version/capabilities samples, I have just the one on my laptop:
> psmouse serio1: elantech: assuming hardware version 3 (with firmware version 0x350f02)
> psmouse serio1: elantech: Synaptics capabilities query result 0xb9, 0x15, 0x0c.
>
> 4) Is there anyone else with different hardware/firmwareversion/synaptics capabilities where this patch also works ?
>
> The patch below was ported to 3.10.4 kernel (originally made for 3.2 kernel which is the default kernel on my laptop)
>
> Thanks for all feedback and your time,
> Ulrik
>
>
>
>
> diff -uprN -X linux-3.10.4-vanilla/Documentation/dontdiff linux-3.10.4-vanilla/drivers/input/mouse/elantech.c linux-3.10.4/drivers/input/mouse/elantech.c
> --- linux-3.10.4-vanilla/drivers/input/mouse/elantech.c    2013-07-29 01:30:49.000000000 +0200
> +++ linux-3.10.4/drivers/input/mouse/elantech.c    2013-07-30 23:06:12.000000000 +0200
> @@ -402,6 +402,54 @@ static void elantech_report_absolute_v2(
>     input_sync(dev);
> }
>
> +static void elantech_report_trackpoint(struct psmouse *psmouse,
> +                       int packet_type)
> +{
> +    /* byte 0:  0   0 ~sx ~sy   0   M   R   L */
> +    /* byte 1: sx   0   0   0   0   0   0   0 */
> +    /* byte 2: sy   0   0   0   0   0   0   0 */
> +    /* byte 3:  0   0  sy  sx   0   1   1   0 */
> +    /* byte 4: x7  x6  x5  x4  x3  x2  x1  x0 */
> +    /* byte 5: y7  y6  y5  y4  y3  y2  y1  y0 */
> +
> +    /*
> +     * x and y are written in two's complement spread
> +     * over 9 bits with sx/sy the relative top bit and
> +     * x7..x0 and y7..y0 the lower bits.
> +     * The sign of y is opposite to what the input driver
> +     * expects for a relative movement
> +     */
> +
> +    struct elantech_data *etd = psmouse->private;
> +    struct input_dev *dev2 = etd->dev2;
> +    unsigned char *packet = psmouse->packet;
> +    int x, y;
> +    input_report_key(dev2, BTN_LEFT, packet[0] & 0x01);
> +    input_report_key(dev2, BTN_RIGHT, packet[0] & 0x02);
> +    input_report_key(dev2, BTN_MIDDLE, packet[0] & 0x04);
> +    x = (s32) ((u32) ((packet[1] & 0x80) ? 0UL : 0xFFFFFF00UL) | (u32)
> +           packet[4]);
> +    y = -(s32) ((u32) ((packet[2] & 0x80) ? 0UL : 0xFFFFFF00UL) | (u32)
> +            packet[5]);
> +    input_report_rel(dev2, REL_X, x);
> +    input_report_rel(dev2, REL_Y, y);
> +    switch ((((u32) packet[0] & 0xF8) << 24) | ((u32) packet[1] << 16)
> +        | (u32) packet[2] << 8 | (u32) packet[3]) {
> +    case 0x00808036UL:
> +    case 0x10008026UL:
> +    case 0x20800016UL:
> +    case 0x30000006UL:
> +        break;
> +    default:
> +        /* Dump unexpected packet sequences if debug=1 (default) */
> +        if (etd->debug == 1)
> +            elantech_packet_dump(psmouse);
> +        break;
> +    }
> +
> +    input_sync(dev2);
> +}
> +
> /*
>   * Interpret complete data packets and report absolute mode input events for
>   * hardware version 3. (12 byte packets for two fingers)
> @@ -688,6 +736,8 @@ static int elantech_packet_check_v3(stru
>     if ((packet[0] & 0x0c) == 0x0c && (packet[3] & 0xce) == 0x0c)
>         return PACKET_V3_TAIL;
>
> +    if ((packet[3]&0x0f) == 0x06)
> +        return PACKET_TRACKPOINT;
>     return PACKET_UNKNOWN;
> }
>
> @@ -752,7 +802,10 @@ static psmouse_ret_t elantech_process_by
>         if (packet_type == PACKET_UNKNOWN)
>             return PSMOUSE_BAD_DATA;
>
> -        elantech_report_absolute_v3(psmouse, packet_type);
> +        if (packet_type == PACKET_TRACKPOINT)
> +            elantech_report_trackpoint(psmouse, packet_type);
> +        else
> +            elantech_report_absolute_v3(psmouse, packet_type);
>         break;
>
>     case 4:
> @@ -1236,8 +1289,10 @@ int elantech_detect(struct psmouse *psmo
>   */
> static void elantech_disconnect(struct psmouse *psmouse)
> {
> +    struct elantech_data *etd = psmouse->private;
>     sysfs_remove_group(&psmouse->ps2dev.serio->dev.kobj,
>                &elantech_attr_group);
> +    input_unregister_device(etd->dev2);
>     kfree(psmouse->private);
>     psmouse->private = NULL;
> }
> @@ -1323,10 +1378,15 @@ int elantech_init(struct psmouse *psmous
>     struct elantech_data *etd;
>     int i, error;
>     unsigned char param[3];
> +    struct input_dev *dev2;
>
>     psmouse->private = etd = kzalloc(sizeof(struct elantech_data), GFP_KERNEL);
>     if (!etd)
>         return -ENOMEM;
> +    dev2 = input_allocate_device();
> +    if (!dev2)
> +        goto init_fail;
> +    etd->dev2 = dev2;
>
>     psmouse_reset(psmouse);
>
> @@ -1386,9 +1446,26 @@ int elantech_init(struct psmouse *psmous
>     psmouse->reconnect = elantech_reconnect;
>     psmouse->pktsize = etd->hw_version > 1 ? 6 : 4;
>
> +    snprintf(etd->phys, sizeof(etd->phys), "%s/input1",
> +        psmouse->ps2dev.serio->phys);
> +    dev2->phys = etd->phys;
> +    dev2->name = "My stick";
> +    dev2->id.bustype = BUS_I8042;
> +    dev2->id.vendor  = 0x0002;
> +    dev2->id.product = PSMOUSE_ELANTECH;
> +    dev2->id.version = 0x0000;
> +    dev2->dev.parent = &psmouse->ps2dev.serio->dev;
> +    dev2->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REL);
> +    dev2->relbit[BIT_WORD(REL_X)] = BIT_MASK(REL_X) | BIT_MASK(REL_Y);
> +    dev2->keybit[BIT_WORD(BTN_LEFT)] =
> +        BIT_MASK(BTN_LEFT) | BIT_MASK(BTN_MIDDLE) | BIT_MASK(BTN_RIGHT);
> +
> +    if (input_register_device(etd->dev2))
> +        goto init_fail;
>     return 0;
>
>   init_fail:
> +    input_free_device(dev2);
>     kfree(etd);
>     return -1;
> }
> diff -uprN -X linux-3.10.4-vanilla/Documentation/dontdiff linux-3.10.4-vanilla/drivers/input/mouse/elantech.h linux-3.10.4/drivers/input/mouse/elantech.h
> --- linux-3.10.4-vanilla/drivers/input/mouse/elantech.h    2013-07-29 01:30:49.000000000 +0200
> +++ linux-3.10.4/drivers/input/mouse/elantech.h    2013-07-30 21:14:09.000000000 +0200
> @@ -94,6 +94,7 @@
> #define PACKET_V4_HEAD            0x05
> #define PACKET_V4_MOTION        0x06
> #define PACKET_V4_STATUS        0x07
> +#define PACKET_TRACKPOINT        0x08
>
> /*
>   * track up to 5 fingers for v4 hardware
> @@ -114,6 +115,8 @@ struct finger_pos {
> };
>
> struct elantech_data {
> +    struct input_dev *dev2;        /* Relative device */
> +    char    phys[32];
>     unsigned char reg_07;
>     unsigned char reg_10;
>     unsigned char reg_11;
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
