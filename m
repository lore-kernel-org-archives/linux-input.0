Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECFD439F7C;
	Tue, 15 Sep 2026 05:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789450192; cv=none; b=IetXXqX+ytSHICrJxPBNLgoeTGNzPaBSv9kA7Fh/yg6H85nnq7iFavLWG7bGFswCIpvU1P+CGw9zgGvJJlAp8tYtD9DK6iXdtRTLrKNxhpZOKxGThxBU+UCq5lsH4QJUGiOQyDdSeJ4+UGRRcBv264cuflgKlC7GWaFMn7bZzwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789450192; c=relaxed/simple;
	bh=b3Q8CjEhZcyyt7NtAkvaibsxeMBPS20WkpEkPd5spVQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=royb7wIdfQHRUoB7N2o0+gZe2VmMCzXL8IkJYLwTcdQtJdRmDmWWbYyGu8xrtuY8LhoalGNEw1//pdN2I+ewmt7b3anh7si5w84bvAb7Ww+jl0UmZkWWUUhT0mMjR05xG1CswXwLT4LAPM+ror5SHCf2mTUKYFsyxP7bnKP7mso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vasily.cc; spf=pass smtp.mailfrom=vasily.cc; dkim=pass (2048-bit key) header.d=vasily.cc header.i=@vasily.cc header.b=hdNaNvKk; arc=none smtp.client-ip=185.70.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vasily.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vasily.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vasily.cc header.i=@vasily.cc header.b="hdNaNvKk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vasily.cc;
	s=protonmail2; t=1789450185; x=1789709385;
	bh=DHHwrG5uEdEYmQtukohndASLvUP8lEG7DkJekDL1mRI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=hdNaNvKkjczaMtLGrV4U6Kd2jrkEKzLiOefRDX/Paw0wxmqxmJxKxSEIg6wSutd2f
	 /LRrrs+55x3kVufEqTZy0fGBTdNl/TTzi9Cm3T1kp8glKL0sMc4mYDhAGnq9vUj3Ku
	 Qp9AEgcPbEYqTy+T/gVMbSYk6iSIsMR/KZZCB94vSEihJ9gmjJlIadvEYug9KrJp/+
	 M3iiH9q3O/2nNE7mFoAjb7J/ZP6gmPV3G0ZavVDoElk2U+SRl/SNFvpK2FMasAAG1B
	 nSUUyPWJhNczSu07RiHqVWQfwbLLDWuFDzdflTCx9KYo0TaInuUaJiQ/HUExHLLZN2
	 drH+UQxwa2MHQ==
Date: Tue, 15 Sep 2026 05:29:39 +0000
To: Guenter Roeck <linux@roeck-us.net>
From: Vas Zayarskiy <contact@vasily.cc>
Cc: Aleksa Savic <savicaleksa83@gmail.com>, Jack Doan <me@jackdoan.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 4/4] hwmon: (aquacomputer_d5next) Add AMPINEL support
Message-ID: <ICzeTYsqVwKewqbj_Gv2WM93k1Kr6uygPhcTJ3M8PBtvmoV3AlfEnRWAspP-fQgdmRW4IR1OPPpDLhmQiIqEAh5OuCKvwRzxAHSO-7rnYAQ=@vasily.cc>
In-Reply-To: <a968a02f-c513-42f0-993f-ede4f785025c@roeck-us.net>
References: <20260914233728.22725-1-contact@vasily.cc> <20260914233728.22725-5-contact@vasily.cc> <a968a02f-c513-42f0-993f-ede4f785025c@roeck-us.net>
Feedback-ID: 162318860:user:proton
X-Pm-Message-ID: 3e959d633a95607746c4ec27dcbaa88b3defc585
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

Thanks for the review. I will add the trailing comma and separate the share=
d report validation and handling of an unknown firmware-version offset from=
 the AMPINEL addition. I also noted the -ENODATA and conversion/scaling wor=
ding corrections on patch 2.

> If the match function _is_ needed, the reason needs to be explained, even
> more so since this may impact USB_PRODUCT_ID_AQUAERO.

