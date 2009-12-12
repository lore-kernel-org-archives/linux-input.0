From: Anisse Astier <anisse@astier.eu>
Subject: Re: [PATCH 1/7] X86 drivers: Introduce msi-wmi driver
Date: Sat, 12 Dec 2009 20:21:05 +0100
Message-ID: <38c9179b0912121121u5f7d76f9n5eac218b82bb555a@mail.gmail.com>
References: <1260451099-25620-1-git-send-email-anisse@astier.eu>
	<1260451099-25620-2-git-send-email-anisse@astier.eu> <9b2b86520912120937i548b1158k50f517af7fd5ed21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:33073 "HELO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932156AbZLMCVk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Dec 2009 21:21:40 -0500
Received: by fxm5 with SMTP id 5so2365063fxm.28
        for <linux-input@vger.kernel.org>; Sat, 12 Dec 2009 18:21:39 -0800 (PST)
In-Reply-To: <9b2b86520912120937i548b1158k50f517af7fd5ed21@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Cc: linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Matt Chen <machen@novell.com>

Hi Alan,

Thanks for taking the time to review it,

On Sat, Dec 12, 2009 at 18:37, Alan Jenkins
<sourcejedi.lkml@googlemail.com> wrote:
> Hi Anisse
>
> I think there are a few theoretical issues remaining in this driver
> (although I've not read your followup patches, I just checked the
> subject lines).
>
> On 12/10/09, Anisse Astier <anisse@astier.eu> wrote:
>> +config MSI_WMI
>> + =A0 =A0 tristate "MSI WMI extras"
>> + =A0 =A0 depends on ACPI_WMI
>> + =A0 =A0 depends on INPUT
>
> I think this driver depends on BACKLIGHT_CLASS_DEVICE as well.

Indeed it depends on it..

>
>> + =A0 =A0 help
>> + =A0 =A0 =A0Say Y here if you want to support WMI-based hotkeys on =
MSI laptops.
>> +
>> + =A0 =A0 =A0To compile this driver as a module, choose M here: the =
module will
>> + =A0 =A0 =A0be called msi-wmi.
>> +
>
>
>> +static int bl_get(struct backlight_device *bd)
>> +{
>> + =A0 =A0 int level, err, ret =3D 0;
>> +
>> + =A0 =A0 /* Instance 1 is "get backlight", cmp with DSDT */
>> + =A0 =A0 err =3D msi_wmi_query_block(1, &ret);
>> + =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR DRV_PFX "Could not query b=
acklight: %d\n", err);
>
> It looks like we continue despite this error, and return 0? =A0I thin=
k
> an error code would be more appropriate. =A0It would definitely be
> better to use an explicit return statement here (and not set ret =3D =
0
> beforehand).
>
> In reality the current backlight class doesn't support error codes...
> but I figure it's better to give userspace an obviously wrong number,
> rather than falsely claiming we know that the blacklight is set to 0.
>

Sure.

>
>
>> +static void msi_wmi_notify(u32 value, void *context)
>> +{
>> + =A0 =A0 struct acpi_buffer response =3D { ACPI_ALLOCATE_BUFFER, NU=
LL };
>> + =A0 =A0 static struct key_entry *key;
>> + =A0 =A0 union acpi_object *obj;
>> + =A0 =A0 ktime_t cur;
>> +
>> + =A0 =A0 wmi_get_event_data(value, &response);
>> +
>> + =A0 =A0 obj =3D (union acpi_object *)response.pointer;
>> +
>> + =A0 =A0 if (obj && obj->type =3D=3D ACPI_TYPE_INTEGER) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 int eventcode =3D obj->integer.value;
>> + =A0 =A0 =A0 =A0 =A0 =A0 dprintk("Eventcode: 0x%x\n", eventcode);
>> + =A0 =A0 =A0 =A0 =A0 =A0 key =3D msi_wmi_get_entry_by_scancode(even=
tcode);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (key) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cur =3D ktime_get_real();
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Ignore event if the sam=
e event happened in a 50 ms
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0timeframe -> Key pr=
ess may result in 10-20 GPEs */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ktime_to_us(ktime_sub(=
cur, key->last_pressed))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 < 1000 * 50) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dprintk("S=
uppressed key event 0x%X - "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "Last press was %lld us ago\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0key->code,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0ktime_to_us(ktime_sub(cur,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0key->last_pressed)));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 key->last_pressed =3D cur;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (key->type) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case KE_KEY:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Brightn=
ess is served via acpi video driver */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!backl=
ight &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (k=
ey->keycode =3D=3D KEY_BRIGHTNESSUP ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
key->keycode =3D=3D KEY_BRIGHTNESSDOWN))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 break;
>
> Given backlight =3D=3D NULL, this will mysteriously prevent users fro=
m
> remapping the volume keys to use as a brightness control. =A0I think =
it
> would be better to check the original scancodes.

Agreed, this backlight =3D=3D NULL should be replaced by the
acpi_video_backlight_support() test, which would be clearer, as it is
the only way that the driver could be fully initialized and backlight
still be NULL.

As for the remapping problem you are right, but please remember that
this code is theoretical and future-proofing, because on my
hardware(MSI Windtop AE1900-WT,  all-in-one Atom-based computer),
backlight is always controlled through WMI. Can you confirm that on
yours Thomas?


>
> Also, can you please confirm that the ACPI BIOS does _not_ change the
> brightness level in response to these keys? =A0If it does, the driver
> should really use backlight_force_update() instead of generating
> KEY_BRIGHTNESS* events.

I can confirm that the backlight is not controlled by the ACPI BIOS.
You must issue a WMI request to change it.


Regards,
Anisse
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
