From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] psmouse: Add some support for the FocalTech PS/2 protocol extensions.
Date: Mon, 27 Oct 2014 09:44:13 -0400
Message-ID: <CAN+gG=HeQOGAuMphpKbhF22y8aem-NKh73Xwuxup+yn-d4oJ5w@mail.gmail.com>
References: <544B910A.6070304@gmail.com>
	<544E1304.2060006@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:54515 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562AbaJ0NoO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Oct 2014 09:44:14 -0400
Received: by mail-qc0-f176.google.com with SMTP id x3so1212994qcv.21
        for <linux-input@vger.kernel.org>; Mon, 27 Oct 2014 06:44:13 -0700 (PDT)
In-Reply-To: <544E1304.2060006@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Mathias Gottschlag <mgottschlag@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>

Hi Mathias,

In addition to what Hans said, there are dfew thing you need to change
while initializing the device (see inlined comments).

On Mon, Oct 27, 2014 at 5:40 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi Matthias,
>
> On 10/25/2014 02:01 PM, Mathias Gottschlag wrote:
>> Most of the protocol for these touchpads has been reverse engineered. This
>> commit adds a basic multitouch-capable driver.
>>
>> A lot of the protocol is still unknown. Especially, we don't know how to
>> identify the device yet apart from the PNP ID. The code currently compares
>> known good values with all data from the touchpad which could be usable for
>> identification, so by design even minor variations will cause the driver
>> to fail to detect the device and fall back to compatibility mode.
>>
>> The previous workaround for these devices has been left in place in case
>> the driver is not compiled into the kernel or in case some other device
>> with the same PNP ID is not recognized by the driver yet still has the same
>> problems with the device probing code.
>> ---
>>
>> Hi,
>>
>> this patch is related to the following bugs:
>> https://bugzilla.redhat.com/show_bug.cgi?id=1110011
>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1372609
>>
>> It has been tested on the Asus UX303LN, UX303LA and K750L laptops. The
>> latter is affected by bug 1110011 above and used to require additional
>> flags before the touchpad would work. This behaviour should have been
>> fixed by the previous FocalTech patch, but is still present after this
>> patch. I have not yet gotten any feedback yet, but my theory is that the
>> original patch failed to fix the kernel on that device. I have to admit
>> though that I haven't 100% understood that patch.
>>
>> When reviewing, keep in mind that this is my first linux patch. I am
>> using the code for quite some time now without issues, but I might have
>> overlooked quite some problems.
>
> First of all many thanks for working on this.
>
> First one overall comment on the patch, I don't really like the new
> detect function you are adding, and I don't see a need for it, pnp-id
> detection is what windows uses, and it should be 100% reliable (famous last
> words). So I would prefer to stick with with only the pnp-id detection.
>
> I do agree that keeping the pnp-id detection (and falling back to bare) even
> when focaltech support is not compiled in is something which we should do.
>
> Note that likewise specifying psmouse.proto=bare should runtime disable
> your new code if compiled in so the detection blurb in psmouse-base.c should
> look something like this:
>
> /* Always check for focaltech, this is safe as it uses pnp-id matching */
>         if (psmouse_do_detect(focaltech_detect, psmouse, set_properties) == 0) {
>                 if (max_proto > PSMOUSE_IMEX) {
>                         if (!set_properties || focaltech_init(psmouse) == 0) {
>                                 if (focaltech_supported())
>                                         return PSMOUSE_FOCALTECH;
>                                 /*
>                                  * Note that we need to also restrict
>                                  * psmouse_max_proto so that psmouse_initialize()
>                                  * does not try to reset rate and resolution,
>                                  * because even that upsets the device.
>                                  */
>                                 psmouse_max_proto = PSMOUSE_PS2;
>                                 return PSMOUSE_PS2;
>                         }
>                 }
>         }
>
> Where focaltech_supported() is a simple:
>
> #ifdef CONFIG_MOUSE_PS2_FOCALTECH
> bool focaltech_supported(void) {
>         return true;
> }
> #else
> bool focaltech_supported(void) {
>         return false;
> }
> #endif
>
> in focaltech.c (see synaptics.c, which defines synaptics_supported() in the
> same way.
>
>
>
>
>
>>
>> Regards,
>> Mathias
>>
>>  drivers/input/mouse/Kconfig        |  10 ++
>>  drivers/input/mouse/focaltech.c    | 326
>> ++++++++++++++++++++++++++++++++++++-
>>  drivers/input/mouse/focaltech.h    |  61 +++++++
>>  drivers/input/mouse/psmouse-base.c |  15 ++
>>  drivers/input/mouse/psmouse.h      |   1 +
>>  5 files changed, 406 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
>> index 366fc7a..db973e5 100644
>> --- a/drivers/input/mouse/Kconfig
>> +++ b/drivers/input/mouse/Kconfig
>> @@ -146,6 +146,16 @@ config MOUSE_PS2_OLPC
>>         If unsure, say N.
>>  +config MOUSE_PS2_FOCALTECH
>> +     bool "FocalTech PS/2 mouse protocol extension" if EXPERT
>> +     default y
>> +     depends on MOUSE_PS2
>> +     help
>> +       Say Y here if you have a FocalTech PS/2 TouchPad connected to
>> +       your system.
>> +
>> +       If unsure, say Y.
>> +
>>  config MOUSE_SERIAL
>>       tristate "Serial mouse"
>>       select SERIO
>> diff --git a/drivers/input/mouse/focaltech.c
>> b/drivers/input/mouse/focaltech.c
>> index f4d657e..ada97cc 100644
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
>>  -/*
>> - * The Focaltech PS/2 touchpad protocol is unknown. This drivers deals with
>> - * detection only, to avoid further detection attempts confusing the
>> touchpad
>> - * this way it at least works in PS/2 mouse compatibility mode.
>> - */
>>   #include <linux/device.h>
>>  #include <linux/libps2.h>
>> +#include <linux/input/mt.h>
>> +#include <linux/serio.h>
>> +#include <linux/slab.h>
>>  #include "psmouse.h"
>> +#include "focaltech.h"
>>   static const char * const focaltech_pnp_ids[] = {
>>       "FLT0101",
>> @@ -30,7 +30,14 @@ static const char * const focaltech_pnp_ids[] = {
>>       NULL
>>  };
>>  -int focaltech_detect(struct psmouse *psmouse, bool set_properties)
>> +/*
>> + * Even if the kernel is built without support for Focaltech PS/2
>> touchpads (or
>> + * when the real driver fails to recognize the device), we still have
>> to detect
>> + * them in order to avoid further detection attempts confusing the
>> touchpad.
>> + * This way it at least works in PS/2 mouse compatibility mode.
>> + */
>> +
>> +int focaltech_detect_fallback(struct psmouse *psmouse, bool set_properties)
>>  {
>>       if (!psmouse_matches_pnp_id(psmouse, focaltech_pnp_ids))
>>               return -ENODEV;
>> @@ -43,10 +50,315 @@ int focaltech_detect(struct psmouse *psmouse, bool
>> set_properties)
>>       return 0;
>>  }
>>  -int focaltech_init(struct psmouse *psmouse)
>> +int focaltech_init_fallback(struct psmouse *psmouse)
>> +{
>> +     ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
>> +     psmouse_reset(psmouse);
>> +
>> +     return 0;
>> +}
>> +
>
> As discussed please keep this named focaltech_init, and make this version
> #ifndef CONFIG_MOUSE_PS2_FOCALTECH (or put it in the #else block.
>
> Also you may want to make this use the newly defined focaltech_reset()
> function (which would then be outside of #ifdef CONFIG_MOUSE_PS2_FOCALTECH)
>
>> +#ifdef CONFIG_MOUSE_PS2_FOCALTECH
>> +
>> +static int focaltech_read_register(struct ps2dev *ps2dev, int reg,
>> +             unsigned char *param)
>> +{
>> +     if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETSCALE11))
>> +             return -1;
>> +     param[0] = 0;
>> +     if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
>> +             return -1;
>> +     if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
>> +             return -1;
>> +     if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
>> +             return -1;
>> +     param[0] = reg;
>> +     if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
>> +             return -1;
>> +     if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
>> +             return -1;
>> +     return 0;
>> +}
>> +
>
> If you drop the register contents check, you can drop this as well,
> may be useful for future reference though, so may make it #if 0 ... #endif.
> Dmitry ?
>
>
>> +int focaltech_detect(struct psmouse *psmouse, bool set_properties)
>> +{
>> +     struct ps2dev *ps2dev = &psmouse->ps2dev;
>> +     unsigned char param[3];
>> +
>> +     if (!psmouse_matches_pnp_id(psmouse, focaltech_pnp_ids))
>> +             return -ENODEV;
>> +
>> +     /*
>> +      * We don't know how to identify the device, so we just check the
>> +      * content of all registers.
>> +      */
>> +     if (focaltech_read_register(ps2dev, 0, param))
>> +             return -EIO;
>> +     if (param[0] != 0x69 || param[1] != 0x80 || param[2] != 0x80)
>> +             return -ENODEV;
>> +     if (focaltech_read_register(ps2dev, 1, param))
>> +             return -EIO;
>> +     if (param[0] != 0x36 || param[1] != 0x53 || param[2] != 0x03)
>> +             return -ENODEV;
>> +     if (focaltech_read_register(ps2dev, 2, param))
>> +             return -EIO;
>> +     /* 0x13 and 0x0d might be the touchpad size? */
>> +     if (param[0] != 0x00 || param[1] != 0x13 || param[2] != 0x0d)
>> +             return -ENODEV;
>> +     if (focaltech_read_register(ps2dev, 5, param))
>> +             return -EIO;
>> +     if (param[0] != 0x0b || param[1] != 0x03 || param[2] != 0x00)
>> +             return -ENODEV;
>> +     if (focaltech_read_register(ps2dev, 6, param))
>> +             return -EIO;
>> +     if (param[0] != 0x23 || param[1] != 0xbd || param[2] != 0xf8)
>> +             return -ENODEV;
>> +
>> +     if (set_properties) {
>> +             psmouse->vendor = "FocalTech";
>> +             psmouse->name = "FocalTech Touchpad";
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static void focaltech_report_state(struct psmouse *psmouse)
>> +{
>> +     int i;
>> +     struct focaltech_data *priv = psmouse->private;
>> +     struct focaltech_hw_state *state = &priv->state;
>> +     struct input_dev *dev = psmouse->dev;
>> +     int finger_count = 0;
>> +
>> +     for (i = 0; i < FOC_MAX_FINGERS; i++) {
>> +             struct focaltech_finger_state *finger = &state->fingers[i];
>> +             int active = finger->active && finger->valid;
>> +             input_mt_slot(dev, i);
>> +             input_mt_report_slot_state(dev, MT_TOOL_FINGER, active);
>> +             if (active) {
>> +                     finger_count++;
>> +                     input_report_abs(dev, ABS_MT_POSITION_X, finger->x);
>> +                     input_report_abs(dev, ABS_MT_POSITION_Y,
>> +                                     focaltech_invert_y(finger->y));
>> +             }
>> +     }
>> +     input_mt_report_pointer_emulation(dev, false);
>> +     input_mt_report_finger_count(dev, finger_count);
>
> These 2 lines should be replace with:
>         input_mt_report_pointer_emulation(dev, finger_count);
>
> So that BTN_TOUCH properly gets set when at least one finger is down (this is
> mandatory when not reporting pressure).
>
> Also I see that you are not using input_mt_assign_slots, so I take it that
> if put 2 fingers down and then lift the first finger down, the second finger
> stays in slot->fingers[1] ? Because if it does not then you need to use
> input_mt_assign_slots.
>
>> +
>> +     input_report_key(psmouse->dev, BTN_LEFT, state->pressed);
>> +     input_sync(psmouse->dev);
>> +}
>> +
>> +static void process_touch_packet(struct focaltech_hw_state *state,
>> +             unsigned char *packet)
>> +{
>> +     int i;
>> +     unsigned char fingers = packet[1];
>> +
>> +     state->pressed = (packet[0] >> 4) & 1;
>> +     /* the second byte contains a bitmap of all fingers touching the pad */
>> +     for (i = 0; i < FOC_MAX_FINGERS; i++) {
>> +             if ((fingers & 0x1) && !state->fingers[i].active) {
>> +                     /* we do not have a valid position for the finger yet */
>> +                     state->fingers[i].valid = 0;
>> +             }
>> +             state->fingers[i].active = fingers & 0x1;
>> +             fingers >>= 1;
>> +     }
>> +}
>> +
>> +static void process_abs_packet(struct focaltech_hw_state *state,
>> +             unsigned char *packet)
>> +{
>> +     unsigned int finger = (packet[1] >> 4) - 1;
>> +
>> +     state->pressed = (packet[0] >> 4) & 1;
>> +     if (finger >= FOC_MAX_FINGERS)
>> +             return;
>> +     /*
>> +      * packet[5] contains some kind of tool size in the most significant
>> +      * nibble. 0xff is a special value (latching) that signals a large
>> +      * contact area.
>> +      */
>> +     if (packet[5] == 0xff)
>> +             return;
>
> Maybe set state->fingers[finger].valid = 0 here ?
>
>> +     state->fingers[finger].x = ((packet[1] & 0xf) << 8) | packet[2];
>> +     state->fingers[finger].y = (packet[3] << 8) | packet[4];
>> +     state->fingers[finger].valid = 1;
>> +}
>> +static void process_rel_packet(struct focaltech_hw_state *state,
>> +             unsigned char *packet)
>> +{
>> +     int finger1 = ((packet[0] >> 4) & 0x7) - 1;
>> +     int finger2 = ((packet[3] >> 4) & 0x7) - 1;
>> +
>> +     state->pressed = packet[0] >> 7;
>> +     if (finger1 < FOC_MAX_FINGERS) {
>> +             state->fingers[finger1].x += (char)packet[1];
>> +             state->fingers[finger1].y += (char)packet[2];
>> +     }
>> +     /*
>> +      * If there is an odd number of fingers, the last relative packet only
>> +      * contains one finger. In this case, the second finger index in the
>> +      * packet is 0 (we subtract 1 in the lines above to create array
>> +      * indices).
>> +      */
>> +     if (finger2 != -1 && finger2 < FOC_MAX_FINGERS) {
>> +             state->fingers[finger2].x += (char)packet[4];
>> +             state->fingers[finger2].y += (char)packet[5];
>> +     }
>> +}
>> +
>> +static void focaltech_process_packet(struct psmouse *psmouse)
>> +{
>> +     struct focaltech_data *priv = psmouse->private;
>> +     unsigned char *packet = psmouse->packet;
>> +
>> +     switch (packet[0] & 0xf) {
>> +     case FOC_TOUCH:
>> +             process_touch_packet(&priv->state, packet);
>> +             break;
>> +     case FOC_ABS:
>> +             process_abs_packet(&priv->state, packet);
>> +             break;
>> +     case FOC_REL:
>> +             process_rel_packet(&priv->state, packet);
>> +             break;
>> +     default:
>> +             psmouse_err(psmouse, "Unknown packet type: %02x", packet[0]);
>> +             break;
>> +     }
>> +
>> +     focaltech_report_state(psmouse);
>> +}
>> +
>> +static psmouse_ret_t focaltech_process_byte(struct psmouse *psmouse)
>>  {
>> +     if (psmouse->pktcnt >= 6) { /* Full packet received */
>> +             focaltech_process_packet(psmouse);
>> +             return PSMOUSE_FULL_PACKET;
>> +     }
>> +     /*
>> +      * we might want to do some validation of the data here, but we do not
>> +      * know the protocoll well enough
>> +      */
>> +     return PSMOUSE_GOOD_DATA;
>> +}
>> +
>> +static void focaltech_reset(struct psmouse *psmouse)
>> +{
>> +     psmouse_info(psmouse, "focaltech_reset");
>>       ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
>>       psmouse_reset(psmouse);
>> +}
>> +
>> +static int focaltech_switch_protocol(struct psmouse *psmouse)
>> +{
>> +     struct ps2dev *ps2dev = &psmouse->ps2dev;
>> +     unsigned char param[3];
>> +
>> +     param[0] = 0;
>> +     if (ps2_command(ps2dev, param, 0x10f8))
>> +             return -EIO;
>> +     if (ps2_command(ps2dev, param, 0x10f8))
>> +             return -EIO;
>> +     if (ps2_command(ps2dev, param, 0x10f8))
>> +             return -EIO;
>> +     param[0] = 1;
>> +     if (ps2_command(ps2dev, param, 0x10f8))
>> +             return -EIO;
>> +     if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETSCALE11))
>> +             return -EIO;
>> +
>> +     if (ps2_command(ps2dev, param, PSMOUSE_CMD_ENABLE))
>> +             return -EIO;
>>       return 0;
>>  }
>> +
>> +static void focaltech_disconnect(struct psmouse *psmouse)
>> +{
>> +     focaltech_reset(psmouse);
>> +     kfree(psmouse->private);
>> +     psmouse->private = NULL;
>> +}
>> +
>> +static int focaltech_reconnect(struct psmouse *psmouse)
>> +{
>> +     focaltech_reset(psmouse);
>> +     if (focaltech_switch_protocol(psmouse)) {
>> +             psmouse_err(psmouse,
>> +                         "Unable to initialize the device.");
>> +             return -1;
>> +     }
>> +     return 0;
>> +}
>> +
>> +static void set_input_params(struct psmouse *psmouse)
>> +{
>> +     struct input_dev *dev = psmouse->dev;
>> +
>> +     __set_bit(EV_KEY, dev->evbit);
>> +     __set_bit(EV_ABS, dev->evbit);
>> +     input_set_abs_params(dev, ABS_X, 0, FOC_MAX_X, 0, 0);
>> +     input_set_abs_params(dev, ABS_Y, 0, FOC_MAX_Y, 0, 0);
>> +     input_mt_init_slots(dev, 5, INPUT_MT_POINTER);
>> +     input_set_abs_params(dev, ABS_MT_POSITION_X, 0, FOC_MAX_X, 0, 0);
>> +     input_set_abs_params(dev, ABS_MT_POSITION_Y, 0, FOC_MAX_Y, 0, 0);
>> +     __set_bit(BTN_TOUCH, dev->keybit);
>> +     __set_bit(BTN_TOOL_FINGER, dev->keybit);
>> +     __set_bit(BTN_TOOL_DOUBLETAP, dev->keybit);
>> +     __set_bit(BTN_TOOL_TRIPLETAP, dev->keybit);
>> +     __set_bit(BTN_TOOL_QUADTAP, dev->keybit);
>> +     __set_bit(BTN_TOOL_QUINTTAP, dev->keybit);
>> +     __clear_bit(EV_REL, dev->evbit);
>> +     __clear_bit(REL_X, dev->relbit);
>> +     __clear_bit(REL_Y, dev->relbit);
>> +     __set_bit(BTN_LEFT, dev->keybit);
>> +     __clear_bit(BTN_RIGHT, dev->keybit);
>> +     __clear_bit(BTN_MIDDLE, dev->keybit);
>> +     __set_bit(INPUT_PROP_BUTTONPAD, dev->propbit);

Basically, there are too much things here :)

You need to initialize:
- __set_bit(EV_ABS, dev->evbit); (it looks like nobody else will set it for us)
- ABS_MT_POSITION_X and ABS_MT_POSITION_Y first
- then call input_mt_init_slots(dev, 5, INPUT_MT_POINTER); (if you
need to use int_me_assign_slot as said by Hans, you need to also add
INPUT_MT_TRACK in the flags).
- clear the various unrequired bits
- set INPUT_PROP_BUTTONPAD

The BTN_TOUCH, BTN_TOOL_***, ABS_X/Y, EV_KEY bits are all set by
input_mt_init_slot() if you call it after having set the
ABS_MT_POSITION_X/Y

Cheers,
Benjamin

>> +}
>> +
>> +int focaltech_init(struct psmouse *psmouse)
>> +{
>> +     struct focaltech_data *priv;
>> +
>> +     focaltech_reset(psmouse);
>> +     if (focaltech_switch_protocol(psmouse)) {
>> +             focaltech_reset(psmouse);
>> +             psmouse_info(psmouse,
>> +                          "Unable to initialize the device.");
>> +             return -ENOSYS;
>> +     }
>> +
>> +     psmouse->private = priv = kzalloc(sizeof(struct focaltech_data),
>> GFP_KERNEL);
>> +     if (!priv)
>> +             return -ENOMEM;
>> +
>> +     set_input_params(psmouse);
>> +
>> +     psmouse->protocol_handler = focaltech_process_byte;
>> +     psmouse->pktsize = 6;
>> +     psmouse->disconnect = focaltech_disconnect;
>> +     psmouse->reconnect = focaltech_reconnect;
>> +     psmouse->cleanup = focaltech_reset;
>> +     /* resync is not supported yet */
>> +     psmouse->resync_time = 0;
>> +
>> +     return 0;
>> +}
>> +
>> +#else /* CONFIG_MOUSE_PS2_FOCALTECH */
>> +
>> +int focaltech_detect(struct psmouse *psmouse, bool set_properties)
>> +{
>> +     return -ENOSYS;
>> +}
>> +
>> +int focaltech_init(struct psmouse *psmouse)
>> +{
>> +     return -ENOSYS;
>> +}
>> +
>> +#endif /* CONFIG_MOUSE_PS2_FOCALTECH */
>> diff --git a/drivers/input/mouse/focaltech.h
>> b/drivers/input/mouse/focaltech.h
>> index 498650c..3c553b2 100644
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
>> @@ -16,7 +17,67 @@
>>  #ifndef _FOCALTECH_H
>>  #define _FOCALTECH_H
>>  +/*
>> + * Packet types - the numbers are not consecutive, so we might be missing
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
>> +     return FOC_MAX_Y - y;
>> +}
>> +
>> +/*
>> + * Current state of a single finger on the touchpad.
>> + */
>> +struct focaltech_finger_state {
>> +     /* the touchpad has generated a touch event for the finger */
>> +     bool active;
>> +     /*
>> +      * The touchpad has sent position data for the finger. Touch event
>> +      * packages reset this flag for new fingers, and there is a time
>> +      * between the first touch event and the following absolute position
>> +      * packet for the finger where the touchpad has declared the finger to
>> +      * be valid, but we do not have any valid position yet.
>> +      */
>> +     bool valid;
>> +     /* absolute position (from the bottom left corner) of the finger */
>> +     unsigned int x;
>> +     unsigned int y;
>> +};
>> +
>> +/*
>> + * Description of the current state of the touchpad hardware.
>> + */
>> +struct focaltech_hw_state {
>> +     /*
>> +      * The touchpad tracks the positions of the fingers for us, the array
>> +      * indices correspond to the finger indices returned in the report
>> +      * packages.
>> +      */
>> +     struct focaltech_finger_state fingers[FOC_MAX_FINGERS];
>> +     /*
>> +      * True if the clickpad has been pressed.
>> +      */
>> +     bool pressed;
>> +};
>> +
>> +struct focaltech_data {
>> +     struct focaltech_hw_state state;
>> +};
>> +
>>  int focaltech_detect(struct psmouse *psmouse, bool set_properties);
>>  int focaltech_init(struct psmouse *psmouse);
>>  +int focaltech_detect_fallback(struct psmouse *psmouse, bool
>> set_properties);
>> +int focaltech_init_fallback(struct psmouse *psmouse);
>> +
>>  #endif
>> diff --git a/drivers/input/mouse/psmouse-base.c
>> b/drivers/input/mouse/psmouse-base.c
>> index 26994f6..2e2b98d 100644
>> --- a/drivers/input/mouse/psmouse-base.c
>> +++ b/drivers/input/mouse/psmouse-base.c
>> @@ -726,6 +726,12 @@ static int psmouse_extensions(struct psmouse *psmouse,
>>  /* Always check for focaltech, this is safe as it uses pnp-id matching */
>>       if (psmouse_do_detect(focaltech_detect, psmouse, set_properties) == 0) {
>>               if (!set_properties || focaltech_init(psmouse) == 0) {
>> +                     return PSMOUSE_FOCALTECH;
>> +             }
>> +     }
>> +     if (psmouse_do_detect(focaltech_detect_fallback,
>> +                           psmouse, set_properties) == 0) {
>> +             if (!set_properties || focaltech_init_fallback(psmouse) == 0) {
>>                       /*
>>                        * Not supported yet, use bare protocol.
>>                        * Note that we need to also restrict
>> @@ -1063,6 +1069,15 @@ static const struct psmouse_protocol
>> psmouse_protocols[] = {
>>               .alias          = "cortps",
>>               .detect         = cortron_detect,
>>       },
>> +#ifdef CONFIG_MOUSE_PS2_FOCALTECH
>> +     {
>> +             .type           = PSMOUSE_FOCALTECH,
>> +             .name           = "FocalTechPS/2",
>> +             .alias          = "focaltech",
>> +             .detect         = focaltech_detect,
>> +             .init           = focaltech_init,
>> +     },
>> +#endif
>>       {
>>               .type           = PSMOUSE_AUTO,
>>               .name           = "auto",
>> diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
>> index f4cf664..c2ff137 100644
>> --- a/drivers/input/mouse/psmouse.h
>> +++ b/drivers/input/mouse/psmouse.h
>> @@ -96,6 +96,7 @@ enum psmouse_type {
>>       PSMOUSE_FSP,
>>       PSMOUSE_SYNAPTICS_RELATIVE,
>>       PSMOUSE_CYPRESS,
>> +     PSMOUSE_FOCALTECH,
>>       PSMOUSE_AUTO            /* This one should always be last */
>>  };
>
> Overall this looks very good, many thanks for your work on this!
>
> Regards,
>
> Hans
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