The requirement is to keep AMPINEL's keyboard interface bound to hid-generi=
c while the hwmon driver handles telemetry. Both interfaces share the same =
VID/PID and match aqc_table. With the existing __check_hid_generic(), that =
ID match is enough for hid-generic to decline the keyboard. Returning -ENOD=
EV from aqc_probe(), or rejecting it in aqc_match() alone, does not make it=
 eligible for hid-generic.

The Aquaero collection check rejects its non-telemetry interfaces during pr=
obe, but that check alone does not establish keyboard fallback to hid-gener=
ic. V3 leaves Aquaero's collection filtering in probe: aqc_match() accepts =
it subject to the same generic-driver override checks the core already appl=
ies when there is no match callback. I do not have Aquaero hardware and hav=
e not validated its keyboard behavior.

The matcher test demonstrates the AMPINEL rejection with the original hid-g=
eneric logic and passes with patch 1. This is a userspace harness, not a li=
ve kernel fallback test. With both revised modules loaded on the physical A=
MPINEL, the keyboard registration/capabilities survived hwmon reload and su=
spend/resume, and its capabilities were preserved on reboot. I will make th=
e matching rationale explicit in the next revision.

> FWIW, the raw even can happen prior to this, which will result
> in bad data. This also affetcs other devices supported by this
> driver (and those with fans can crash when it happens).

Could you clarify the path that permits raw_event during probe here? I chec=
ked the series base, 46fde107b4e881f179bf02bca69d8a0020561b3c. include/linu=
x/hid.h documents that callbacks are blocked during probe unless the driver=
 calls hid_device_io_start(). In hid-core.c, hid_device_probe() holds drive=
r_input_lock around the driver's probe, and __hid_input_report() returns -E=
BUSY when it cannot acquire that lock.

aqc_probe() does not call hid_device_io_start(), and neither hid_hw_start()=
 nor hid_hw_open() releases that lock. My reading is that normal USB report=
s cannot reach aqc_raw_event() until initialization has completed. Is there=
 another path that bypasses this protection? I have not reproduced the race=
, and would like to understand it before adding a shared initialization fix=
.

Thanks,
Vas



On Tuesday, September 15th, 2026 at 7:30 AM, Guenter Roeck <linux@roeck-us.=
net> wrote:

