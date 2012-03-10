From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 1/5] HID: multitouch: add support for eGalax 0x722a
Date: Sat, 10 Mar 2012 07:31:57 +0100
Message-ID: <CAN+gG=F0w88T-iDxVJNEjgyud8FwC5vTGT8+2KTva8FXgFjTog@mail.gmail.com>
References: <1331053026-21272-1-git-send-email-benjamin.tissoires@gmail.com>
	<1331053026-21272-2-git-send-email-benjamin.tissoires@gmail.com>
	<alpine.LNX.2.00.1203091329030.18356@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1203091329030.18356@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Mar 9, 2012 at 13:29, Jiri Kosina <jkosina@suse.cz> wrote:
> On Tue, 6 Mar 2012, benjamin.tissoires wrote:
>
>> From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
>>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
>> ---
>> =A0drivers/hid/hid-ids.h =A0 =A0 =A0 =A0| =A0 =A01 +
>> =A0drivers/hid/hid-multitouch.c | =A0 =A03 +++
>> =A02 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index 6656516..e1fada2 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -240,6 +240,7 @@
>> =A0#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7207 =A0 =A00x7207
>> =A0#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_720C =A0 =A00x720c
>> =A0#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7224 =A0 =A00x7224
>> +#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_722A =A0 =A00x722A
>> =A0#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_725E =A0 =A00x725e
>> =A0#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7262 =A0 =A00x7262
>> =A0#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_726B =A0 =A00x726b
>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitou=
ch.c
>> index 0eda37f..019de83 100644
>> --- a/drivers/hid/hid-multitouch.c
>> +++ b/drivers/hid/hid-multitouch.c
>> @@ -797,6 +797,9 @@ static const struct hid_device_id mt_devices[] =3D=
 {
>> =A0 =A0 =A0 { .driver_data =3D MT_CLS_EGALAX_SERIAL,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_DWAV_EGALA=
X_MULTITOUCH_7224) },
>> + =A0 =A0 { .driver_data =3D MT_CLS_EGALAX_SERIAL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_DWAV_EGALAX_=
MULTITOUCH_722A) },
>> =A0 =A0 =A0 { .driver_data =3D MT_CLS_EGALAX,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_DWAV_EGALA=
X_MULTITOUCH_726B) },
>
> Applied.
>

Thanks Jiri.
How about patches 2,3 and 5?
Patch 2 is waited for LG users since a long time now (though it gives w=
arnings).
Patch 3 can be included without patch 4: just loading hid-multitouch
makes the device working. And even if it's a little "hackish", it
won't hurt any other hid devices.
Patch 5 will introduce more robustness for the default class, but
requires patch 3.

Cheers,
Benjamin

> --
> Jiri Kosina
> SUSE Labs
