From: Mathias Gottschlag <mgottschlag@gmail.com>
Subject: Re: [PATCH v4] psmouse: Add some support for the FocalTech PS/2 protocol
 extensions.
Date: Tue, 11 Nov 2014 14:35:53 +0100
Message-ID: <546210B9.9080602@gmail.com>
References: <1414834638-16285-1-git-send-email-mgottschlag@gmail.com> <5456B50F.6090700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:52856 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825AbaKKNgA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Nov 2014 08:36:00 -0500
Received: by mail-qc0-f180.google.com with SMTP id o8so7359720qcw.39
        for <linux-input@vger.kernel.org>; Tue, 11 Nov 2014 05:35:59 -0800 (PST)
In-Reply-To: <5456B50F.6090700@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>
Cc: linux-input@vger.kernel.org

The issue seems to be unrelated to the patch, so I'd declare the patch
ready as fas as I can see. Do you need a rebased patch?

Am 02.11.2014 um 23:49 schrieb Mathias Gottschlag:
>
> Apparently this patch breaks the touchpad after suspend/resume on some
> machines - but not on mine. I have no idea how to debug this kind of
> problem, what the source could be, or what debug info could help. Can
> someone maybe lend me a hand here?
>
> The report of the problem has been in the following bug report, at the
> bottom:
> https://bugzilla.redhat.com/show_bug.cgi?id=1110011
>
> Am 01.11.2014 um 10:37 schrieb Mathias Gottschlag:
>> Most of the protocol for these touchpads has been reverse engineered.
This
>> commit adds a basic multitouch-capable driver.
>>
>> A lot of the protocol is still unknown. Especially, we don't know how to
>> identify the device yet apart from the PNP ID.
>>
>> The previous workaround for these devices has been left in place in case
>> the driver is not compiled into the kernel or in case some other device
>> with the same PNP ID is not recognized by the driver yet still has the
> same
>> problems with the device probing code.
>>
>> Signed-off-by: Mathias Gottschlag <mgottschlag@gmail.com>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>
>> Here is v4 of the driver, hopefully without any wrapped lines this
> time. I've
>> received further feedback, the size detection code should be correct
> on Asus
>> X200 and N550 as well.
>>
>>  drivers/input/mouse/Kconfig        |  10 ++
>>  drivers/input/mouse/focaltech.c    | 300
> ++++++++++++++++++++++++++++++++++++-
>>  drivers/input/mouse/focaltech.h    |  60 ++++++++
>>  drivers/input/mouse/psmouse-base.c |  32 ++--
>>  drivers/input/mouse/psmouse.h      |   1 +
>>  5 files changed, 386 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
>> index 366fc7a..db973e5 100644
>> --- a/drivers/input/mouse/Kconfig
>> +++ b/drivers/input/mouse/Kconfig
>> @@ -146,6 +146,16 @@ config MOUSE_PS2_OLPC
>>
>>        If unsure, say N.
>>
>> +config MOUSE_PS2_FOCALTECH
>> +    bool "FocalTech PS/2 mouse protocol extension" if EXPERT
>> +    default y
>> +    depends on MOUSE_PS2
>> +    help
>> +      Say Y here if you have a FocalTech PS/2 TouchPad connected to
>> +      your system.
>> +
>> +      If unsure, say Y.
>> +
>>  config MOUSE_SERIAL
>>      tristate "Serial mouse"
>>      select SERIO
>> diff --git a/drivers/input/mouse/focaltech.c
> b/drivers/input/mouse/focaltech.c
>> index f4d657e..26bc5b7 100644
>> --- a/drivers/input/mouse/focaltech.c
>> +++ b/drivers/input/mouse/focaltech.c
>> @@ -2,6 +2,7 @@
>>   * Focaltech TouchPad PS/2 mouse driver
>>   *
>>   * Copyright (c) 2014 Red Hat Inc.
>> + * Copyright (c) 2014 Mathias Gottschlag <mgottschlag@gmail.com>
>>   *
>>   * This program is free software; you can redistribute it and/or modify
>>   * it under the terms of the GNU General Public License as published by
>> @@ -13,15 +14,14 @@
>>   * Hans de Goede <hdegoede@redhat.com>
>>   */
>>
>> -/*
>> - * The Focaltech PS/2 touchpad protocol is unknown. This drivers
> deals with
>> - * detection only, to avoid further detection attempts confusing the
> touchpad
>> - * this way it at least works in PS/2 mouse compatibility mode.
>> - */
>>
>>  #include <linux/device.h>
>>  #include <linux/libps2.h>
>> +#include <linux/input/mt.h>
>> +#include <linux/serio.h>
>> +#include <linux/slab.h>
>>  #include "psmouse.h"
>> +#include "focaltech.h"
>>
>>  static const char * const focaltech_pnp_ids[] = {
>>      "FLT0101",
>> @@ -30,6 +30,12 @@ static const char * const focaltech_pnp_ids[] = {
>>      NULL
>>  };
>>
>> +/*
>> + * Even if the kernel is built without support for Focaltech PS/2
> touchpads (or
>> + * when the real driver fails to recognize the device), we still have
> to detect
>> + * them in order to avoid further detection attempts confusing the
> touchpad.
>> + * This way it at least works in PS/2 mouse compatibility mode.
>> + */
>>  int focaltech_detect(struct psmouse *psmouse, bool set_properties)
>>  {
>>      if (!psmouse_matches_pnp_id(psmouse, focaltech_pnp_ids))
>> @@ -37,16 +43,296 @@ int focaltech_detect(struct psmouse *psmouse,
> bool set_properties)
>>
>>      if (set_properties) {
>>          psmouse->vendor = "FocalTech";
>> -        psmouse->name = "FocalTech Touchpad in mouse emulation mode";
>> +        psmouse->name = "FocalTech Touchpad";
>>      }
>>
>>      return 0;
>>  }
>>
>> -int focaltech_init(struct psmouse *psmouse)
>> +static void focaltech_reset(struct psmouse *psmouse)
>>  {
>>      ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
>>      psmouse_reset(psmouse);
>> +}
>> +
>> +#ifdef CONFIG_MOUSE_PS2_FOCALTECH
>> +
>> +static void focaltech_report_state(struct psmouse *psmouse)
>> +{
>> +    int i;
>> +    struct focaltech_data *priv = psmouse->private;
>> +    struct focaltech_hw_state *state = &priv->state;
>> +    struct input_dev *dev = psmouse->dev;
>> +    int finger_count = 0;
>> +
>> +    for (i = 0; i < FOC_MAX_FINGERS; i++) {
>> +        struct focaltech_finger_state *finger = &state->fingers[i];
>> +        int active = finger->active && finger->valid;
>> +        input_mt_slot(dev, i);
>> +        input_mt_report_slot_state(dev, MT_TOOL_FINGER, active);
>> +        if (active) {
>> +            finger_count++;
>> +            input_report_abs(dev, ABS_MT_POSITION_X, finger->x);
>> +            input_report_abs(dev, ABS_MT_POSITION_Y,
>> +                    focaltech_invert_y(finger->y));
>> +        }
>> +    }
>> +    input_mt_report_pointer_emulation(dev, finger_count);
>> +
>> +    input_report_key(psmouse->dev, BTN_LEFT, state->pressed);
>> +    input_sync(psmouse->dev);
>> +}
>> +
>> +static void process_touch_packet(struct focaltech_hw_state *state,
>> +        unsigned char *packet)
>> +{
>> +    int i;
>> +    unsigned char fingers = packet[1];
>> +
>> +    state->pressed = (packet[0] >> 4) & 1;
>> +    /* the second byte contains a bitmap of all fingers touching the
> pad */
>> +    for (i = 0; i < FOC_MAX_FINGERS; i++) {
>> +        if ((fingers & 0x1) && !state->fingers[i].active) {
>> +            /* we do not have a valid position for the finger yet */
>> +            state->fingers[i].valid = 0;
>> +        }
>> +        state->fingers[i].active = fingers & 0x1;
>> +        fingers >>= 1;
>> +    }
>> +}
>> +
>> +static void process_abs_packet(struct focaltech_hw_state *state,
>> +        unsigned char *packet)
>> +{
>> +    unsigned int finger = (packet[1] >> 4) - 1;
>> +
>> +    state->pressed = (packet[0] >> 4) & 1;
>> +    if (finger >= FOC_MAX_FINGERS)
>> +        return;
>> +    /*
>> +     * packet[5] contains some kind of tool size in the most significant
>> +     * nibble. 0xff is a special value (latching) that signals a large
>> +     * contact area.
>> +     */
>> +    if (packet[5] == 0xff) {
>> +        state->fingers[finger].valid = 0;
>> +        return;
>> +    }
>> +    state->fingers[finger].x = ((packet[1] & 0xf) << 8) | packet[2];
>> +    state->fingers[finger].y = (packet[3] << 8) | packet[4];
>> +    state->fingers[finger].valid = 1;
>> +}
>> +static void process_rel_packet(struct focaltech_hw_state *state,
>> +        unsigned char *packet)
>> +{
>> +    int finger1 = ((packet[0] >> 4) & 0x7) - 1;
>> +    int finger2 = ((packet[3] >> 4) & 0x7) - 1;
>> +
>> +    state->pressed = packet[0] >> 7;
>> +    if (finger1 < FOC_MAX_FINGERS) {
>> +        state->fingers[finger1].x += (char)packet[1];
>> +        state->fingers[finger1].y += (char)packet[2];
>> +    }
>> +    /*
>> +     * If there is an odd number of fingers, the last relative packet
> only
>> +     * contains one finger. In this case, the second finger index in the
>> +     * packet is 0 (we subtract 1 in the lines above to create array
>> +     * indices).
>> +     */
>> +    if (finger2 != -1 && finger2 < FOC_MAX_FINGERS) {
>> +        state->fingers[finger2].x += (char)packet[4];
>> +        state->fingers[finger2].y += (char)packet[5];
>> +    }
>> +}
>> +
>> +static void focaltech_process_packet(struct psmouse *psmouse)
>> +{
>> +    struct focaltech_data *priv = psmouse->private;
>> +    unsigned char *packet = psmouse->packet;
>> +
>> +    switch (packet[0] & 0xf) {
>> +    case FOC_TOUCH:
>> +        process_touch_packet(&priv->state, packet);
>> +        break;
>> +    case FOC_ABS:
>> +        process_abs_packet(&priv->state, packet);
>> +        break;
>> +    case FOC_REL:
>> +        process_rel_packet(&priv->state, packet);
>> +        break;
>> +    default:
>> +        psmouse_err(psmouse, "Unknown packet type: %02x", packet[0]);
>> +        break;
>> +    }
>> +
>> +    focaltech_report_state(psmouse);
>> +}
>> +
>> +static psmouse_ret_t focaltech_process_byte(struct psmouse *psmouse)
>> +{
>> +    if (psmouse->pktcnt >= 6) { /* Full packet received */
>> +        focaltech_process_packet(psmouse);
>> +        return PSMOUSE_FULL_PACKET;
>> +    }
>> +    /*
>> +     * we might want to do some validation of the data here, but we
> do not
>> +     * know the protocoll well enough
>> +     */
>> +    return PSMOUSE_GOOD_DATA;
>> +}
>> +
>> +static int focaltech_switch_protocol(struct psmouse *psmouse)
>> +{
>> +    struct ps2dev *ps2dev = &psmouse->ps2dev;
>> +    unsigned char param[3];
>> +
>> +    param[0] = 0;
>> +    if (ps2_command(ps2dev, param, 0x10f8))
>> +        return -EIO;
>> +    if (ps2_command(ps2dev, param, 0x10f8))
>> +        return -EIO;
>> +    if (ps2_command(ps2dev, param, 0x10f8))
>> +        return -EIO;
>> +    param[0] = 1;
>> +    if (ps2_command(ps2dev, param, 0x10f8))
>> +        return -EIO;
>> +    if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETSCALE11))
>> +        return -EIO;
>> +
>> +    if (ps2_command(ps2dev, param, PSMOUSE_CMD_ENABLE))
>> +        return -EIO;
>>
>>      return 0;
>>  }
>> +
>> +static void focaltech_disconnect(struct psmouse *psmouse)
>> +{
>> +    focaltech_reset(psmouse);
>> +    kfree(psmouse->private);
>> +    psmouse->private = NULL;
>> +}
>> +
>> +static int focaltech_reconnect(struct psmouse *psmouse)
>> +{
>> +    focaltech_reset(psmouse);
>> +    if (focaltech_switch_protocol(psmouse)) {
>> +        psmouse_err(psmouse,
>> +                "Unable to initialize the device.");
>> +        return -1;
>> +    }
>> +    return 0;
>> +}
>> +
>> +static void set_input_params(struct psmouse *psmouse)
>> +{
>> +    struct input_dev *dev = psmouse->dev;
>> +    struct focaltech_data *priv = psmouse->private;
>> +
>> +    __set_bit(EV_ABS, dev->evbit);
>> +    input_set_abs_params(dev, ABS_MT_POSITION_X, 0, priv->x_max, 0, 0);
>> +    input_set_abs_params(dev, ABS_MT_POSITION_Y, 0, priv->y_max, 0, 0);
>> +    input_mt_init_slots(dev, 5, INPUT_MT_POINTER);
>> +    __clear_bit(EV_REL, dev->evbit);
>> +    __clear_bit(REL_X, dev->relbit);
>> +    __clear_bit(REL_Y, dev->relbit);
>> +    __clear_bit(BTN_RIGHT, dev->keybit);
>> +    __clear_bit(BTN_MIDDLE, dev->keybit);
>> +    __set_bit(INPUT_PROP_BUTTONPAD, dev->propbit);
>> +}
>> +
>> +static int focaltech_read_register(struct ps2dev *ps2dev, int reg,
>> +        unsigned char *param)
>> +{
>> +    if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETSCALE11))
>> +        return -1;
>> +    param[0] = 0;
>> +    if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
>> +        return -1;
>> +    if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
>> +        return -1;
>> +    if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
>> +        return -1;
>> +    param[0] = reg;
>> +    if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
>> +        return -1;
>> +    if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
>> +        return -1;
>> +    return 0;
>> +}
>> +
>> +static int focaltech_read_size(struct psmouse *psmouse)
>> +{
>> +    struct ps2dev *ps2dev = &psmouse->ps2dev;
>> +    struct focaltech_data *priv = psmouse->private;
>> +    char param[3];
>> +
>> +    if (focaltech_read_register(ps2dev, 2, param))
>> +        return -EIO;
>> +    /* not sure whether this is 100% correct */
>> +    priv->x_max = (unsigned char)param[1] * 128;
>> +    priv->y_max = (unsigned char)param[2] * 128;
>> +
>> +    return 0;
>> +}
>> +int focaltech_init(struct psmouse *psmouse)
>> +{
>> +    struct focaltech_data *priv;
>> +    int err;
>> +
>> +    psmouse->private = priv = kzalloc(sizeof(struct focaltech_data),
> GFP_KERNEL);
>> +    if (!priv)
>> +        return -ENOMEM;
>> +
>> +    focaltech_reset(psmouse);
>> +    if (focaltech_read_size(psmouse)) {
>> +        focaltech_reset(psmouse);
>> +        psmouse_err(psmouse,
>> +                "Unable to read the size of the touchpad.");
>> +        err = -ENOSYS;
>> +        goto fail;
>> +    }
>> +    if (focaltech_switch_protocol(psmouse)) {
>> +        focaltech_reset(psmouse);
>> +        psmouse_err(psmouse,
>> +                "Unable to initialize the device.");
>> +        err = -ENOSYS;
>> +        goto fail;
>> +    }
>> +
>> +    set_input_params(psmouse);
>> +
>> +    psmouse->protocol_handler = focaltech_process_byte;
>> +    psmouse->pktsize = 6;
>> +    psmouse->disconnect = focaltech_disconnect;
>> +    psmouse->reconnect = focaltech_reconnect;
>> +    psmouse->cleanup = focaltech_reset;
>> +    /* resync is not supported yet */
>> +    psmouse->resync_time = 0;
>> +
>> +    return 0;
>> +fail:
>> +    focaltech_reset(psmouse);
>> +    kfree(priv);
>> +    return err;
>> +}
>> +
>> +bool focaltech_supported(void)
>> +{
>> +    return true;
>> +}
>> +
>> +#else /* CONFIG_MOUSE_PS2_FOCALTECH */
>> +
>> +int focaltech_init(struct psmouse *psmouse)
>> +{
>> +    focaltech_reset(psmouse);
>> +
>> +    return 0;
>> +}
>> +
>> +bool focaltech_supported(void)
>> +{
>> +    return false;
>> +}
>> +
>> +#endif /* CONFIG_MOUSE_PS2_FOCALTECH */
>> diff --git a/drivers/input/mouse/focaltech.h
> b/drivers/input/mouse/focaltech.h
>> index 498650c..68c5cfc 100644
>> --- a/drivers/input/mouse/focaltech.h
>> +++ b/drivers/input/mouse/focaltech.h
>> @@ -2,6 +2,7 @@
>>   * Focaltech TouchPad PS/2 mouse driver
>>   *
>>   * Copyright (c) 2014 Red Hat Inc.
>> + * Copyright (c) 2014 Mathias Gottschlag <mgottschlag@gmail.com>
>>   *
>>   * This program is free software; you can redistribute it and/or modify
>>   * it under the terms of the GNU General Public License as published by
>> @@ -16,7 +17,66 @@
>>  #ifndef _FOCALTECH_H
>>  #define _FOCALTECH_H
>>
>> +/*
>> + * Packet types - the numbers are not consecutive, so we might be
missing
>> + * something here.
>> + */
>> +#define FOC_TOUCH 0x3 /* bitmap of active fingers */
>> +#define FOC_ABS 0x6 /* absolute position of one finger */
>> +#define FOC_REL 0x9 /* relative position of 1-2 fingers */
>> +
>> +#define FOC_MAX_FINGERS 5
>> +
>> +#define FOC_MAX_X 2431
>> +#define FOC_MAX_Y 1663
>> +
>> +static inline int focaltech_invert_y(int y)
>> +{
>> +    return FOC_MAX_Y - y;
>> +}
>> +
>> +/*
>> + * Current state of a single finger on the touchpad.
>> + */
>> +struct focaltech_finger_state {
>> +    /* the touchpad has generated a touch event for the finger */
>> +    bool active;
>> +    /*
>> +     * The touchpad has sent position data for the finger. Touch event
>> +     * packages reset this flag for new fingers, and there is a time
>> +     * between the first touch event and the following absolute position
>> +     * packet for the finger where the touchpad has declared the
> finger to
>> +     * be valid, but we do not have any valid position yet.
>> +     */
>> +    bool valid;
>> +    /* absolute position (from the bottom left corner) of the finger */
>> +    unsigned int x;
>> +    unsigned int y;
>> +};
>> +
>> +/*
>> + * Description of the current state of the touchpad hardware.
>> + */
>> +struct focaltech_hw_state {
>> +    /*
>> +     * The touchpad tracks the positions of the fingers for us, the
array
>> +     * indices correspond to the finger indices returned in the report
>> +     * packages.
>> +     */
>> +    struct focaltech_finger_state fingers[FOC_MAX_FINGERS];
>> +    /*
>> +     * True if the clickpad has been pressed.
>> +     */
>> +    bool pressed;
>> +};
>> +
>> +struct focaltech_data {
>> +    unsigned int x_max, y_max;
>> +    struct focaltech_hw_state state;
>> +};
>> +
>>  int focaltech_detect(struct psmouse *psmouse, bool set_properties);
>>  int focaltech_init(struct psmouse *psmouse);
>> +bool focaltech_supported(void);
>>
>>  #endif
>> diff --git a/drivers/input/mouse/psmouse-base.c
> b/drivers/input/mouse/psmouse-base.c
>> index 26994f6..4a9de33 100644
>> --- a/drivers/input/mouse/psmouse-base.c
>> +++ b/drivers/input/mouse/psmouse-base.c
>> @@ -725,16 +725,19 @@ static int psmouse_extensions(struct psmouse
> *psmouse,
>>
>>  /* Always check for focaltech, this is safe as it uses pnp-id
matching */
>>      if (psmouse_do_detect(focaltech_detect, psmouse, set_properties)
> == 0) {
>> -        if (!set_properties || focaltech_init(psmouse) == 0) {
>> -            /*
>> -             * Not supported yet, use bare protocol.
>> -             * Note that we need to also restrict
>> -             * psmouse_max_proto so that psmouse_initialize()
>> -             * does not try to reset rate and resolution,
>> -             * because even that upsets the device.
>> -             */
>> -            psmouse_max_proto = PSMOUSE_PS2;
>> -            return PSMOUSE_PS2;
>> +        if (max_proto > PSMOUSE_IMEX) {
>> +            if (!set_properties || focaltech_init(psmouse) == 0) {
>> +                if (focaltech_supported())
>> +                    return PSMOUSE_FOCALTECH;
>> +                /*
>> +                 * Note that we need to also restrict
>> +                 * psmouse_max_proto so that psmouse_initialize()
>> +                 * does not try to reset rate and resolution,
>> +                 * because even that upsets the device.
>> +                 */
>> +                psmouse_max_proto = PSMOUSE_PS2;
>> +                return PSMOUSE_PS2;
>> +            }
>>          }
>>      }
>>
>> @@ -1063,6 +1066,15 @@ static const struct psmouse_protocol
> psmouse_protocols[] = {
>>          .alias        = "cortps",
>>          .detect        = cortron_detect,
>>      },
>> +#ifdef CONFIG_MOUSE_PS2_FOCALTECH
>> +    {
>> +        .type        = PSMOUSE_FOCALTECH,
>> +        .name        = "FocalTechPS/2",
>> +        .alias        = "focaltech",
>> +        .detect        = focaltech_detect,
>> +        .init        = focaltech_init,
>> +    },
>> +#endif
>>      {
>>          .type        = PSMOUSE_AUTO,
>>          .name        = "auto",
>> diff --git a/drivers/input/mouse/psmouse.h
b/drivers/input/mouse/psmouse.h
>> index f4cf664..c2ff137 100644
>> --- a/drivers/input/mouse/psmouse.h
>> +++ b/drivers/input/mouse/psmouse.h
>> @@ -96,6 +96,7 @@ enum psmouse_type {
>>      PSMOUSE_FSP,
>>      PSMOUSE_SYNAPTICS_RELATIVE,
>>      PSMOUSE_CYPRESS,
>> +    PSMOUSE_FOCALTECH,
>>      PSMOUSE_AUTO        /* This one should always be last */
>>  };
>>
>
>
>


