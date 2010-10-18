From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH 1/3] Add acer wmi hotkey events support
Date: Mon, 18 Oct 2010 10:19:37 +0200
Message-ID: <AANLkTimxdxSz3rnbwjEzftwY_3XrUJABB9sCXPSz-J_N@mail.gmail.com>
References: <4CBC6D60020000230002205C@novprvlin0050.provo.novell.com>
	<20101018081218.GA8655@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20101018081218.GA8655@core.coreip.homeip.net>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Joey Lee <jlee@novell.com>, Takashi Iwai <tiwai@novell.com>, Thomas Renninger <trenn@novell.com>, mjg59@srcf.ucam.org, carlos@strangeworlds.co.uk, jbenc@suse.cz, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Oct 18, 2010 at 10:12 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Sun, Oct 17, 2010 at 10:53:04PM -0600, Joey Lee wrote:
>> Hi Dmitry,
>>
>> =E6=96=BC =E4=B8=89=EF=BC=8C2010-10-13 =E6=96=BC 11:24 -0700=EF=BC=8C=
Dmitry Torokhov =E6=8F=90=E5=88=B0=EF=BC=9A
>> > Hi Joey,
>> >
>> > On Wed, Oct 13, 2010 at 11:47:40AM +0800, Lee, Chun-Yi wrote:
>> > =C2=A0+
>> > > + status =3D wmi_install_notify_handler(ACERWMID_EVENT_GUID,
>> > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 acer_wmi_notify, NULL);
>> > > + if (ACPI_FAILURE(status)) {
>> > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -EIO;
>> > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_unregister_input;
>> > > + }
>> > > +
>> > > + return 0;
>> > > +
>> > > +err_unregister_input:
>> > > + input_unregister_device(acer_wmi_input_dev);
>> > > +err_free_keymap:
>> > > + sparse_keymap_free(acer_wmi_input_dev);
>> > > +err_free_dev:
>> > > + input_free_device(acer_wmi_input_dev);
>> >
>> > If wmi_install_notify_handler() fails you'll end up doing
>> > input_unregister_device() + input_free_device() which is forbidden=
=2E To
>> > avoid this issue register the device after installing the handler.=
 As
>> > long as input device is properly allocated (by calling
>> > input_allocate_device) it is safe to use it to send events (althou=
gh
>> > they will not go anywhere).
>> >
>> > BTW, I think it is high time we allocate a dedicated key for touch=
pad
>> > on/off....
>> >
>>
>> Thank's for your review.
>> I changed the error handler priority:
>>
>> >From 9e31867c348a1f2119d16ddbcf9cf0b7de111cf9 Mon Sep 17 00:00:00 2=
001
>> From: Lee, Chun-Yi <jlee@novell.com>
>> Date: Mon, 18 Oct 2010 12:12:49 +0800
>> Subject: [PATCH 1/3] Add acer wmi hotkey events support
>>
>> Add acer wmi hotkey event support. Install a wmi notify handler to
>> transfer wmi event key to key code, then send out keycode through ac=
er
>> wmi input device to userland.
>>
>> Signed-off-by: Lee, Chun-Yi <jlee@novell.com>
>
> Looks good to me, thank you for making changes.
>
>>
>> @@ -48,6 +50,7 @@ MODULE_LICENSE("GPL");
>> =C2=A0#define ACER_ERR KERN_ERR ACER_LOGPREFIX
>> =C2=A0#define ACER_NOTICE KERN_NOTICE ACER_LOGPREFIX
>> =C2=A0#define ACER_INFO KERN_INFO ACER_LOGPREFIX
>> +#define ACER_WARNING KERN_WARNING ACER_LOGPREFIX
>>
>
> As a separate change could you please move the driver to using pr_err=
()
> and friends?
>
>> =C2=A0/*
>> =C2=A0 * Magic Number
>> @@ -83,8 +86,39 @@ MODULE_LICENSE("GPL");
>> =C2=A0#define WMID_GUID1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "6AF4F25=
8-B401-42fd-BE91-3D4AC2D7C0D3"
>> =C2=A0#define WMID_GUID2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "95764E0=
9-FB56-4e83-B31A-37761F60994A"
>>
>> +/*
>> + * Acer ACPI event GUIDs
>> + */
>> +#define ACERWMID_EVENT_GUID "676AA15E-6A47-4D9F-A2CC-1E6D18D14026"
>> +
>> =C2=A0MODULE_ALIAS("wmi:67C3371D-95A3-4C37-BB61-DD47B491DAAB");
>> =C2=A0MODULE_ALIAS("wmi:6AF4F258-B401-42fd-BE91-3D4AC2D7C0D3");
>> +MODULE_ALIAS("wmi:676AA15E-6A47-4D9F-A2CC-1E6D18D14026");
>> +
>> +enum acer_wmi_event_ids {
>> + =C2=A0 =C2=A0 WMID_HOTKEY_EVENT =3D 0x1,
>> +};
>> +
>> +static const struct key_entry acer_wmi_keymap[] =3D {
>> + =C2=A0 =C2=A0 {KE_KEY, 0x01, {KEY_WLAN} }, =C2=A0 =C2=A0 /* WiFi *=
/
>> + =C2=A0 =C2=A0 {KE_KEY, 0x12, {KEY_BLUETOOTH} }, =C2=A0 =C2=A0 =C2=A0=
 /* BT */
>> + =C2=A0 =C2=A0 {KE_KEY, 0x21, {KEY_PROG1} }, =C2=A0 =C2=A0/* Backup=
 */
>> + =C2=A0 =C2=A0 {KE_KEY, 0x22, {KEY_PROG2} }, =C2=A0 =C2=A0/* Aracad=
e */
>> + =C2=A0 =C2=A0 {KE_KEY, 0x23, {KEY_PROG3} }, =C2=A0 =C2=A0/* P_Key =
*/
>> + =C2=A0 =C2=A0 {KE_KEY, 0x24, {KEY_PROG4} }, =C2=A0 =C2=A0/* Social=
 networking_Key */
>> + =C2=A0 =C2=A0 {KE_KEY, 0x64, {KEY_SWITCHVIDEOMODE} }, /* Display S=
witch */
>> + =C2=A0 =C2=A0 {KE_KEY, 0x82, {KEY_F22} }, =C2=A0 =C2=A0 =C2=A0/* T=
ouch Pad On/Off */
>
> We need to standardize this. Some people use F13/F14, here we have
> F22...
>

The good thing with F* keys, is that they are already mapped in X/Qt/SD=
L/etc..

But if we do, we could add KEY_TOUCHPADTOGGLE 0x1b8
Then bind it to XF86XK_TouchpadToggle (what's the right way to do that
? keymaps ?)

--=20
Corentin Chary
http://xf.iksaif.net