> On 9/14/26 16:37, Vas Zayarskiy wrote:
> > Add read-only total power, total current, input voltage, hotspot
> > temperature and six channel currents for the Aquacomputer AMPINEL.
> >
> > Decode its 544-byte input report through the existing serial-number,
> > temperature and update path, with power, current and voltage handled in
> > the device-specific switch. Store all readings in hwmon units.
> >
> > Match only the USB telemetry interface, leaving the separate keyboard
> > interface to hid-generic. Validate the telemetry collection and report
> > size before opening the device. Channel labels follow report order;
> > configuration and alarms are not supported.
> >
> > Assisted-by: LLM sparse
> > Signed-off-by: Vas Zayarskiy <contact@vasily.cc>
> > ---
> >   Documentation/hwmon/aquacomputer_d5next.rst |  11 ++
> >   drivers/hwmon/Kconfig                       |   4 +-
> >   drivers/hwmon/aquacomputer_d5next.c         | 107 +++++++++++++++++++=
-
> >   3 files changed, 116 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentatio=
n/hwmon/aquacomputer_d5next.rst
> > index 49163f387..faf1c51c1 100644
> > --- a/Documentation/hwmon/aquacomputer_d5next.rst
> > +++ b/Documentation/hwmon/aquacomputer_d5next.rst
> > @@ -13,6 +13,7 @@ Supported devices:
> >   * Aquacomputer Quadro fan controller
> >   * Aquacomputer High Flow Next sensor
> >   * Aquacomputer Leakshield leak prevention system
> > +* Aquacomputer AMPINEL power monitor
> >   * Aquacomputer Aquastream XT watercooling pump
> >   * Aquacomputer Aquastream Ultimate watercooling pump
> >   * Aquacomputer Poweradjust 3 fan controller
> > @@ -69,6 +70,16 @@ The Aquastream XT pump exposes temperature readings =
for the coolant, external se
> >   and fan IC. It also exposes pump and fan speeds (in RPM), voltages, a=
s well as pump
> >   current.
> >
> > +The AMPINEL exposes total power, total current, input voltage, hotspot
> > +temperature and six channel currents. Channel numbers follow report or=
der;
> > +their mapping to physical connector pins has not been verified. The re=
adings
> > +are received approximately twice per second. Only sensor reads are sup=
ported;
> > +the driver does not configure protection settings or report alarms.
> > +
> > +For AMPINEL, ``power1_input`` is total power, ``in0_input`` is input v=
oltage,
> > +``temp1_input`` is hotspot temperature, ``curr1_input`` is total curre=
nt, and
> > +``curr[2-7]_input`` are the six channel currents.
> > +
> >   The Aquastream Ultimate pump exposes coolant temp and an external tem=
p sensor, along
> >   with speed, power, voltage and current of both the pump and optionall=
y connected fan.
> >   It also exposes pressure and flow speed readings.
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 3d8b2c958..06cb246ff 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -257,14 +257,14 @@ config SENSORS_AHT10
> >   =09  will be called aht10.
> >
> >   config SENSORS_AQUACOMPUTER_D5NEXT
> > -=09tristate "Aquacomputer D5 Next, Octo, Quadro, Farbwerk, Farbwerk 36=
0, High Flow Next"
> > +=09tristate "Aquacomputer D5 Next and other USB devices"
> >   =09depends on USB_HID
> >   =09select CRC16
> >   =09help
> >   =09  If you say yes here you get support for sensors and fans of
> >   =09  the Aquacomputer D5 Next watercooling pump, Octo and Quadro fan
> >   =09  controllers, Farbwerk and Farbwerk 360 RGB controllers, High Flo=
w
> > -=09  Next sensor, where available.
> > +=09  Next sensor and AMPINEL power monitor, where available.
> >
> >   =09  This driver can also be built as a module. If so, the module
> >   =09  will be called aquacomputer_d5next.
> > diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquaco=
mputer_d5next.c
> > index b58f5b5c9..e661c4dfa 100644
> > --- a/drivers/hwmon/aquacomputer_d5next.c
> > +++ b/drivers/hwmon/aquacomputer_d5next.c
> > @@ -2,7 +2,7 @@
> >   /*
> >    * hwmon driver for Aquacomputer devices (D5 Next, Farbwerk, Farbwerk=
 360, Octo,
> >    * Quadro, High Flow Next, Aquaero, Aquastream Ultimate, Leakshield,
> > - * High Flow USB/MPS Flow family)
> > + * High Flow USB/MPS Flow family, AMPINEL)
> >    *
> >    * Aquacomputer devices send HID reports (with ID 0x01) every second =
to report
> >    * sensor values, except for devices that communicate through the
> > @@ -23,6 +23,7 @@
> >   #include <linux/module.h>
> >   #include <linux/seq_file.h>
> >   #include <linux/unaligned.h>
> > +#include <linux/usb.h>
> >
> >   #define USB_VENDOR_ID_AQUACOMPUTER=090x0c70
> >   #define USB_PRODUCT_ID_AQUAERO=09=090xf001
> > @@ -33,6 +34,7 @@
> >   #define USB_PRODUCT_ID_OCTO=09=090xf011
> >   #define USB_PRODUCT_ID_HIGHFLOWNEXT=090xf012
> >   #define USB_PRODUCT_ID_LEAKSHIELD=090xf014
> > +#define USB_PRODUCT_ID_AMPINEL=09=090xf015
> >   #define USB_PRODUCT_ID_AQUASTREAMXT=090xf0b6
> >   #define USB_PRODUCT_ID_AQUASTREAMULT=090xf00b
> >   #define USB_PRODUCT_ID_POWERADJUST3=090xf0bd
> > @@ -41,7 +43,7 @@
> >   enum kinds {
> >   =09d5next, farbwerk, farbwerk360, octo, quadro,
> >   =09highflownext, aquaero, poweradjust3, aquastreamult,
> > -=09aquastreamxt, leakshield, highflow
> > +=09aquastreamxt, leakshield, highflow, ampinel
> >   };
> >
> >   static const char *const aqc_device_names[] =3D {
> > @@ -56,7 +58,8 @@ static const char *const aqc_device_names[] =3D {
> >   =09[aquaero] =3D "aquaero",
> >   =09[aquastreamult] =3D "aquastreamultimate",
> >   =09[poweradjust3] =3D "poweradjust3",
> > -=09[highflow] =3D "highflow" /* Covers MPS Flow devices */
> > +=09[highflow] =3D "highflow", /* Covers MPS Flow devices */
> > +=09[ampinel] =3D "ampinel"
>=20
> Add "," at the end to avoid having to change it whenever a new device is =
added.
>=20
> >   };
> >
> >   #define DRIVER_NAME=09=09=09"aquacomputer_d5next"
> > @@ -111,6 +114,16 @@ static u8 aquaero_secondary_ctrl_report[] =3D {
> >   #define AQC_FAN_POWER_OFFSET=09=090x06
> >   #define AQC_FAN_SPEED_OFFSET=09=090x08
> >
> > +/* AMPINEL offsets include the report ID byte. */
> > +#define AMPINEL_DATA_INTERFACE=09=091
> > +#define AMPINEL_STATUS_REPORT_SIZE=09544
> > +#define AMPINEL_NUM_CHANNELS=09=096
> > +#define AMPINEL_CHANNEL_CURRENT_START=090x6f
> > +#define AMPINEL_POWER=09=09=090xc7
> > +#define AMPINEL_CURRENT=09=09=090xc9
> > +#define AMPINEL_VOLTAGE=09=09=090xcf
> > +#define AMPINEL_HOTSPOT=09=09=090xe1
> > +
> >   /* Specs of the Aquaero fan controllers */
> >   #define AQUAERO_SERIAL_START=09=09=090x07
> >   #define AQUAERO_FIRMWARE_VERSION=09=090x0B
> > @@ -516,6 +529,24 @@ static const char *const label_highflow_speeds[] =
=3D {
> >   =09"Flow speed [dL/h]"
> >   };
> >
> > +static const char *const label_ampinel_temp[] =3D {
> > +=09"Hotspot"
> > +};
> > +
> > +static const char *const label_ampinel_power[] =3D {
> > +=09"Total power"
> > +};
> > +
> > +static const char *const label_ampinel_voltage[] =3D {
> > +=09"VCC In"
> > +};
> > +
> > +static const char *const label_ampinel_current[] =3D {
> > +=09"Total current",
> > +=09"Channel 1", "Channel 2", "Channel 3",
> > +=09"Channel 4", "Channel 5", "Channel 6"
> > +};
> > +
> >   struct aqc_fan_structure_offsets {
> >   =09u8 voltage;
> >   =09u8 curr;
> > @@ -869,6 +900,10 @@ static umode_t aqc_is_visible(const void *data, en=
um hwmon_sensor_types type, u3
> >   =09=09break;
> >   =09case hwmon_power:
> >   =09=09switch (priv->kind) {
> > +=09=09case ampinel:
> > +=09=09=09if (channel =3D=3D 0)
> > +=09=09=09=09return 0444;
> > +=09=09=09break;
> >   =09=09case aquastreamult:
> >   =09=09=09/* Special case to support pump and fan power */
> >   =09=09=09if (channel < 2)
> > @@ -889,6 +924,10 @@ static umode_t aqc_is_visible(const void *data, en=
um hwmon_sensor_types type, u3
> >   =09=09break;
> >   =09case hwmon_curr:
> >   =09=09switch (priv->kind) {
> > +=09=09case ampinel:
> > +=09=09=09if (channel < AMPINEL_NUM_CHANNELS + 1)
> > +=09=09=09=09return 0444;
> > +=09=09=09break;
> >   =09=09case aquastreamult:
> >   =09=09=09/* Special case to support pump and fan current */
> >   =09=09=09if (channel < 2)
> > @@ -907,6 +946,10 @@ static umode_t aqc_is_visible(const void *data, en=
um hwmon_sensor_types type, u3
> >   =09=09break;
> >   =09case hwmon_in:
> >   =09=09switch (priv->kind) {
> > +=09=09case ampinel:
> > +=09=09=09if (channel =3D=3D 0)
> > +=09=09=09=09return 0444;
> > +=09=09=09break;
> >   =09=09case d5next:
> >   =09=09=09/* Special case to support +5V and +12V voltage sensors */
> >   =09=09=09if (channel < priv->num_fans + 2)
> > @@ -1336,12 +1379,17 @@ static int aqc_raw_event(struct hid_device *hde=
v, struct hid_report *report, u8
> >   =09=09return 0;
> >
> >   =09priv =3D hid_get_drvdata(hdev);
> > +=09if (priv->kind =3D=3D ampinel &&
> > +=09    (report->type !=3D HID_INPUT_REPORT || size !=3D AMPINEL_STATUS=
_REPORT_SIZE ||
> > +=09     data[0] !=3D STATUS_REPORT_ID))
> > +=09=09return 0;
> >
>=20
> This is again a bug fix affecting other controllers as well (report size =
and
> input type check).
>=20
> >   =09/* Info provided with every report */
> >   =09priv->serial_number[0] =3D get_unaligned_be16(data + priv->serial_=
number_start_offset);
> >   =09priv->serial_number[1] =3D get_unaligned_be16(data + priv->serial_=
number_start_offset +
> >   =09=09=09=09=09=09    SERIAL_PART_OFFSET);
> > -=09priv->firmware_version =3D get_unaligned_be16(data + priv->firmware=
_version_offset);
> > +=09if (priv->firmware_version_offset)
> > +=09=09priv->firmware_version =3D get_unaligned_be16(data + priv->firmw=
are_version_offset);
>=20
> Unrelated to adding support for ampinel.
>=20
> >
> >   =09/* Physical temperature sensor readings */
> >   =09for (i =3D 0; i < priv->num_temp_sensors; i++) {
> > @@ -1394,6 +1442,17 @@ static int aqc_raw_event(struct hid_device *hdev=
, struct hid_report *report, u8
> >
> >   =09/* Special-case sensor readings */
> >   =09switch (priv->kind) {
> > +=09case ampinel:
> > +=09=09priv->power_input[0] =3D
> > +=09=09=09min_t(u64, get_unaligned_be16(data + AMPINEL_POWER) * 100000U=
LL,
> > +=09=09=09      LONG_MAX);
> > +=09=09priv->current_input[0] =3D get_unaligned_be16(data + AMPINEL_CUR=
RENT) * 10;
> > +=09=09for (i =3D 0; i < AMPINEL_NUM_CHANNELS; i++)
> > +=09=09=09priv->current_input[i + 1] =3D
> > +=09=09=09=09get_unaligned_be16(data + AMPINEL_CHANNEL_CURRENT_START +
> > +=09=09=09=09=09=09   i * AQC_SENSOR_SIZE);
> > +=09=09priv->voltage_input[0] =3D get_unaligned_be16(data + AMPINEL_VOL=
TAGE);
> > +=09=09break;
> >   =09case aquaero:
> >   =09=09/* Read calculated virtual temp sensors */
> >   =09=09i =3D priv->num_temp_sensors + priv->num_virtual_temp_sensors;
> > @@ -1519,8 +1578,26 @@ static void aqc_debugfs_init(struct aqc_data *pr=
iv)
> >   =09=09debugfs_create_file("power_cycles", 0444, priv->debugfs, priv, =
&power_cycles_fops);
> >   }
> >
> > +static bool aqc_match(struct hid_device *hdev, bool ignore_special_dri=
ver)
> > +{
> > +=09struct usb_interface *intf;
> > +
> > +=09if (ignore_special_driver || hdev->quirks & HID_QUIRK_IGNORE_SPECIA=
L_DRIVER)
> > +=09=09return false;
> > +
> > +=09if (hdev->product !=3D USB_PRODUCT_ID_AMPINEL)
> > +=09=09return true;
> > +
> > +=09if (!hid_is_usb(hdev))
> > +=09=09return false;
> > +
> > +=09intf =3D to_usb_interface(hdev->dev.parent);
> > +=09return intf->cur_altsetting->desc.bInterfaceNumber =3D=3D AMPINEL_D=
ATA_INTERFACE;
> > +}
> > +
> >   static int aqc_probe(struct hid_device *hdev, const struct hid_device=
_id *id)
> >   {
> > +=09struct hid_report *report;
> >   =09struct aqc_data *priv;
> >   =09int ret;
> >
> > @@ -1537,6 +1614,14 @@ static int aqc_probe(struct hid_device *hdev, co=
nst struct hid_device_id *id)
> >   =09if (ret)
> >   =09=09return ret;
> >
> > +=09if (hdev->product =3D=3D USB_PRODUCT_ID_AMPINEL) {
> > +=09=09report =3D hdev->report_enum[HID_INPUT_REPORT].report_id_hash[ST=
ATUS_REPORT_ID];
> > +=09=09if (hdev->maxcollection !=3D 1 ||
> > +=09=09    hdev->collection[0].usage !=3D (HID_UP_MSVENDOR | 1) ||
> > +=09=09    !report || report->size !=3D (AMPINEL_STATUS_REPORT_SIZE - 1=
) * 8)
> > +=09=09=09return -ENODEV;
> > +=09}
>=20
> USB_PRODUCT_ID_AQUAERO has the same or a similar problem and handles it
> in the switch statement below. I do not see a reason to handle this one
> differently (including the need for the match function which doesn't seem
> to be needed for USB_PRODUCT_ID_AQUAERO).
>=20
> If the match function _is_ needed, the reason needs to be explained, even
> more so since this may impact USB_PRODUCT_ID_AQUAERO.
>=20
> > +
> >   =09ret =3D hid_hw_start(hdev, HID_CONNECT_HIDRAW);
> >   =09if (ret)
> >   =09=09return ret;
> > @@ -1546,6 +1631,15 @@ static int aqc_probe(struct hid_device *hdev, co=
nst struct hid_device_id *id)
> >   =09=09goto fail_and_stop;
> >
> >   =09switch (hdev->product) {
> > +=09case USB_PRODUCT_ID_AMPINEL:
> > +=09=09priv->kind =3D ampinel;
> > +=09=09priv->num_temp_sensors =3D 1;
> > +=09=09priv->temp_sensor_start_offset =3D AMPINEL_HOTSPOT;
>=20
> FWIW, the raw even can happen prior to this, which will result
> in bad data. This also affetcs other devices supported by this
> driver (and those with fans can crash when it happens).
>=20
> > +=09=09priv->temp_label =3D label_ampinel_temp;
> > +=09=09priv->power_label =3D label_ampinel_power;
> > +=09=09priv->voltage_label =3D label_ampinel_voltage;
> > +=09=09priv->current_label =3D label_ampinel_current;
> > +=09=09break;
> >   =09case USB_PRODUCT_ID_AQUAERO:
> >   =09=09/*
> >   =09=09 * Aquaero presents itself as three HID devices under the same =
product ID:
> > @@ -1795,6 +1889,9 @@ static int aqc_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
> >   =09}
> >
> >   =09switch (priv->kind) {
> > +=09case ampinel:
> > +=09=09priv->serial_number_start_offset =3D AQC_SERIAL_START;
> > +=09=09break;
> >   =09case aquaero:
> >   =09=09priv->serial_number_start_offset =3D AQUAERO_SERIAL_START;
> >   =09=09priv->firmware_version_offset =3D AQUAERO_FIRMWARE_VERSION;
> > @@ -1890,6 +1987,7 @@ static const struct hid_device_id aqc_table[] =3D=
 {
> >   =09{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_QUADRO=
) },
> >   =09{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_HIGHFL=
OWNEXT) },
> >   =09{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_LEAKSH=
IELD) },
> > +=09{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_AMPINEL=
) },
> >   =09{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_AQUAST=
REAMXT) },
> >   =09{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_AQUAST=
REAMULT) },
> >   =09{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_POWERA=
DJUST3) },
> > @@ -1902,6 +2000,7 @@ MODULE_DEVICE_TABLE(hid, aqc_table);
> >   static struct hid_driver aqc_driver =3D {
> >   =09.name =3D DRIVER_NAME,
> >   =09.id_table =3D aqc_table,
> > +=09.match =3D aqc_match,
> >   =09.probe =3D aqc_probe,
> >   =09.remove =3D aqc_remove,
> >   =09.raw_event =3D aqc_raw_event,
>=20
> 
