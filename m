From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] Add Support for Novatek Touchscreen
Date: Wed, 6 Jun 2012 16:44:41 +0200
Message-ID: <CAN+gG=EjBkOn6MGAO0bfO0Bj-3YDp-kzseMu9DfiXWJaMkWUXA@mail.gmail.com>
References: <CAOY97VZN2a36OBsacQS21P8G70L2tbtbWK5OMWhZYa=D74XO+w@mail.gmail.com>
	<alpine.LNX.2.00.1206051134020.5478@pobox.suse.cz>
	<CAN+gG=FSTxE9d8o4O6+kQHmyg9PdJK28x6=Gjpgr+_xppiRVbQ@mail.gmail.com>
	<alpine.LNX.2.00.1206061601460.12208@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1206061601460.12208@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Austin Hendrix <ahendrix@willowgarage.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Jun 6, 2012 at 4:03 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Tue, 5 Jun 2012, Benjamin Tissoires wrote:
>
>> >> Add support for a Novatek touchscreen panel as a generic HID mult=
itouch
>> >> panel.
>> >>
>> >> Signed-off-by: Austin Hendrix <ahendrix@willowgarage.com>
>> >> ---
>> >> =A0hid-core.c =A0 =A0 =A0 | =A0 =A01 +
>> >> =A0hid-ids.h =A0 =A0 =A0 =A0| =A0 =A03 +++
>> >> =A0hid-multitouch.c | =A0 =A05 +++++
>> >> =A03 files changed, 9 insertions(+)
>> >>
>> >> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>> >> index 8e3a6b2..0d6dde1 100644
>> >> --- a/drivers/hid/hid-core.c
>> >> +++ b/drivers/hid/hid-core.c
>> >> @@ -1605,6 +1605,7 @@ static const struct hid_device_id
>> >> hid_have_special_driver[] =3D {
>> >
>> > Austin,
>> >
>> > thanks for the patch. Your mail client is corrupting (line-wrappin=
g)
>> > patches. Please fix that for your future submissions.
>> >
>> > I have now fixed that up manually and applied.
>> >
>> >> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_N=
TRIG_TOUCH_SCREEN_16) },
>> >> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_N=
TRIG_TOUCH_SCREEN_17) },
>> >> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_N=
TRIG_TOUCH_SCREEN_18) },
>> >> + =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_NOVATEK, USB_DEVICE_ID_N=
OVATEK_PCT) },
>>
>> I don't think this should be included in 3.5-rc+ (the whole MT-relat=
ed
>> devices has been removed from this list).
>
> Yeah, I have noticed this and fixed it in 3.5-rc+ branch.
>
>>
>> >> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_O=
RTEK_PKB1700) },
>> >> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_O=
RTEK_WKB2000) },
>> >> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_PETALYNX,
>> >> USB_DEVICE_ID_PETALYNX_MAXTER_REMOTE) },
>> >> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> >> index 9373f53..734a2b9 100644
>> >> --- a/drivers/hid/hid-ids.h
>> >> +++ b/drivers/hid/hid-ids.h
>> >> @@ -564,6 +564,9 @@
>> >> =A0#define USB_VENDOR_ID_NINTENDO =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0=
57e
>> >> =A0#define USB_DEVICE_ID_NINTENDO_WIIMOTE =A0 =A0 =A0 0x0306
>> >>
>> >> +#define USB_VENDOR_ID_NOVATEK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0=
603
>> >> +#define USB_DEVICE_ID_NOVATK_PCT =A0 =A00x0600
>> >> +
>> >> =A0#define USB_VENDOR_ID_NTRIG =A0 =A0 =A0 =A0 =A00x1b96
>> >> =A0#define USB_DEVICE_ID_NTRIG_TOUCH_SCREEN =A0 0x0001
>> >> =A0#define USB_DEVICE_ID_NTRIG_TOUCH_SCREEN_1 =A0 0x0003
>> >> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multi=
touch.c
>> >> index 6e3332a..fae08df 100644
>> >> --- a/drivers/hid/hid-multitouch.c
>> >> +++ b/drivers/hid/hid-multitouch.c
>> >> @@ -951,6 +951,11 @@ static const struct hid_device_id mt_devices=
[] =3D {
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 MT_USB_DEVICE(USB_VENDOR_ID_PANASONIC=
,
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_PANABOA=
RD_UBT880) },
>> >>
>> >> + =A0 =A0 /* Novatek Panel */
>> >> + =A0 =A0 { .driver_data =3D MT_CLS_DEFAULT,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_NOVATEK,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_NOVATEK_P=
CT) },
>>
>> Shouldn't we use MT_USB_DEVICE instead?
>
> We should, I have missed this and will fix this up with your Reported=
-by:,
> ok?

No-problem.

Thanks,
Benjamin

>
> Thanks!
>
> --
> Jiri Kosina
> SUSE Labs
