Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA39D3D6CCF;
	Tue,  3 Mar 2026 10:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772535526; cv=none; b=AnX5R4tk4S/eXqcRiUQAds++tOPbLMNeusnEXG87h+Em2LZz6DuqK5MJ54yWaDyXVWTVENU2T1X+YsO8mzSNpg+dIGbPZwRHSmBf/X11ZGGe5yjyVbQ5Ap+51ZgQuDZ2vkfs7mzQWX6xLoOIhWlaPfo4FJQc5z7NTUazzfH0cnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772535526; c=relaxed/simple;
	bh=sCG5BcOTuNg88r4kjzV+z4yxDw5tRLkk2i5tcAQwryA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KNQCCgBUhwmMjTdZvDs7GluYo1wzyp+pp9u+7E3dR3hGgrRO4/h2x8fGIEGPJWM5KW9LUWU+Dsdr1N7w6ggg1g1zUUyr6RIVZV0ke8iH9TcNAsuGBA7OBOreAaDo+wYver3qOFmRa5Psuw54UaP8fFOoo+LKFgSewmFGSqipV3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id DBC4E2019D;
	Tue,  3 Mar 2026 10:58:30 +0000 (UTC)
Message-ID: <18d2d87dfa2b0f0f822191bd44dc8531a0e07373.camel@hadess.net>
Subject: Re: [PATCH v3 04/18] HID: steelseries: Add async support and unify
 device definitions
From: Bastien Nocera <hadess@hadess.net>
To: Sriman Achanta <srimanachanta@gmail.com>, Jiri Kosina
 <jikos@kernel.org>,  Benjamin Tissoires	 <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Wood
	 <simon@mungewell.org>, Christian Mayer <git@mayer-bgk.de>
Date: Tue, 03 Mar 2026 11:58:30 +0100
In-Reply-To: <20260227235042.410062-5-srimanachanta@gmail.com>
References: <20260227235042.410062-1-srimanachanta@gmail.com>
	 <20260227235042.410062-5-srimanachanta@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtgedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepieffgfehtedtgefgjeeggfffgeeuvdegveekveejfeekkedujeehteffueefffeunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepffeuveeggfdvtdduleffpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepjedprhgtphhtthhopehsrhhimhgrnhgrtghhrghnthgrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhikhhosheskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtohepsggvnhhtihhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqihhnphhuthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsihhmohhnsehmuhhnghgvfigvlhhlrdhorhhg
X-GND-State: clean

On Fri, 2026-02-27 at 18:50 -0500, Sriman Achanta wrote:
> Refactor the SteelSeries driver to improve scalability and support
> the
> modern Arctis Nova headset lineup along with legacy models.

This patch is the biggest in the patchset, and could really do with
being split up.

>=20
> - Replace the bitmap-based quirk system with `struct
> =C2=A0 steelseries_device_info` to encapsulate device-specific traits
> =C2=A0 (product ID, name, capabilities, interfaces).
> - Implement asynchronous battery monitoring. Devices that support
> async
> =C2=A0 updates (like the Nova series) now rely on interrupt events rather
> =C2=A0 than periodic polling, reducing overhead.
> - Add support for complex multi-interface devices (e.g., Nova 7)
> where
> =C2=A0 battery events arrive on a separate asynchronous interface.
> - Consolidate battery request and report parsing logic. New helpers
> =C2=A0 `steelseries_send_feature_report` and
> `steelseries_send_output_report`
> =C2=A0 simplify command dispatch.
> - Add support for over 20 new devices including the entire Arctis
> Nova
> =C2=A0 series (3, 5, 7, Pro) and various Arctis 7/9/Pro variants.

You can't mix refactoring and new code to support new devices, it just
makes the code unreviewable.

> - Clean up naming conventions (e.g., removing `_headset_` prefix from
> =C2=A0 general functions) and improve locking in the battery timer.

No, there are many other Steelseries devices (keyboards, mice, and the
already support steering wheel!) so removing the headset descriptor
seems like something that could cause problems in the future. It might
be a good idea to split it off into hid-steelseries-headset.c instead,
but that's a lot of work...

