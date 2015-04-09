From: duson <dusonlin@emc.com.tw>
Subject: Re: [PATCH] Input: elan_i2c - enable ELAN0600 acpi panels
Date: Thu, 9 Apr 2015 19:02:23 +0800
Message-ID: <7C88A00C-F6E1-4FCD-8E77-7969BEB3F7C1@emc.com.tw>
References: <1427837698-419-1-git-send-email-benjamin.tissoires@redhat.com> <20150403210544.GC19867@dtor-ws>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from elanic.emc.com.tw ([192.72.220.188]:44312 "EHLO
	elanic.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932816AbbDILKL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Apr 2015 07:10:11 -0400
In-Reply-To: <20150403210544.GC19867@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Alessio Treglia <alessio@debian.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.com

Hi Dmitry,

Sorry later for reply. If touchpad is designed for Window OS,=20
the firmware will support standard HID mouse format (non-driver) and el=
an raw data format (with driver).

So, if user change OS from Window to Linux, touchpad will work fine und=
er HID format.

----------------------------------------------
Thanks,
ELAN Duson
=E2=9C=89 Email: dusonlin@emc.com.tw
----------------------------------------------





> Dmitry Torokhov <dmitry.torokhov@gmail.com> =E6=96=BC 2015=E5=B9=B44=E6=
=9C=884=E6=97=A5 =E4=B8=8A=E5=8D=885:05 =E5=AF=AB=E9=81=93=EF=BC=9A
>=20
> On Tue, Mar 31, 2015 at 05:34:58PM -0400, Benjamin Tissoires wrote:
>> ELAN0600 seems to work just fine in mouse emulation mode through i2c=
-hid,
>> but to have full raw touch support we need to register it in elan_i2=
c.ko
>>=20
>> Found on a Lenovo Yoga 3 11".
>>=20
>> Reported-and-tested-by: Alessio Treglia <alessio@debian.org>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>> ---
>>=20
>> Hi,
>>=20
>> Alessio reported this touchpad on the Lenovo Yoga 3. I must say that=
 I am
>> rather surprised that we need a cross tree support to enable this pa=
nel
>> and I would expect that the driver would be in the HID subtree, not =
a direct
>> input device.
>>=20
>> I understand the driver needs to access to the raw I2C commands, but=
 still,
>> we could have worked around in the HID tree directly.
>> Not to mention that the DT binding would have required only i2c-hid,=
 not a
>> custom vendor.
>>=20
>> Anyway, Jiri, Dmitry, who wants to take this one?
>=20
> Hmm, so elan_i2c.ko (and elants_i2c) is intended to be used with devi=
ces
> that are not compatible with HID protocol, as far as I know. I guess
> there are firmwares that can do both, but then we should default to H=
ID.
>=20
> Duson, any comments?
>=20
> Thanks!
>=20
>>=20
>> Cheers,
>> Benjamin
>>=20
>> drivers/hid/hid-core.c              | 1 +
>> drivers/input/mouse/elan_i2c_core.c | 1 +
>> 2 files changed, 2 insertions(+)
>>=20
>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>> index 722a925..33a22f4 100644
>> --- a/drivers/hid/hid-core.c
>> +++ b/drivers/hid/hid-core.c
>> @@ -2259,6 +2259,7 @@ static const struct hid_device_id hid_ignore_l=
ist[] =3D {
>> 	{ HID_USB_DEVICE(USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EM_LT=
20) },
>> 	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, 0x0004) },
>> 	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, 0x000a) },
>> +	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, 0x0400) },
>> 	{ HID_USB_DEVICE(USB_VENDOR_ID_ESSENTIAL_REALITY, USB_DEVICE_ID_ESS=
ENTIAL_REALITY_P5) },
>> 	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC5UH) },
>> 	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC4UM) },
>> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mou=
se/elan_i2c_core.c
>> index 375d98f..ced9a9c 100644
>> --- a/drivers/input/mouse/elan_i2c_core.c
>> +++ b/drivers/input/mouse/elan_i2c_core.c
>> @@ -1110,6 +1110,7 @@ MODULE_DEVICE_TABLE(i2c, elan_id);
>> #ifdef CONFIG_ACPI
>> static const struct acpi_device_id elan_acpi_id[] =3D {
>> 	{ "ELAN0000", 0 },
>> +	{ "ELAN0600", 0 },
>> 	{ }
>> };
>> MODULE_DEVICE_TABLE(acpi, elan_acpi_id);
>> --=20
>> 2.3.4
>>=20
>=20
> --=20
> Dmitry
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
