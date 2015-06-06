From: duson <dusonlin@emc.com.tw>
Subject: Re: [PATCH] input: elan_i2c - Add product IDs FW names
Date: Sat, 6 Jun 2015 11:01:03 +0800
Message-ID: <88477951-A1EC-4B02-B745-E946DB0E495F@emc.com.tw>
References: <1433521531-920-1-git-send-email-charliemooney@chromium.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from elanic.emc.com.tw ([192.72.220.188]:34290 "EHLO
	elanic.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbbFFDKH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Jun 2015 23:10:07 -0400
In-Reply-To: <1433521531-920-1-git-send-email-charliemooney@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Charlie Mooney <charliemooney@chromium.org>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, bleung@chromium.org, nicolas.iooss_linux@m4x.org, Charles Mooney <charliemooney@google.com>, JeffChuang <Jeff.chuang@emc.com.tw>

Hi Charlie,

Thanks for your help to upstream this patch, it is a good idea to updat=
e right firmware to right touchpad.
In order to distinguish between old and new driver, could you also modi=
fy the driver version for this patch?
Thank you very much.

In elan_i2c_core.c
line 7, * Version: 1.5.7 -> 1.5.8
line 48, #define ELAN_DRIVER_VERSION =E2=80=9C1.5.7=E2=80=9D -> =E2=80=9C=
1.5.8"

=20

----------------------------------------------
Thanks,
ELAN Duson
=E2=9C=89 Email: dusonlin@emc.com.tw
----------------------------------------------





> Charlie Mooney <charliemooney@chromium.org> =E6=96=BC 2015=E5=B9=B46=E6=
=9C=886=E6=97=A5 =E4=B8=8A=E5=8D=8812:25 =E5=AF=AB=E9=81=93=EF=BC=9A
>=20
> Previously the elan_i2c touchpad driver would simply request the
> firmware "/lib/firmware/elan_i2c.bin"
>=20
> This CL appends the "product ID" (by using the same function as
> the sysfs interface for consistency) to the filename.  This results i=
n
> filenames of the form "/lib/firmware/elan_i2c_72.0.bin", allowing you
> to support multiple elan_i2c touchpads on the same device by simply
> naming each device's FW with its corresponding product ID.  This way
> when you trigger a fw update the driver will load the correct binary.
>=20
> Signed-off-by: Charlie Mooney <charliemooney@chromium.org>
> ---
> drivers/input/mouse/elan_i2c.h      |  4 +++-
> drivers/input/mouse/elan_i2c_core.c | 19 +++++++++++++++----
> 2 files changed, 18 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/input/mouse/elan_i2c.h b/drivers/input/mouse/ela=
n_i2c.h
> index 6d5f8a4..d793184 100644
> --- a/drivers/input/mouse/elan_i2c.h
> +++ b/drivers/input/mouse/elan_i2c.h
> @@ -28,7 +28,9 @@
> #define ETP_PRESSURE_OFFSET	25
>=20
> /* IAP Firmware handling */
> -#define ETP_FW_NAME		"elan_i2c.bin"
> +#define ETP_FW_BASENAME		"elan_i2c"
> +#define ETP_FW_EXTENSION	"bin"
> +#define ETP_PRODUCT_ID_FORMAT_STRING	"%d.0"
> #define ETP_IAP_START_ADDR	0x0083
> #define ETP_FW_IAP_PAGE_ERR	(1 << 5)
> #define ETP_FW_IAP_INTF_ERR	(1 << 4)
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mous=
e/elan_i2c_core.c
> index fd5068b..fea9837 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -403,7 +403,8 @@ static ssize_t elan_sysfs_read_product_id(struct =
device *dev,
> 	struct i2c_client *client =3D to_i2c_client(dev);
> 	struct elan_tp_data *data =3D i2c_get_clientdata(client);
>=20
> -	return sprintf(buf, "%d.0\n", data->product_id);
> +	return sprintf(buf, ETP_PRODUCT_ID_FORMAT_STRING "\n",
> +		       data->product_id);
> }
>=20
> static ssize_t elan_sysfs_read_fw_ver(struct device *dev,
> @@ -446,10 +447,20 @@ static ssize_t elan_sysfs_update_fw(struct devi=
ce *dev,
> 	const u8 *fw_signature;
> 	static const u8 signature[] =3D {0xAA, 0x55, 0xCC, 0x33, 0xFF, 0xFF}=
;
>=20
> -	error =3D request_firmware(&fw, ETP_FW_NAME, dev);
> +	/* Look for a firmware with the product id appended. */
> +	char *full_fw_name =3D kasprintf(GFP_KERNEL,
> +			"%s_" ETP_PRODUCT_ID_FORMAT_STRING ".%s",
> +			ETP_FW_BASENAME, data->product_id, ETP_FW_EXTENSION);
> +	if (!full_fw_name) {
> +		dev_err(dev, "failed fw filename memory allocation.");
> +		return -ENOMEM;
> +	}
> +	dev_info(dev, "requesting fw '%s'\n", fw_name);
> +	error =3D request_firmware(&fw, full_fw_name, dev);
> +	kfree(full_fw_name);
> 	if (error) {
> -		dev_err(dev, "cannot load firmware %s: %d\n",
> -			ETP_FW_NAME, error);
> +		dev_err(dev, "cannot load firmware '%s': %d\n",
> +			full_fw_name, error);
> 		return error;
> 	}
>=20
> --=20
> 2.1.2
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
