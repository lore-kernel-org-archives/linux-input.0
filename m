From: "Colenbrander, Roelof" <Roderick.Colenbrander@sony.com>
Subject: Re: [PATCH] HID: sony: Report DS4 version info through sysfs
Date: Fri, 19 Jan 2018 22:20:47 +0000
Message-ID: <1DD62093774CEE42AFC16E785A1088049E25D48A@USCULXMSG13.am.sony.com>
References: <20171219190443.52950-1-roderick@gaikai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-dm3nam03on0108.outbound.protection.outlook.com ([104.47.41.108]:61770
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756492AbeASWUx (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 Jan 2018 17:20:53 -0500
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "roderick@gaikai.com" <roderick@gaikai.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>

Hi all,=0A=
=0A=
Any thoughts on this patch?=0A=
=0A=
Thanks,=0A=
Roderick=0A=
=0A=
On 12/19/2017 11:05 AM, Roderick Colenbrander wrote:=0A=
> From: Roderick Colenbrander <roderick.colenbrander@sony.com>=0A=
> =0A=
> Report DS4 firmware and hardware version through sysfs for both=0A=
> USB and Bluetooth. This information is important for userspace=0A=
> in particular for device specific quirks (e.g. in Bluetooth stacks).=0A=
> =0A=
> Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>=0A=
> ---=0A=
>   drivers/hid/hid-sony.c | 83 +++++++++++++++++++++++++++++++++++++++++++=
+++++++=0A=
>   1 file changed, 83 insertions(+)=0A=
> =0A=
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c=0A=
> index b9dc3ac4d4aa..432d9a47cab0 100644=0A=
> --- a/drivers/hid/hid-sony.c=0A=
> +++ b/drivers/hid/hid-sony.c=0A=
> @@ -473,6 +473,7 @@ struct motion_output_report_02 {=0A=
>   #define DS4_FEATURE_REPORT_0x02_SIZE 37=0A=
>   #define DS4_FEATURE_REPORT_0x05_SIZE 41=0A=
>   #define DS4_FEATURE_REPORT_0x81_SIZE 7=0A=
> +#define DS4_FEATURE_REPORT_0xA3_SIZE 49=0A=
>   #define DS4_INPUT_REPORT_0x11_SIZE 78=0A=
>   #define DS4_OUTPUT_REPORT_0x05_SIZE 32=0A=
>   #define DS4_OUTPUT_REPORT_0x11_SIZE 78=0A=
> @@ -544,6 +545,8 @@ struct sony_sc {=0A=
>   	struct power_supply *battery;=0A=
>   	struct power_supply_desc battery_desc;=0A=
>   	int device_id;=0A=
> +	unsigned fw_version;=0A=
> +	unsigned hw_version;=0A=
>   	u8 *output_report_dmabuf;=0A=
>   =0A=
>   #ifdef CONFIG_SONY_FF=0A=
> @@ -627,6 +630,29 @@ static ssize_t ds4_store_poll_interval(struct device=
 *dev,=0A=
>   static DEVICE_ATTR(bt_poll_interval, 0644, ds4_show_poll_interval,=0A=
>   		ds4_store_poll_interval);=0A=
>   =0A=
> +static ssize_t sony_show_firmware_version(struct device *dev,=0A=
> +				struct device_attribute=0A=
> +				*attr, char *buf)=0A=
> +{=0A=
> +	struct hid_device *hdev =3D to_hid_device(dev);=0A=
> +	struct sony_sc *sc =3D hid_get_drvdata(hdev);=0A=
> +=0A=
> +	return snprintf(buf, PAGE_SIZE, "0x%04x\n", sc->fw_version);=0A=
> +}=0A=
> +=0A=
> +static DEVICE_ATTR(firmware_version, 0444, sony_show_firmware_version, N=
ULL);=0A=
> +=0A=
> +static ssize_t sony_show_hardware_version(struct device *dev,=0A=
> +				struct device_attribute=0A=
> +				*attr, char *buf)=0A=
> +{=0A=
> +	struct hid_device *hdev =3D to_hid_device(dev);=0A=
> +	struct sony_sc *sc =3D hid_get_drvdata(hdev);=0A=
> +=0A=
> +	return snprintf(buf, PAGE_SIZE, "0x%04x\n", sc->hw_version);=0A=
> +}=0A=
> +=0A=
> +static DEVICE_ATTR(hardware_version, 0444, sony_show_hardware_version, N=
ULL);=0A=
>   =0A=
>   static u8 *motion_fixup(struct hid_device *hdev, u8 *rdesc,=0A=
>   			     unsigned int *rsize)=0A=
> @@ -1646,6 +1672,31 @@ static void dualshock4_calibration_work(struct wor=
k_struct *work)=0A=
>   	spin_unlock_irqrestore(&sc->lock, flags);=0A=
>   }=0A=
>   =0A=
> +static int dualshock4_get_version_info(struct sony_sc *sc)=0A=
> +{=0A=
> +	u8 *buf;=0A=
> +	int ret;=0A=
> +=0A=
> +	buf =3D kmalloc(DS4_FEATURE_REPORT_0xA3_SIZE, GFP_KERNEL);=0A=
> +	if (!buf)=0A=
> +		return -ENOMEM;=0A=
> +=0A=
> +	ret =3D hid_hw_raw_request(sc->hdev, 0xA3, buf,=0A=
> +				 DS4_FEATURE_REPORT_0xA3_SIZE,=0A=
> +				 HID_FEATURE_REPORT,=0A=
> +				 HID_REQ_GET_REPORT);=0A=
> +	if (ret < 0) {=0A=
> +		kfree(buf);=0A=
> +		return ret;=0A=
> +	}=0A=
> +=0A=
> +	sc->hw_version =3D get_unaligned_le16(&buf[35]);=0A=
> +	sc->fw_version =3D get_unaligned_le16(&buf[41]);=0A=
> +=0A=
> +	kfree(buf);=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
>   static void sixaxis_set_leds_from_id(struct sony_sc *sc)=0A=
>   {=0A=
>   	static const u8 sixaxis_leds[10][4] =3D {=0A=
> @@ -2619,6 +2670,28 @@ static int sony_input_configured(struct hid_device=
 *hdev,=0A=
>   			goto err_stop;=0A=
>   		}=0A=
>   =0A=
> +		ret =3D dualshock4_get_version_info(sc);=0A=
> +		if (ret < 0) {=0A=
> +			hid_err(sc->hdev, "Failed to get version data from Dualshock 4\n");=
=0A=
> +			goto err_stop;=0A=
> +		}=0A=
> +=0A=
> +		ret =3D device_create_file(&sc->hdev->dev, &dev_attr_firmware_version)=
;=0A=
> +		if (ret) {=0A=
> +			/* Make zero for cleanup reasons of sysfs entries. */=0A=
> +			sc->fw_version =3D 0;=0A=
> +			sc->hw_version =3D 0;=0A=
> +			hid_err(sc->hdev, "can't create sysfs firmware_version attribute err:=
 %d\n", ret);=0A=
> +			goto err_stop;=0A=
> +		}=0A=
> +=0A=
> +		ret =3D device_create_file(&sc->hdev->dev, &dev_attr_hardware_version)=
;=0A=
> +		if (ret) {=0A=
> +			sc->hw_version =3D 0;=0A=
> +			hid_err(sc->hdev, "can't create sysfs hardware_version attribute err:=
 %d\n", ret);=0A=
> +			goto err_stop;=0A=
> +		}=0A=
> +=0A=
>   		/*=0A=
>   		 * The Dualshock 4 touchpad supports 2 touches and has a=0A=
>   		 * resolution of 1920x942 (44.86 dots/mm).=0A=
> @@ -2695,6 +2768,10 @@ static int sony_input_configured(struct hid_device=
 *hdev,=0A=
>   	 */=0A=
>   	if (sc->ds4_bt_poll_interval)=0A=
>   		device_remove_file(&sc->hdev->dev, &dev_attr_bt_poll_interval);=0A=
> +	if (sc->fw_version)=0A=
> +		device_remove_file(&sc->hdev->dev, &dev_attr_firmware_version);=0A=
> +	if (sc->hw_version)=0A=
> +		device_remove_file(&sc->hdev->dev, &dev_attr_hardware_version);=0A=
>   	if (sc->quirks & SONY_LED_SUPPORT)=0A=
>   		sony_leds_remove(sc);=0A=
>   	if (sc->quirks & SONY_BATTERY_SUPPORT)=0A=
> @@ -2796,6 +2873,12 @@ static void sony_remove(struct hid_device *hdev)=
=0A=
>   	if (sc->quirks & DUALSHOCK4_CONTROLLER_BT)=0A=
>   		device_remove_file(&sc->hdev->dev, &dev_attr_bt_poll_interval);=0A=
>   =0A=
> +	if (sc->fw_version)=0A=
> +		device_remove_file(&sc->hdev->dev, &dev_attr_firmware_version);=0A=
> +=0A=
> +	if (sc->hw_version)=0A=
> +		device_remove_file(&sc->hdev->dev, &dev_attr_hardware_version);=0A=
> +=0A=
>   	sony_cancel_work_sync(sc);=0A=
>   =0A=
>   	kfree(sc->output_report_dmabuf);=0A=
> =0A=
=0A=