>=20
> Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
> ---
> =C2=A0drivers/hid/hid-steelseries.c | 894 +++++++++++++++++++++++++------=
-
> --
> =C2=A01 file changed, 653 insertions(+), 241 deletions(-)
>=20
> diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-
> steelseries.c
> index d3711022bf86..d8ece8449255 100644
> --- a/drivers/hid/hid-steelseries.c
> +++ b/drivers/hid/hid-steelseries.c
> @@ -4,37 +4,54 @@
> =C2=A0 *
> =C2=A0 *=C2=A0 Copyright (c) 2013 Simon Wood
> =C2=A0 *=C2=A0 Copyright (c) 2023 Bastien Nocera
> + *=C2=A0 Copyright (c) 2025 Sriman Achanta
> =C2=A0 */
> =C2=A0
> -/*
> - */
> -
> +#include <linux/delay.h>
> =C2=A0#include <linux/device.h>
> =C2=A0#include <linux/hid.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/usb.h>
> =C2=A0#include <linux/leds.h>
> +#include <linux/power_supply.h>
> +#include <linux/workqueue.h>
> +#include <linux/spinlock.h>
> =C2=A0
> =C2=A0#include "hid-ids.h"
> =C2=A0
> -#define STEELSERIES_SRWS1		BIT(0)
> -#define STEELSERIES_ARCTIS_1		BIT(1)
> -#define STEELSERIES_ARCTIS_1_X		BIT(2)
> -#define STEELSERIES_ARCTIS_9		BIT(3)
> +#define SS_CAP_BATTERY			BIT(0)
> +
> +#define SS_QUIRK_STATUS_SYNC_POLL	BIT(0)
> +
> +struct steelseries_device;
> +
> +struct steelseries_device_info {
> +	unsigned long capabilities;
> +	unsigned long quirks;
> +
> +	u8 sync_interface;
> +	u8 async_interface;
> +
> +	int (*request_status)(struct hid_device *hdev);
> +	void (*parse_status)(struct steelseries_device *sd, u8
> *data, int size);
> +};
> =C2=A0
> =C2=A0struct steelseries_device {
> =C2=A0	struct hid_device *hdev;
> -	unsigned long quirks;
> +	const struct steelseries_device_info *info;
> =C2=A0
> -	struct delayed_work battery_work;
> -	spinlock_t lock;
> -	bool removed;
> +	bool use_async_protocol;
> +
> +	struct delayed_work status_work;
> =C2=A0
> =C2=A0	struct power_supply_desc battery_desc;
> =C2=A0	struct power_supply *battery;
> -	uint8_t battery_capacity;
> =C2=A0	bool headset_connected;
> +	u8 battery_capacity;
> =C2=A0	bool battery_charging;
> +
> +	spinlock_t lock;
> +	bool removed;
> =C2=A0};
> =C2=A0
> =C2=A0#if IS_BUILTIN(CONFIG_LEDS_CLASS) || \
> @@ -341,53 +358,118 @@ static int steelseries_srws1_probe(struct
> hid_device *hdev,
> =C2=A0}
> =C2=A0#endif
> =C2=A0
> -#define STEELSERIES_HEADSET_BATTERY_TIMEOUT_MS	3000
> +static const __u8 *steelseries_srws1_report_fixup(struct hid_device
> *hdev,
> +		__u8 *rdesc, unsigned int *rsize)
> +{
> +	if (hdev->vendor !=3D USB_VENDOR_ID_STEELSERIES ||
> +	=C2=A0=C2=A0=C2=A0 hdev->product !=3D USB_DEVICE_ID_STEELSERIES_SRWS1)
> +		return rdesc;
> =C2=A0
> -#define ARCTIS_1_BATTERY_RESPONSE_LEN		8
> -#define ARCTIS_9_BATTERY_RESPONSE_LEN		64
> -static const char arctis_1_battery_request[] =3D { 0x06, 0x12 };
> -static const char arctis_9_battery_request[] =3D { 0x00, 0x20 };
> +	if (*rsize >=3D 115 && rdesc[11] =3D=3D 0x02 && rdesc[13] =3D=3D 0xc8
> +			&& rdesc[29] =3D=3D 0xbb && rdesc[40] =3D=3D 0xc5) {
> +		hid_info(hdev, "Fixing up Steelseries SRW-S1 report
> descriptor\n");
> +		*rsize =3D sizeof(steelseries_srws1_rdesc_fixed);
> +		return steelseries_srws1_rdesc_fixed;
> +	}
> +	return rdesc;
> +}
> =C2=A0
> -static int steelseries_headset_request_battery(struct hid_device
> *hdev,
> -	const char *request, size_t len)
> +/*
> + * Headset report helpers
> + */
> +
> +static int steelseries_send_report(struct hid_device *hdev, const u8
> *data,
> +				=C2=A0=C2=A0=C2=A0 int len, enum hid_report_type
> type)
> =C2=A0{
> -	u8 *write_buf;
> +	u8 *buf;
> =C2=A0	int ret;
> =C2=A0
> -	/* Request battery information */
> -	write_buf =3D kmemdup(request, len, GFP_KERNEL);
> -	if (!write_buf)
> +	buf =3D kmemdup(data, len, GFP_KERNEL);
> +	if (!buf)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	hid_dbg(hdev, "Sending battery request report");
> -	ret =3D hid_hw_raw_request(hdev, request[0], write_buf, len,
> -				 HID_OUTPUT_REPORT,
> HID_REQ_SET_REPORT);
> -	if (ret < (int)len) {
> -		hid_err(hdev, "hid_hw_raw_request() failed with
> %d\n", ret);
> -		ret =3D -ENODATA;
> -	}
> +	ret =3D hid_hw_raw_request(hdev, data[0], buf, len, type,
> +				 HID_REQ_SET_REPORT);
> +	kfree(buf);
> =C2=A0
> -	kfree(write_buf);
> -	return ret;
> +	if (ret < 0)
> +		return ret;
> +	if (ret < len)
> +		return -EIO;
> +
> +	return 0;
> =C2=A0}
> =C2=A0
> -static void steelseries_headset_fetch_battery(struct hid_device
> *hdev)
> +static inline int steelseries_send_feature_report(struct hid_device
> *hdev,
> +						=C2=A0=C2=A0 const u8 *data,
> int len)
> =C2=A0{
> -	int ret =3D 0;
> +	return steelseries_send_report(hdev, data, len,
> HID_FEATURE_REPORT);
> +}
> =C2=A0
> -	if (hdev->product =3D=3D USB_DEVICE_ID_STEELSERIES_ARCTIS_1 ||
> -	=C2=A0=C2=A0=C2=A0 hdev->product =3D=3D USB_DEVICE_ID_STEELSERIES_ARCTI=
S_1_X)
> -		ret =3D steelseries_headset_request_battery(hdev,
> -			arctis_1_battery_request,
> sizeof(arctis_1_battery_request));
> -	else if (hdev->product =3D=3D
> USB_DEVICE_ID_STEELSERIES_ARCTIS_9)
> -		ret =3D steelseries_headset_request_battery(hdev,
> -			arctis_9_battery_request,
> sizeof(arctis_9_battery_request));
> +static inline int steelseries_send_output_report(struct hid_device
> *hdev,
> +						=C2=A0 const u8 *data,
> int len)
> +{
> +	return steelseries_send_report(hdev, data, len,
> HID_OUTPUT_REPORT);
> +}
> =C2=A0
> -	if (ret < 0)
> -		hid_dbg(hdev,
> -			"Battery query failed (err: %d)\n", ret);
> +/*
> + * Headset status request functions
> + */
> +
> +static int steelseries_arctis_1_request_status(struct hid_device
> *hdev)
> +{
> +	const u8 data[] =3D { 0x06, 0x12 };
> +
> +	return steelseries_send_feature_report(hdev, data,
> sizeof(data));
> +}
> +
> +static int steelseries_arctis_7_request_status(struct hid_device
> *hdev)
> +{
> +	int ret;
> +	const u8 connection_data[] =3D { 0x06, 0x14 };
> +	const u8 battery_data[] =3D { 0x06, 0x18 };
> +
> +	ret =3D steelseries_send_feature_report(hdev, connection_data,
> sizeof(connection_data));
> +	if (ret)
> +		return ret;
> +
> +	msleep(10);
> +
> +	return steelseries_send_feature_report(hdev, battery_data,
> sizeof(battery_data));
> +}
> +
> +static int steelseries_arctis_9_request_status(struct hid_device
> *hdev)
> +{
> +	const u8 data[] =3D { 0x00, 0x20 };
> +
> +	return steelseries_send_feature_report(hdev, data,
> sizeof(data));
> =C2=A0}
> =C2=A0
> +static int steelseries_arctis_nova_request_status(struct hid_device
> *hdev)
> +{
> +	const u8 data[] =3D { 0x00, 0xb0 };
> +
> +	return steelseries_send_output_report(hdev, data,
> sizeof(data));
> +}
> +
> +static int steelseries_arctis_nova_3p_request_status(struct
> hid_device *hdev)
> +{
> +	const u8 data[] =3D { 0xb0 };
> +
> +	return steelseries_send_output_report(hdev, data,
> sizeof(data));
> +}
> +
> +static int steelseries_arctis_nova_pro_request_status(struct
> hid_device *hdev)
> +{
> +	const u8 data[] =3D { 0x06, 0xb0 };
> +
> +	return steelseries_send_output_report(hdev, data,
> sizeof(data));
> +}
> +
> +/*
> + * Headset battery helpers
> + */
> +
> =C2=A0static int battery_capacity_to_level(int capacity)
> =C2=A0{
> =C2=A0	if (capacity >=3D 50)
> @@ -397,19 +479,247 @@ static int battery_capacity_to_level(int
> capacity)
> =C2=A0	return POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
> =C2=A0}
> =C2=A0
> -static void steelseries_headset_battery_timer_tick(struct
> work_struct *work)
> +static u8 steelseries_map_capacity(u8 capacity, u8 min_in, u8
> max_in)
> +{
> +	if (capacity >=3D max_in)
> +		return 100;
> +	if (capacity <=3D min_in)
> +		return 0;
> +	return (capacity - min_in) * 100 / (max_in - min_in);
> +}
> +
> +/*
> + * Headset status parse functions
> + */
> +
> +static void steelseries_arctis_1_parse_status(struct
> steelseries_device *sd,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 *data, int size)
> +{
> +	if (size < 4)
> +		return;
> +
> +	sd->headset_connected =3D (data[2] !=3D 0x01);
> +	sd->battery_capacity =3D data[3];
> +}
> +
> +static void steelseries_arctis_7_parse_status(struct
> steelseries_device *sd,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 *data, int size)
> +{
> +	if (size < 3)
> +		return;
> +
> +	if (data[0] =3D=3D 0x06) {
> +		if (data[1] =3D=3D 0x14)
> +			sd->headset_connected =3D (data[2] =3D=3D 0x03);
> +		else if (data[1] =3D=3D 0x18)
> +			sd->battery_capacity =3D data[2];
> +	}
> +}
> +
> +static void steelseries_arctis_7_plus_parse_status(struct
> steelseries_device *sd,
> +						=C2=A0=C2=A0 u8 *data, int
> size)
> +{
> +	if (size < 4)
> +		return;
> +
> +	if (data[0] =3D=3D 0xb0) {
> +		sd->headset_connected =3D !(data[1] =3D=3D 0x01);
> +		sd->battery_capacity =3D
> steelseries_map_capacity(data[2], 0x00, 0x04);
> +		sd->battery_charging =3D (data[3] =3D=3D 0x01);
> +	}
> +}
> +
> +static void steelseries_arctis_9_parse_status(struct
> steelseries_device *sd,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 *data, int size)
> +{
> +	if (size < 5)
> +		return;
> +
> +	if (data[0] =3D=3D 0xaa) {
> +		sd->headset_connected =3D (data[1] =3D=3D 0x01);
> +		sd->battery_charging =3D (data[4] =3D=3D 0x01);
> +		sd->battery_capacity =3D
> steelseries_map_capacity(data[3], 0x64, 0x9A);
> +	}
> +}
> +
> +static void steelseries_arctis_nova_3p_parse_status(struct
> steelseries_device *sd,
> +						=C2=A0=C2=A0 u8 *data, int
> size)
> +{
> +	if (size < 4)
> +		return;
> +
> +	if (data[0] =3D=3D 0xb0) {
> +		sd->headset_connected =3D !(data[1] =3D=3D 0x02);
> +		sd->battery_capacity =3D
> steelseries_map_capacity(data[3], 0x00, 0x64);
> +	}
> +}
> +
> +static void steelseries_arctis_nova_5_parse_status(struct
> steelseries_device *sd,
> +						=C2=A0=C2=A0 u8 *data, int
> size)
> +{
> +	if (size < 5)
> +		return;
> +
> +	if (data[0] =3D=3D 0xb0) {
> +		sd->headset_connected =3D !(data[1] =3D=3D 0x02);
> +		sd->battery_capacity =3D data[3];
> +		sd->battery_charging =3D (data[4] =3D=3D 0x01);
> +	}
> +}
> +
> +static void steelseries_arctis_nova_7_parse_status(struct
> steelseries_device *sd,
> +						=C2=A0=C2=A0 u8 *data, int
> size)
> +{
> +	if (size < 4)
> +		return;
> +
> +	if (data[0] =3D=3D 0xb0) {
> +		sd->headset_connected =3D (data[1] =3D=3D 0x03);
> +		sd->battery_capacity =3D
> steelseries_map_capacity(data[2], 0x00, 0x04);
> +		sd->battery_charging =3D (data[3] =3D=3D 0x01);
> +	}
> +}
> +
> +static void steelseries_arctis_nova_7_gen2_parse_status(struct
> steelseries_device *sd,
> +							u8 *data,
> int size)
> +{
> +	if (size < 4)
> +		return;
> +
> +	switch (data[0]) {
> +	case 0xb0:
> +		sd->headset_connected =3D (data[1] =3D=3D 0x03);
> +		sd->battery_capacity =3D data[2];
> +		sd->battery_charging =3D (data[3] =3D=3D 0x01);
> +		break;
> +	case 0xb7:
> +		sd->battery_capacity =3D data[1];
> +		break;
> +	case 0xb9:
> +		sd->headset_connected =3D (data[1] =3D=3D 0x03);
> +		break;
> +	case 0xbb:
> +		sd->battery_charging =3D (data[1] =3D=3D 0x01);
> +		break;
> +	}
> +}
> +
> +static void steelseries_arctis_nova_pro_parse_status(struct
> steelseries_device *sd,
> +						=C2=A0=C2=A0=C2=A0=C2=A0 u8 *data, int
> size)
> +{
> +	if (size < 16)
> +		return;
> +
> +	if (data[0] =3D=3D 0x06 && data[1] =3D=3D 0xb0) {
> +		sd->headset_connected =3D (data[15] =3D=3D 0x08 ||
> data[15] =3D=3D 0x02);
> +		sd->battery_capacity =3D
> steelseries_map_capacity(data[6], 0x00, 0x08);
> +		sd->battery_charging =3D (data[15] =3D=3D 0x02);
> +	}
> +}
> +
> +/*
> + * Device info definitions
> + */
> +
> +static const struct steelseries_device_info srws1_info =3D { };
> +
> +static const struct steelseries_device_info arctis_1_info =3D {
> +	.sync_interface =3D 3,
> +	.capabilities =3D SS_CAP_BATTERY,
> +	.quirks =3D SS_QUIRK_STATUS_SYNC_POLL,
> +	.request_status =3D steelseries_arctis_1_request_status,
> +	.parse_status =3D steelseries_arctis_1_parse_status,
> +};
> +
> +static const struct steelseries_device_info arctis_7_info =3D {
> +	.sync_interface =3D 5,
> +	.capabilities =3D SS_CAP_BATTERY,
> +	.quirks =3D SS_QUIRK_STATUS_SYNC_POLL,
> +	.request_status =3D steelseries_arctis_7_request_status,
> +	.parse_status =3D steelseries_arctis_7_parse_status,
> +};
> +
> +static const struct steelseries_device_info arctis_7_plus_info =3D {
> +	.sync_interface =3D 3,
> +	.capabilities =3D SS_CAP_BATTERY,
> +	.quirks =3D SS_QUIRK_STATUS_SYNC_POLL,
> +	.request_status =3D steelseries_arctis_nova_request_status,
> +	.parse_status =3D steelseries_arctis_7_plus_parse_status,
> +};
> +
> +static const struct steelseries_device_info arctis_9_info =3D {
> +	.sync_interface =3D 0,
> +	.capabilities =3D SS_CAP_BATTERY,
> +	.quirks =3D SS_QUIRK_STATUS_SYNC_POLL,
> +	.request_status =3D steelseries_arctis_9_request_status,
> +	.parse_status =3D steelseries_arctis_9_parse_status,
> +};
> +
> +static const struct steelseries_device_info arctis_nova_3p_info =3D {
> +	.sync_interface =3D 4,
> +	.capabilities =3D SS_CAP_BATTERY,
> +	.quirks =3D SS_QUIRK_STATUS_SYNC_POLL,
> +	.request_status =3D steelseries_arctis_nova_3p_request_status,
> +	.parse_status =3D steelseries_arctis_nova_3p_parse_status,
> +};
> +
> +static const struct steelseries_device_info arctis_nova_5_info =3D {
> +	.sync_interface =3D 3,
> +	.capabilities =3D SS_CAP_BATTERY,
> +	.quirks =3D SS_QUIRK_STATUS_SYNC_POLL,
> +	.request_status =3D steelseries_arctis_nova_request_status,
> +	.parse_status =3D steelseries_arctis_nova_5_parse_status,
> +};
> +
> +static const struct steelseries_device_info arctis_nova_7_info =3D {
> +	.sync_interface =3D 3,
> +	.capabilities =3D SS_CAP_BATTERY,
> +	.quirks =3D SS_QUIRK_STATUS_SYNC_POLL,
> +	.request_status =3D steelseries_arctis_nova_request_status,
> +	.parse_status =3D steelseries_arctis_nova_7_parse_status,
> +};
> +
> +static const struct steelseries_device_info arctis_nova_7_gen2_info
> =3D {
> +	.sync_interface =3D 3,
> +	.async_interface =3D 5,
> +	.capabilities =3D SS_CAP_BATTERY,
> +	.request_status =3D steelseries_arctis_nova_request_status,
> +	.parse_status =3D steelseries_arctis_nova_7_gen2_parse_status,
> +};
> +
> +static const struct steelseries_device_info arctis_nova_pro_info =3D {
> +	.sync_interface =3D 4,
> +	.capabilities =3D SS_CAP_BATTERY,
> +	.quirks =3D SS_QUIRK_STATUS_SYNC_POLL,
> +	.request_status =3D
> steelseries_arctis_nova_pro_request_status,
> +	.parse_status =3D steelseries_arctis_nova_pro_parse_status,
> +};
> +
> +/*
> + * Headset wireless status and battery infrastructure
> + */
> +
> +#define STEELSERIES_HEADSET_STATUS_TIMEOUT_MS	3000
> +
> +static void
> +steelseries_headset_set_wireless_status(struct hid_device *hdev,
> +					bool connected)
> =C2=A0{
> -	struct steelseries_device *sd =3D container_of(work,
> -		struct steelseries_device, battery_work.work);
> -	struct hid_device *hdev =3D sd->hdev;
> +	struct usb_interface *intf;
> +
> +	if (!hid_is_usb(hdev))
> +		return;
> =C2=A0
> -	steelseries_headset_fetch_battery(hdev);
> +	intf =3D to_usb_interface(hdev->dev.parent);
> +	usb_set_wireless_status(intf, connected ?
> +				USB_WIRELESS_STATUS_CONNECTED :
> +				USB_WIRELESS_STATUS_DISCONNECTED);
> =C2=A0}
> =C2=A0
> =C2=A0#define STEELSERIES_PREFIX "SteelSeries "
> =C2=A0#define STEELSERIES_PREFIX_LEN strlen(STEELSERIES_PREFIX)
> =C2=A0
> -static int steelseries_headset_battery_get_property(struct
> power_supply *psy,
> +static int steelseries_battery_get_property(struct power_supply
> *psy,
> =C2=A0				enum power_supply_property psp,
> =C2=A0				union power_supply_propval *val)
> =C2=A0{
> @@ -452,22 +762,7 @@ static int
> steelseries_headset_battery_get_property(struct power_supply *psy,
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> -static void
> -steelseries_headset_set_wireless_status(struct hid_device *hdev,
> -					bool connected)
> -{
> -	struct usb_interface *intf;
> -
> -	if (!hid_is_usb(hdev))
> -		return;
> -
> -	intf =3D to_usb_interface(hdev->dev.parent);
> -	usb_set_wireless_status(intf, connected ?
> -				USB_WIRELESS_STATUS_CONNECTED :
> -				USB_WIRELESS_STATUS_DISCONNECTED);
> -}
> -
> -static enum power_supply_property
> steelseries_headset_battery_props[] =3D {
> +static enum power_supply_property steelseries_battery_props[] =3D {
> =C2=A0	POWER_SUPPLY_PROP_MODEL_NAME,
> =C2=A0	POWER_SUPPLY_PROP_MANUFACTURER,
> =C2=A0	POWER_SUPPLY_PROP_PRESENT,
> @@ -477,7 +772,26 @@ static enum power_supply_property
> steelseries_headset_battery_props[] =3D {
> =C2=A0	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
> =C2=A0};
> =C2=A0
> -static int steelseries_headset_battery_register(struct
> steelseries_device *sd)
> +/*
> + * Delayed work handlers for status polling and settings requests
> + */
> +
> +static void steelseries_status_timer_work_handler(struct work_struct
> *work)
> +{
> +	struct steelseries_device *sd =3D container_of(
> +		work, struct steelseries_device, status_work.work);
> +	unsigned long flags;
> +
> +	sd->info->request_status(sd->hdev);
> +
> +	spin_lock_irqsave(&sd->lock, flags);
> +	if (!sd->removed && !sd->use_async_protocol)
> +		schedule_delayed_work(&sd->status_work,
> +				msecs_to_jiffies(STEELSERIES_HEADSET
> _STATUS_TIMEOUT_MS));
> +	spin_unlock_irqrestore(&sd->lock, flags);
> +}
> +
> +static int steelseries_battery_register(struct steelseries_device
> *sd)
> =C2=A0{
> =C2=A0	static atomic_t battery_no =3D ATOMIC_INIT(0);
> =C2=A0	struct power_supply_config battery_cfg =3D { .drv_data =3D sd,
> };
> @@ -485,9 +799,9 @@ static int
> steelseries_headset_battery_register(struct steelseries_device *sd)
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	sd->battery_desc.type =3D POWER_SUPPLY_TYPE_BATTERY;
> -	sd->battery_desc.properties =3D
> steelseries_headset_battery_props;
> -	sd->battery_desc.num_properties =3D
> ARRAY_SIZE(steelseries_headset_battery_props);
> -	sd->battery_desc.get_property =3D
> steelseries_headset_battery_get_property;
> +	sd->battery_desc.properties =3D steelseries_battery_props;
> +	sd->battery_desc.num_properties =3D
> ARRAY_SIZE(steelseries_battery_props);
> +	sd->battery_desc.get_property =3D
> steelseries_battery_get_property;
> =C2=A0	sd->battery_desc.use_for_apm =3D 0;
> =C2=A0	n =3D atomic_inc_return(&battery_no) - 1;
> =C2=A0	sd->battery_desc.name =3D devm_kasprintf(&sd->hdev->dev,
> GFP_KERNEL,
> @@ -496,14 +810,16 @@ static int
> steelseries_headset_battery_register(struct steelseries_device *sd)
> =C2=A0		return -ENOMEM;
> =C2=A0
> =C2=A0	/* avoid the warning of 0% battery while waiting for the
> first info */
> -	steelseries_headset_set_wireless_status(sd->hdev, false);
> =C2=A0	sd->battery_capacity =3D 100;
> =C2=A0	sd->battery_charging =3D false;
> +	sd->headset_connected =3D false;
> +	steelseries_headset_set_wireless_status(sd->hdev, false);
> =C2=A0
> =C2=A0	sd->battery =3D devm_power_supply_register(&sd->hdev->dev,
> =C2=A0			&sd->battery_desc, &battery_cfg);
> =C2=A0	if (IS_ERR(sd->battery)) {
> =C2=A0		ret =3D PTR_ERR(sd->battery);
> +		sd->battery =3D NULL;
> =C2=A0		hid_err(sd->hdev,
> =C2=A0				"%s:power_supply_register failed
> with error %d\n",
> =C2=A0				__func__, ret);
> @@ -511,68 +827,185 @@ static int
> steelseries_headset_battery_register(struct steelseries_device *sd)
> =C2=A0	}
> =C2=A0	power_supply_powers(sd->battery, &sd->hdev->dev);
> =C2=A0
> -	INIT_DELAYED_WORK(&sd->battery_work,
> steelseries_headset_battery_timer_tick);
> -	steelseries_headset_fetch_battery(sd->hdev);
> +	return 0;
> +}
> +
> +static int steelseries_raw_event(struct hid_device *hdev,
> +				 struct hid_report *report, u8
> *data, int size)
> +{
> +	struct steelseries_device *sd =3D hid_get_drvdata(hdev);
> +	u8 old_capacity;
> +	bool old_connected;
> +	bool old_charging;
> +	bool is_async_interface =3D false;
> +
> +	if (hdev->product =3D=3D USB_DEVICE_ID_STEELSERIES_SRWS1)
> +		return 0;
> +
> +	if (!sd)
> +		return 0;
> +
> +	old_capacity =3D sd->battery_capacity;
> +	old_connected =3D sd->headset_connected;
> +	old_charging =3D sd->battery_charging;
> +
> +	if (hid_is_usb(hdev)) {
> +		struct usb_interface *intf =3D to_usb_interface(hdev-
> >dev.parent);
> +
> +		is_async_interface =3D (intf->cur_altsetting-
> >desc.bInterfaceNumber =3D=3D
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sd->info->async_interface);
> +	}
> +
> +	sd->info->parse_status(sd, data, size);
> +
> +	if (sd->headset_connected !=3D old_connected) {
> +		hid_dbg(hdev,
> +			"Connected status changed from %sconnected
> to %sconnected\n",
> +			old_connected ? "" : "not ",
> +			sd->headset_connected ? "" : "not ");
> +
> +		if (sd->headset_connected && !old_connected &&
> +		=C2=A0=C2=A0=C2=A0 sd->use_async_protocol && is_async_interface) {
> +			schedule_delayed_work(&sd->status_work, 0);
> +		}
> =C2=A0
> -	if (sd->quirks & STEELSERIES_ARCTIS_9) {
> -		/* The first fetch_battery request can remain
> unanswered in some cases */
> -		schedule_delayed_work(&sd->battery_work,
> -
> 				msecs_to_jiffies(STEELSERIES_HEADSET_BATTERY_TIMEOUT_MS));
> +		if (sd->battery) {
> +			steelseries_headset_set_wireless_status(sd-
> >hdev,
> +							=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sd-
> >headset_connected);
> +			power_supply_changed(sd->battery);
> +		}
> +	}
> +
> +	if (sd->battery_capacity !=3D old_capacity) {
> +		hid_dbg(hdev, "Battery capacity changed from %d%% to
> %d%%\n",
> +			old_capacity, sd->battery_capacity);
> +		if (sd->battery)
> +			power_supply_changed(sd->battery);
> +	}
> +
> +	if (sd->battery_charging !=3D old_charging) {
> +		hid_dbg(hdev,
> +			"Battery charging status changed from
> %scharging to %scharging\n",
> +			old_charging ? "" : "not ",
> +			sd->battery_charging ? "" : "not ");
> +		if (sd->battery)
> +			power_supply_changed(sd->battery);
> =C2=A0	}
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> -static bool steelseries_is_vendor_usage_page(struct hid_device
> *hdev, uint8_t usage_page)
> +static struct hid_device *steelseries_get_sibling_hdev(struct
> hid_device *hdev,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int
> interface_num)
> =C2=A0{
> -	return hdev->rdesc[0] =3D=3D 0x06 &&
> -		hdev->rdesc[1] =3D=3D usage_page &&
> -		hdev->rdesc[2] =3D=3D 0xff;
> +	struct usb_interface *intf =3D to_usb_interface(hdev-
> >dev.parent);
> +	struct usb_device *usb_dev =3D interface_to_usbdev(intf);
> +	struct usb_interface *sibling_intf;
> +	struct hid_device *sibling_hdev;
> +
> +	sibling_intf =3D usb_ifnum_to_if(usb_dev, interface_num);
> +	if (!sibling_intf)
> +		return NULL;
> +
> +	sibling_hdev =3D usb_get_intfdata(sibling_intf);
> +
> +	return sibling_hdev;
> =C2=A0}
> =C2=A0
> -static int steelseries_probe(struct hid_device *hdev, const struct
> hid_device_id *id)
> +static int steelseries_probe(struct hid_device *hdev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 const struct hid_device_id *id)
> =C2=A0{
> +	const struct steelseries_device_info *info =3D
> +		(const struct steelseries_device_info *)id-
> >driver_data;
> =C2=A0	struct steelseries_device *sd;
> +	struct usb_interface *intf;
> +	struct hid_device *master_hdev;
> +	u8 interface_num;
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	if (hdev->product =3D=3D USB_DEVICE_ID_STEELSERIES_SRWS1) {
> =C2=A0#if IS_BUILTIN(CONFIG_LEDS_CLASS) || \
> -=C2=A0=C2=A0=C2=A0 (IS_MODULE(CONFIG_LEDS_CLASS) &&
> IS_MODULE(CONFIG_HID_STEELSERIES))
> +	(IS_MODULE(CONFIG_LEDS_CLASS) &&
> IS_MODULE(CONFIG_HID_STEELSERIES))
> =C2=A0		return steelseries_srws1_probe(hdev, id);
> =C2=A0#else
> =C2=A0		return -ENODEV;
> =C2=A0#endif
> =C2=A0	}
> =C2=A0
> -	sd =3D devm_kzalloc(&hdev->dev, sizeof(*sd), GFP_KERNEL);
> -	if (!sd)
> -		return -ENOMEM;
> -	hid_set_drvdata(hdev, sd);
> -	sd->hdev =3D hdev;
> -	sd->quirks =3D id->driver_data;
> +	if (hid_is_usb(hdev)) {
> +		intf =3D to_usb_interface(hdev->dev.parent);
> +		interface_num =3D intf->cur_altsetting-
> >desc.bInterfaceNumber;
> +	} else {
> +		return -ENODEV;
> +	}
> =C2=A0
> =C2=A0	ret =3D hid_parse(hdev);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	if (sd->quirks & STEELSERIES_ARCTIS_9 &&
> -			!steelseries_is_vendor_usage_page(hdev,
> 0xc0))
> -		return -ENODEV;
> +	/* Let hid-generic handle non-vendor or unknown interfaces
> */
> +	if (interface_num !=3D info->sync_interface &&
> +	=C2=A0=C2=A0=C2=A0 (!info->async_interface || interface_num !=3D info-
> >async_interface))
> +		return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> =C2=A0
> -	spin_lock_init(&sd->lock);
> +	if (interface_num =3D=3D info->sync_interface) {
> +		sd =3D devm_kzalloc(&hdev->dev, sizeof(*sd),
> GFP_KERNEL);
> +		if (!sd)
> +			return -ENOMEM;
> =C2=A0
> -	ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> -	if (ret)
> -		return ret;
> +		sd->hdev =3D hdev;
> +		sd->info =3D info;
> +		spin_lock_init(&sd->lock);
> =C2=A0
> -	ret =3D hid_hw_open(hdev);
> -	if (ret)
> -		return ret;
> +		hid_set_drvdata(hdev, sd);
> =C2=A0
> -	if (steelseries_headset_battery_register(sd) < 0)
> -		hid_err(sd->hdev,
> -			"Failed to register battery for headset\n");
> +		ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D hid_hw_open(hdev);
> +		if (ret)
> +			goto err_stop;
> +
> +		sd->use_async_protocol =3D !(info->quirks &
> SS_QUIRK_STATUS_SYNC_POLL);
> +
> +		if (info->capabilities & SS_CAP_BATTERY) {
> +			ret =3D steelseries_battery_register(sd);
> +			if (ret < 0)
> +				hid_warn(hdev, "Failed to register
> battery: %d\n", ret);
> +		}
> +
> +		INIT_DELAYED_WORK(&sd->status_work,
> steelseries_status_timer_work_handler);
> +		schedule_delayed_work(&sd->status_work,
> msecs_to_jiffies(100));
> +
> +		return 0;
> +	}
> +
> +	if (info->async_interface && interface_num =3D=3D info-
> >async_interface) {
> +		master_hdev =3D steelseries_get_sibling_hdev(hdev,
> info->sync_interface);
> =C2=A0
> +		if (!master_hdev || !hid_get_drvdata(master_hdev))
> +			return -EPROBE_DEFER;
> +
> +		sd =3D hid_get_drvdata(master_hdev);
> +		hid_set_drvdata(hdev, sd);
> +
> +		ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D hid_hw_open(hdev);
> +		if (ret) {
> +			hid_hw_stop(hdev);
> +			return ret;
> +		}
> +		return 0;
> +	}
> +
> +	return -ENODEV;
> +
> +err_stop:
> +	hid_hw_stop(hdev);
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> @@ -580,166 +1013,144 @@ static void steelseries_remove(struct
> hid_device *hdev)
> =C2=A0{
> =C2=A0	struct steelseries_device *sd;
> =C2=A0	unsigned long flags;
> +	struct usb_interface *intf;
> +	u8 interface_num;
> =C2=A0
> =C2=A0	if (hdev->product =3D=3D USB_DEVICE_ID_STEELSERIES_SRWS1) {
> =C2=A0#if IS_BUILTIN(CONFIG_LEDS_CLASS) || \
> -=C2=A0=C2=A0=C2=A0 (IS_MODULE(CONFIG_LEDS_CLASS) &&
> IS_MODULE(CONFIG_HID_STEELSERIES))
> +	(IS_MODULE(CONFIG_LEDS_CLASS) &&
> IS_MODULE(CONFIG_HID_STEELSERIES))
> =C2=A0		hid_hw_stop(hdev);
> =C2=A0#endif
> =C2=A0		return;
> =C2=A0	}
> =C2=A0
> -	sd =3D hid_get_drvdata(hdev);
> -
> -	spin_lock_irqsave(&sd->lock, flags);
> -	sd->removed =3D true;
> -	spin_unlock_irqrestore(&sd->lock, flags);
> -
> -	cancel_delayed_work_sync(&sd->battery_work);
> -
> -	hid_hw_close(hdev);
> -	hid_hw_stop(hdev);
> -}
> -
> -static const __u8 *steelseries_srws1_report_fixup(struct hid_device
> *hdev,
> -		__u8 *rdesc, unsigned int *rsize)
> -{
> -	if (hdev->vendor !=3D USB_VENDOR_ID_STEELSERIES ||
> -	=C2=A0=C2=A0=C2=A0 hdev->product !=3D USB_DEVICE_ID_STEELSERIES_SRWS1)
> -		return rdesc;
> -
> -	if (*rsize >=3D 115 && rdesc[11] =3D=3D 0x02 && rdesc[13] =3D=3D 0xc8
> -			&& rdesc[29] =3D=3D 0xbb && rdesc[40] =3D=3D 0xc5) {
> -		hid_info(hdev, "Fixing up Steelseries SRW-S1 report
> descriptor\n");
> -		*rsize =3D sizeof(steelseries_srws1_rdesc_fixed);
> -		return steelseries_srws1_rdesc_fixed;
> +	if (hid_is_usb(hdev)) {
> +		intf =3D to_usb_interface(hdev->dev.parent);
> +		interface_num =3D intf->cur_altsetting-
> >desc.bInterfaceNumber;
> +	} else {
> +		return;
> =C2=A0	}
> -	return rdesc;
> -}
> =C2=A0
> -static uint8_t steelseries_headset_map_capacity(uint8_t capacity,
> uint8_t min_in, uint8_t max_in)
> -{
> -	if (capacity >=3D max_in)
> -		return 100;
> -	if (capacity <=3D min_in)
> -		return 0;
> -	return (capacity - min_in) * 100 / (max_in - min_in);
> -}
> -
> -static int steelseries_headset_raw_event(struct hid_device *hdev,
> -					struct hid_report *report,
> u8 *read_buf,
> -					int size)
> -{
> -	struct steelseries_device *sd =3D hid_get_drvdata(hdev);
> -	int capacity =3D sd->battery_capacity;
> -	bool connected =3D sd->headset_connected;
> -	bool charging =3D sd->battery_charging;
> -	unsigned long flags;
> -
> -	/* Not a headset */
> -	if (hdev->product =3D=3D USB_DEVICE_ID_STEELSERIES_SRWS1)
> -		return 0;
> +	sd =3D hid_get_drvdata(hdev);
> =C2=A0
> -	if (hdev->product =3D=3D USB_DEVICE_ID_STEELSERIES_ARCTIS_1 ||
> -	=C2=A0=C2=A0=C2=A0 hdev->product =3D=3D USB_DEVICE_ID_STEELSERIES_ARCTI=
S_1_X) {
> -		hid_dbg(sd->hdev,
> -			"Parsing raw event for Arctis 1 headset
> (%*ph)\n", size, read_buf);
> -		if (size < ARCTIS_1_BATTERY_RESPONSE_LEN ||
> -		=C2=A0=C2=A0=C2=A0 memcmp(read_buf, arctis_1_battery_request,
> sizeof(arctis_1_battery_request))) {
> -			if (!delayed_work_pending(&sd-
> >battery_work))
> -				goto request_battery;
> -			return 0;
> -		}
> -		if (read_buf[2] =3D=3D 0x01) {
> -			connected =3D false;
> -			capacity =3D 100;
> -		} else {
> -			connected =3D true;
> -			capacity =3D read_buf[3];
> -		}
> +	if (!sd) {
> +		hid_hw_stop(hdev);
> +		return;
> =C2=A0	}
> =C2=A0
> -	if (hdev->product =3D=3D USB_DEVICE_ID_STEELSERIES_ARCTIS_9) {
> -		hid_dbg(sd->hdev,
> -			"Parsing raw event for Arctis 9 headset
> (%*ph)\n", size, read_buf);
> -		if (size < ARCTIS_9_BATTERY_RESPONSE_LEN) {
> -			if (!delayed_work_pending(&sd-
> >battery_work))
> -				goto request_battery;
> -			return 0;
> -		}
> +	if (interface_num =3D=3D sd->info->sync_interface) {
> +		if (sd->info->async_interface) {
> +			struct hid_device *sibling;
> =C2=A0
> -		if (read_buf[0] =3D=3D 0xaa && read_buf[1] =3D=3D 0x01) {
> -			connected =3D true;
> -			charging =3D read_buf[4] =3D=3D 0x01;
> -
> -			/*
> -			 * Found no official documentation about min
> and max.
> -			 * Values defined by testing.
> -			 */
> -			capacity =3D
> steelseries_headset_map_capacity(read_buf[3], 0x68, 0x9d);
> -		} else {
> -			/*
> -			 * Device is off and sends the last known
> status read_buf[1] =3D=3D 0x03 or
> -			 * there is no known status of the device
> read_buf[0] =3D=3D 0x55
> -			 */
> -			connected =3D false;
> -			charging =3D false;
> +			sibling =3D steelseries_get_sibling_hdev(hdev,
> +							=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sd-
> >info->async_interface);
> +			if (sibling)
> +				hid_set_drvdata(sibling, NULL);
> =C2=A0		}
> -	}
> =C2=A0
> -	if (connected !=3D sd->headset_connected) {
> -		hid_dbg(sd->hdev,
> -			"Connected status changed from %sconnected
> to %sconnected\n",
> -			sd->headset_connected ? "" : "not ",
> -			connected ? "" : "not ");
> -		sd->headset_connected =3D connected;
> -		steelseries_headset_set_wireless_status(hdev,
> connected);
> -	}
> +		spin_lock_irqsave(&sd->lock, flags);
> +		sd->removed =3D true;
> +		spin_unlock_irqrestore(&sd->lock, flags);
> =C2=A0
> -	if (capacity !=3D sd->battery_capacity) {
> -		hid_dbg(sd->hdev,
> -			"Battery capacity changed from %d%% to
> %d%%\n",
> -			sd->battery_capacity, capacity);
> -		sd->battery_capacity =3D capacity;
> -		power_supply_changed(sd->battery);
> -	}
> -
> -	if (charging !=3D sd->battery_charging) {
> -		hid_dbg(sd->hdev,
> -			"Battery charging status changed from
> %scharging to %scharging\n",
> -			sd->battery_charging ? "" : "not ",
> -			charging ? "" : "not ");
> -		sd->battery_charging =3D charging;
> -		power_supply_changed(sd->battery);
> +		cancel_delayed_work_sync(&sd->status_work);
> =C2=A0	}
> =C2=A0
> -request_battery:
> -	spin_lock_irqsave(&sd->lock, flags);
> -	if (!sd->removed)
> -		schedule_delayed_work(&sd->battery_work,
> -
> 				msecs_to_jiffies(STEELSERIES_HEADSET_BATTERY_TIMEOUT_MS));
> -	spin_unlock_irqrestore(&sd->lock, flags);
> -
> -	return 0;
> +	hid_hw_close(hdev);
> +	hid_hw_stop(hdev);
> =C2=A0}
> =C2=A0
> =C2=A0static const struct hid_device_id steelseries_devices[] =3D {
> -	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> USB_DEVICE_ID_STEELSERIES_SRWS1),
> -	=C2=A0 .driver_data =3D STEELSERIES_SRWS1 },
> -
> -	{ /* SteelSeries Arctis 1 Wireless */
> -	=C2=A0 HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> USB_DEVICE_ID_STEELSERIES_ARCTIS_1),
> -	=C2=A0 .driver_data =3D STEELSERIES_ARCTIS_1 },
> -
> -	{ /* SteelSeries Arctis 1 Wireless for XBox */
> -	=C2=A0 HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X),
> -	=C2=A0 .driver_data =3D STEELSERIES_ARCTIS_1_X },
> -
> -	{ /* SteelSeries Arctis 9 Wireless for XBox */
> -	=C2=A0 HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> USB_DEVICE_ID_STEELSERIES_ARCTIS_9),
> -	=C2=A0 .driver_data =3D STEELSERIES_ARCTIS_9 },
> -
> -	{ }
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> +			 USB_DEVICE_ID_STEELSERIES_SRWS1),
> +	=C2=A0 .driver_data =3D (unsigned long)&srws1_info },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> +			 USB_DEVICE_ID_STEELSERIES_ARCTIS_1),
> +	=C2=A0 .driver_data =3D (unsigned long)&arctis_1_info },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> +			 USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X),
> +	=C2=A0 .driver_data =3D (unsigned long)&arctis_1_info },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> +			 USB_DEVICE_ID_STEELSERIES_ARCTIS_7),
> +	=C2=A0 .driver_data =3D (unsigned long)&arctis_7_info },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> +			 USB_DEVICE_ID_STEELSERIES_ARCTIS_7_P),
> +	=C2=A0 .driver_data =3D (unsigned long)&arctis_1_info },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> +			 USB_DEVICE_ID_STEELSERIES_ARCTIS_7_X),
> +	=C2=A0 .driver_data =3D (unsigned long)&arctis_1_info },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> +			 USB_DEVICE_ID_STEELSERIES_ARCTIS_7_GEN2),
> +	=C2=A0 .driver_data =3D (unsigned long)&arctis_7_info },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> +			 USB_DEVICE_ID_STEELSERIES_ARCTIS_7_PLUS),
> +	=C2=A0 .driver_data =3D (unsigned long)&arctis_7_plus_info },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> +			 USB_DEVICE_ID_STEELSERIES_ARCTIS_7_PLUS_P),
> +	=C2=A0 .driver_data =3D (unsigned long)&arctis_7_plus_info },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> +			 USB_DEVICE_ID_STEELSERIES_ARCTIS_7_PLUS_X),
> +	=C2=A0 .driver_data =3D (unsigned long)&arctis_7_plus_info },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> +		=09
> USB_DEVICE_ID_STEELSERIES_ARCTIS_7_PLUS_DESTINY),
> +	=C2=A0 .driver_data =3D (unsigned long)&arctis_7_plus_info },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> +			 USB_DEVICE_ID_STEELSERIES_ARCTIS_9),
> +	=C2=A0 .driver_data =3D (unsigned long)&arctis_9_info },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> +			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_3_P),
> +	=C2=A0 .driver_data =3D (unsigned long)&arctis_nova_3p_info },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> +			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_3_X),
> +	=C2=A0 .driver_data =3D (unsigned long)&arctis_nova_3p_info },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> +			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_5),
> +	=C2=A0 .driver_data =3D (unsigned long)&arctis_nova_5_info },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> +			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_5_X),
> +	=C2=A0 .driver_data =3D (unsigned long)&arctis_nova_5_info },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> +			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7),
> +	=C2=A0 .driver_data =3D (unsigned long)&arctis_nova_7_info },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> +			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_2),
> +	=C2=A0 .driver_data =3D (unsigned long)&arctis_nova_7_gen2_info },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> +			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_P),
> +	=C2=A0 .driver_data =3D (unsigned long)&arctis_nova_7_info },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> +			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X),
> +	=C2=A0 .driver_data =3D (unsigned long)&arctis_nova_7_info },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> +		=09
> USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_2),
> +	=C2=A0 .driver_data =3D (unsigned long)&arctis_nova_7_info },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> +		=09
> USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_3),
> +	=C2=A0 .driver_data =3D (unsigned long)&arctis_nova_7_gen2_info },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> +		=09
> USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_DIABLO),
> +	=C2=A0 .driver_data =3D (unsigned long)&arctis_nova_7_info },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> +		=09
> USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_DIABLO_2),
> +	=C2=A0 .driver_data =3D (unsigned long)&arctis_nova_7_gen2_info },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> +		=09
> USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_WOW),
> +	=C2=A0 .driver_data =3D (unsigned long)&arctis_nova_7_info },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> +		=09
> USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_GEN2),
> +	=C2=A0 .driver_data =3D (unsigned long)&arctis_nova_7_gen2_info },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> +		=09
> USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_GEN2),
> +	=C2=A0 .driver_data =3D (unsigned long)&arctis_nova_7_gen2_info },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> +		=09
> USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_GEN2_2),
> +	=C2=A0 .driver_data =3D (unsigned long)&arctis_nova_7_gen2_info },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> +			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_PRO),
> +	=C2=A0 .driver_data =3D (unsigned long)&arctis_nova_pro_info },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> +		=09
> USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_PRO_X),
> +	=C2=A0 .driver_data =3D (unsigned long)&arctis_nova_pro_info },
> +	{}
> =C2=A0};
> =C2=A0MODULE_DEVICE_TABLE(hid, steelseries_devices);
> =C2=A0
> @@ -749,7 +1160,7 @@ static struct hid_driver steelseries_driver =3D {
> =C2=A0	.probe =3D steelseries_probe,
> =C2=A0	.remove =3D steelseries_remove,
> =C2=A0	.report_fixup =3D steelseries_srws1_report_fixup,
> -	.raw_event =3D steelseries_headset_raw_event,
> +	.raw_event =3D steelseries_raw_event,
> =C2=A0};
> =C2=A0
> =C2=A0module_hid_driver(steelseries_driver);
> @@ -758,3 +1169,4 @@ MODULE_LICENSE("GPL");
> =C2=A0MODULE_AUTHOR("Bastien Nocera <hadess@hadess.net>");
> =C2=A0MODULE_AUTHOR("Simon Wood <simon@mungewell.org>");
> =C2=A0MODULE_AUTHOR("Christian Mayer <git@mayer-bgk.de>");
> +MODULE_AUTHOR("Sriman Achanta <srimanachanta@gmail.com>");
