From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: Re: matrix_keyboard based driver
Date: Tue, 22 Nov 2011 13:52:44 +0100
Message-ID: <CAH9NwWf1GhyOW-VWatT6j6ucAJPcE+ODajxCukTgqz_p-XnidA@mail.gmail.com>
References: <CAH9NwWd+40pC=UQFZnQcXoYp7J_Ui=cfcGh0WLaXV6niOjfF4g@mail.gmail.com>
 <20111121172715.GA2362@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42401 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754858Ab1KVMxF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Nov 2011 07:53:05 -0500
Received: by ywt32 with SMTP id 32so116959ywt.19
        for <linux-input@vger.kernel.org>; Tue, 22 Nov 2011 04:53:05 -0800 (PST)
In-Reply-To: <20111121172715.GA2362@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry,

2011/11/21 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> Hi CHristian,
>
> On Mon, Nov 21, 2011 at 02:52:17PM +0100, Christian Gmeiner wrote:
>> Hi all,
>>
>> today I started with a basic matrix_keyboard based keypad driver. It
>> seems to work quite
>> well but I have some questions.
>>
>> Is it possible to define following values from user space?
>>
>> * debounce time in [ms]
>
> No as it is mostly hardware property, not user preference.

Okay... lets see If i need to do this in hardware.

>
>> * auto repeat time in [ms]
>
> Yes: EVIOCSREP (kbdrate or similar). Note that X ignores kernel
> autorepeat and implements its own.

=46ine.

>
>> * multi click abort time in [ms]
>
> I have no idea what that is, so apparently no ;)

At the moment I have a uinput based user space program,
which gets the matrix coordinates and send back the pressed
key. And there it is possible to enter a handy-like input method.

press 3 times in a short time the letter 1 on the keypad and the
uinput based program sends a 'c' to the kernel.


>
>>
>> I am also not sure about the default keymap I should use in the
>> platform_data. At
>> the moment it looks like:
>>
>> static const uint32_t ot200_keymap[] =3D {
>> =C2=A0 =C2=A0 =C2=A0 KEY(0, 1, 0x01),
>> =C2=A0 =C2=A0 =C2=A0 KEY(0, 2, 0x02),
>> =C2=A0 =C2=A0 =C2=A0 KEY(0, 3, 0x03),
>> =C2=A0 =C2=A0 =C2=A0 KEY(0, 4, 0x04),
>> =C2=A0 =C2=A0 =C2=A0 KEY(0, 5, 0x05),
>> =C2=A0 =C2=A0 =C2=A0 KEY(0, 6, 0x06),
>> =C2=A0 =C2=A0 =C2=A0 KEY(0, 7, 0x07),
>> =C2=A0 =C2=A0 =C2=A0 KEY(0, 8, 0x08),
>> =C2=A0 =C2=A0 =C2=A0 KEY(0, 9, 0x09),
>> ...
>> ...
>> =C2=A0 =C2=A0 =C2=A0 KEY(9, 6, 0x96),
>> =C2=A0 =C2=A0 =C2=A0 KEY(9, 7, 0x97),
>> =C2=A0 =C2=A0 =C2=A0 KEY(9, 8, 0x98),
>> =C2=A0 =C2=A0 =C2=A0 KEY(9, 9, 0x99),
>
> The last items in triplets should be KEY_* constant defined in
> include/linux/input.h
>

Okay.. this should be doable... my company offers a way to have their
own mapping of some universal keys on the keypad. for instance it is
possible to assign to a key the action to sending ALT + TAB.

>> };
>>
>> I need to configure the mapping from userspace and it is be done via=
 loadkeys
>> if I am not wrong.
>
> To adjust mapping of the input device itself one should use 'setkeyco=
de'
> or some other utility issuing EVIOCGKEYCODE/EVIOCSKEYCODE ioctls.
>

So these two ioctls are changing the last value in the triplets of the =
keymap?

>> static const uint32_t ot200_keymap[] =3D {
>>       KEY(0, 1, 0x01),

In this case 0x01 will get replaced?

> loadkeys adjusts higher level keymap used by the console.
>

ah okay.

>> Does the input core handle cases like SHIFT key and
>> CAPS lock?
>
> No, that is the task for higher layers (console, X, etc...).
>

Need to play a little bit with I think.

thanks
--
Christian Gmeiner, MSc
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
