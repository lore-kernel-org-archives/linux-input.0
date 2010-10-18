From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH 1/3] Add acer wmi hotkey events support
Date: Mon, 18 Oct 2010 10:47:31 +0200
Message-ID: <AANLkTinDjUarDTEy0fx=kuwSooxr7JNd0EeVcRmpc2gQ@mail.gmail.com>
References: <4CBC6D60020000230002205C@novprvlin0050.provo.novell.com>
	<20101018081218.GA8655@core.coreip.homeip.net>
	<AANLkTimxdxSz3rnbwjEzftwY_3XrUJABB9sCXPSz-J_N@mail.gmail.com>
	<20101018082525.GE8655@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:38668 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826Ab0JRIrd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Oct 2010 04:47:33 -0400
In-Reply-To: <20101018082525.GE8655@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Joey Lee <jlee@novell.com>, Takashi Iwai <tiwai@novell.com>, Thomas Renninger <trenn@novell.com>, mjg59@srcf.ucam.org, carlos@strangeworlds.co.uk, jbenc@suse.cz, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org

On Mon, Oct 18, 2010 at 10:25 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, Oct 18, 2010 at 10:19:37AM +0200, Corentin Chary wrote:
>> On Mon, Oct 18, 2010 at 10:12 AM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > On Sun, Oct 17, 2010 at 10:53:04PM -0600, Joey Lee wrote:
>> >> +static const struct key_entry acer_wmi_keymap[] =3D {
>> >> + =C2=A0 =C2=A0 {KE_KEY, 0x01, {KEY_WLAN} }, =C2=A0 =C2=A0 /* WiF=
i */
>> >> + =C2=A0 =C2=A0 {KE_KEY, 0x12, {KEY_BLUETOOTH} }, =C2=A0 =C2=A0 =C2=
=A0 /* BT */
>> >> + =C2=A0 =C2=A0 {KE_KEY, 0x21, {KEY_PROG1} }, =C2=A0 =C2=A0/* Bac=
kup */
>> >> + =C2=A0 =C2=A0 {KE_KEY, 0x22, {KEY_PROG2} }, =C2=A0 =C2=A0/* Ara=
cade */
>> >> + =C2=A0 =C2=A0 {KE_KEY, 0x23, {KEY_PROG3} }, =C2=A0 =C2=A0/* P_K=
ey */
>> >> + =C2=A0 =C2=A0 {KE_KEY, 0x24, {KEY_PROG4} }, =C2=A0 =C2=A0/* Soc=
ial networking_Key */
>> >> + =C2=A0 =C2=A0 {KE_KEY, 0x64, {KEY_SWITCHVIDEOMODE} }, /* Displa=
y Switch */
>> >> + =C2=A0 =C2=A0 {KE_KEY, 0x82, {KEY_F22} }, =C2=A0 =C2=A0 =C2=A0/=
* Touch Pad On/Off */
>> >
>> > We need to standardize this. Some people use F13/F14, here we have
>> > F22...
>> >
>>
>> The good thing with F* keys, is that they are already mapped in X/Qt=
/SDL/etc..
>>
>> But if we do, we could add KEY_TOUCHPADTOGGLE 0x1b8
>> Then bind it to XF86XK_TouchpadToggle (what's the right way to do th=
at
>> ? keymaps ?)
>>
>
> I wonder who the main consumers of such events will be... X applicati=
ons
> or daemons that listen turn this into some DBUS signal...

I guess xbindkeys and tools like qsynaptics should be able to consume
such events.
HAL also handled some touchpads things, but now that it is deprecated, =
who is in
charge of doing that ?

--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
