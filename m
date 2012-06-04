From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [RFC PATCH] Wiimote joystick reports no axes
Date: Mon, 4 Jun 2012 16:48:57 +0200
Message-ID: <CANq1E4TWf24_U5PdZ7mc2WXEO+wnGgVsU=LC_PcDvBf+0Wg+RQ@mail.gmail.com>
References: <CAOxFTcwsVFpN0KcKSbCjCHJ0=0Q+CcSd0UxanWzue0pv5ZSoXA@mail.gmail.com>
	<1338800098-5643-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:47810 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760690Ab2FDOs7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jun 2012 10:48:59 -0400
Received: by weyu7 with SMTP id u7so2892529wey.19
        for <linux-input@vger.kernel.org>; Mon, 04 Jun 2012 07:48:57 -0700 (PDT)
In-Reply-To: <1338800098-5643-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Giuseppe

On Mon, Jun 4, 2012 at 10:54 AM, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
>> Thank you very much. However, these documents don't explain why a
>> joystick device is created for the Wii Remote and not for the Wii
>> Remote Accelerator.
>
> I've done some more inquiring and discovered that the reason why the
> Remote device is handled as a gamepad by the input subsystem is that =
it
> reports a BTN_A, so I can't see a trivial way to prevent this from
> happening, besides changing the keymap or blacklisting the device at =
the
> joystick driver level.
>
> On the other hand, this also means that just adding a BTN_A to the Ac=
cel
> device is sufficient to have it automatically register for the joydev
> handler. So my idea to add the buttons to the Accel device is enough =
to
> automatically get a proper joystick device from the wiimote.
>
>> IMO the current interface is quite satisfactory. The only thing that=
 I
>> would change is that the Accelerator device should ALSO expose butto=
ns
>> (possibly with a different keymap in that case). I have something in
>> mind to this end, I should be able to give it a test and submit an R=
=46C
>> patch within a couple of days.
>
> I'm attaching to this email a draft patch whose only purpose is to sh=
ow
> how I plan to do things. A proper patched based against the current
> driver in the linux tree will follow if you think the idea has merit.
>
> In words, the idea is to:
>
> * refactor the reporting of keys; this allows the reporting to work o=
n
> =A0any exposed input device, by passing the report_keys function the
> =A0inpurt device and a mapping.
> * use report_keys() in handler_keys()
> * register the keys in the accel device too
> * use report_keys() in handler_accel() too
>
> With these changes, there are now two joystick devices created from t=
he
> wiimote input devices, and due to the order input devices are
> registered, the first one is the one based off the Accelerator input
> device (and it has 3 axes and 7 buttons now), and the other is the on=
e
> based on the Remote device (and which, ideally, we would like the
> joystick handler to skip).

The changes look good to me. They still allow us to disable the
accelerometer on the device, if no-one uses the accelerometer-input so
power-management still works. However, we are now duplicating the
events which I wanted to avoid in the beginning.

I have never used the joydev interface. In fact, I don't even know why
it exists and what it does different compared to evdev. Therefore, I
recommend CC'ing Dmitry or Jiri to let them comment on your ideas. But
I guess they recommend using uinput to get the same result. That is,
creating a fake input device from userspace that collects data from
all the Wii Remote input devices and only sends the requested ones.
This would also allow applications that are _not_ aware of Wii Remotes
to use them. It would also provide much more configurability and
extensibility. There is also a xf86-input-xwiimote XInput2 driver that
can provide the same functionality to programs/games using XInput2.

Anyway, feel free to send this patch to linux-input as proper git
patch and CC Jiri and Dmitry. I have nothing to object here but I also
don't see the reason to support joydev with Wii Remotes.

Regards
David

> --
> Giuseppe "Oblomov" Bilotta
>
> diff --git a/driver/hid-wiimote-core.c b/driver/hid-wiimote-core.c
> index 745667e..f0e9fc9 100644
> --- a/driver/hid-wiimote-core.c
> +++ b/driver/hid-wiimote-core.c
> @@ -686,30 +686,24 @@ static void wiimote_ir_close(struct input_dev *=
dev)
> =A0 =A0 =A0 =A0hid_hw_close(wdata->hdev);
> =A0}
>
> +static void report_keys(struct input_dev *input, const __u16 keymap[=
], const __u8 *payload)
> +{
> + =A0 =A0 =A0 input_report_key(input, keymap[WIIPROTO_KEY_LEFT], !!(p=
ayload[0] & 0x01));
> + =A0 =A0 =A0 input_report_key(input, keymap[WIIPROTO_KEY_RIGHT], !!(=
payload[0] & 0x02));
> + =A0 =A0 =A0 input_report_key(input, keymap[WIIPROTO_KEY_DOWN], !!(p=
ayload[0] & 0x04));
> + =A0 =A0 =A0 input_report_key(input, keymap[WIIPROTO_KEY_UP], !!(pay=
load[0] & 0x08));
> + =A0 =A0 =A0 input_report_key(input, keymap[WIIPROTO_KEY_PLUS], !!(p=
ayload[0] & 0x10));
> + =A0 =A0 =A0 input_report_key(input, keymap[WIIPROTO_KEY_TWO], !!(pa=
yload[1] & 0x01));
> + =A0 =A0 =A0 input_report_key(input, keymap[WIIPROTO_KEY_ONE], !!(pa=
yload[1] & 0x02));
> + =A0 =A0 =A0 input_report_key(input, keymap[WIIPROTO_KEY_B], !!(payl=
oad[1] & 0x04));
> + =A0 =A0 =A0 input_report_key(input, keymap[WIIPROTO_KEY_A], !!(payl=
oad[1] & 0x08));
> + =A0 =A0 =A0 input_report_key(input, keymap[WIIPROTO_KEY_MINUS], !!(=
payload[1] & 0x10));
> + =A0 =A0 =A0 input_report_key(input, keymap[WIIPROTO_KEY_HOME], !!(p=
ayload[1] & 0x80));
> +}
> +
> =A0static void handler_keys(struct wiimote_data *wdata, const __u8 *p=
ayload)
> =A0{
> - =A0 =A0 =A0 input_report_key(wdata->input, wiiproto_keymap[WIIPROTO=
_KEY_LEFT],
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !!(payload[0] & 0x01));
> - =A0 =A0 =A0 input_report_key(wdata->input, wiiproto_keymap[WIIPROTO=
_KEY_RIGHT],
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !!(payload[0] & 0x02));
> - =A0 =A0 =A0 input_report_key(wdata->input, wiiproto_keymap[WIIPROTO=
_KEY_DOWN],
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !!(payload[0] & 0x04));
> - =A0 =A0 =A0 input_report_key(wdata->input, wiiproto_keymap[WIIPROTO=
_KEY_UP],
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !!(payload[0] & 0x08));
> - =A0 =A0 =A0 input_report_key(wdata->input, wiiproto_keymap[WIIPROTO=
_KEY_PLUS],
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !!(payload[0] & 0x10));
> - =A0 =A0 =A0 input_report_key(wdata->input, wiiproto_keymap[WIIPROTO=
_KEY_TWO],
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !!(payload[1] & 0x01));
> - =A0 =A0 =A0 input_report_key(wdata->input, wiiproto_keymap[WIIPROTO=
_KEY_ONE],
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !!(payload[1] & 0x02));
> - =A0 =A0 =A0 input_report_key(wdata->input, wiiproto_keymap[WIIPROTO=
_KEY_B],
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !!(payload[1] & 0x04));
> - =A0 =A0 =A0 input_report_key(wdata->input, wiiproto_keymap[WIIPROTO=
_KEY_A],
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !!(payload[1] & 0x08));
> - =A0 =A0 =A0 input_report_key(wdata->input, wiiproto_keymap[WIIPROTO=
_KEY_MINUS],
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !!(payload[1] & 0x10));
> - =A0 =A0 =A0 input_report_key(wdata->input, wiiproto_keymap[WIIPROTO=
_KEY_HOME],
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !!(payload[1] & 0x80));
> + =A0 =A0 =A0 report_keys(wdata->input, wiiproto_keymap, payload);
> =A0 =A0 =A0 =A0input_sync(wdata->input);
> =A0}
>
> @@ -743,6 +737,7 @@ static void handler_accel(struct wiimote_data *wd=
ata, const __u8 *payload)
> =A0 =A0 =A0 =A0input_report_abs(wdata->accel, ABS_RX, x - 0x200);
> =A0 =A0 =A0 =A0input_report_abs(wdata->accel, ABS_RY, y - 0x200);
> =A0 =A0 =A0 =A0input_report_abs(wdata->accel, ABS_RZ, z - 0x200);
> + =A0 =A0 =A0 report_keys(wdata->accel, wiiproto_keymap, payload);
> =A0 =A0 =A0 =A0input_sync(wdata->accel);
> =A0}
>
> @@ -1104,6 +1099,11 @@ static struct wiimote_data *wiimote_create(str=
uct hid_device *hdev)
> =A0 =A0 =A0 =A0input_set_abs_params(wdata->accel, ABS_RY, -500, 500, =
2, 4);
> =A0 =A0 =A0 =A0input_set_abs_params(wdata->accel, ABS_RZ, -500, 500, =
2, 4);
>
> + =A0 =A0 =A0 set_bit(EV_KEY, wdata->accel->evbit);
> + =A0 =A0 =A0 for (i =3D 0; i < WIIPROTO_KEY_COUNT; ++i)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_bit(wiiproto_keymap[i], wdata->acce=
l->keybit);
> +
> +
> =A0 =A0 =A0 =A0wdata->ir =3D input_allocate_device();
> =A0 =A0 =A0 =A0if (!wdata->ir)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_ir;
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
