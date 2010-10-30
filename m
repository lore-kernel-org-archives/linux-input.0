From: "Joey Lee" <jlee@novell.com>
Subject: Re: [PATCH 2/4] Enabled Acer Launch Manager mode
Date: Sat, 30 Oct 2010 10:44:43 -0600
Message-ID: <4CCCE62B0200002300022F07@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
Sender: platform-driver-x86-owner@vger.kernel.org
To: platform-driver-x86@vger.kernel.org
Cc: corentin.chary@gmail.com, dmitry.torokhov@gmail.com, Takashi Iwai <tiwai@novell.com>, Thomas Renninger <trenn@novell.com>, mjg59@srcf.ucam.org, carlos@strangeworlds.co.uk, jbenc@suse.cz, trenn@suse.de, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Add CC. Thomas

=E6=96=BC =E6=97=A5=EF=BC=8C2010-10-31 =E6=96=BC 00:36 +0800=EF=BC=8CLe=
e, Chun-Yi =E6=8F=90=E5=88=B0=EF=BC=9A
> Enabled Acer Launch Manager mode to disable the EC raw behavior for
> communication devices when WMID3 method available. And, we also add a
> ec_raw_mode kernel module option for enable The EC raw behavior mode
> when anyone what reset it back.
> When Acer Launch Manager mode enabled, EC will stop to touch any
> communication devices' RF state or power state that causes conflict
> with rfkill_input or any userland daemon to charge the rfkill rules.
>=20
> Signed-off-by: Lee, Chun-Yi <jlee@novell.com>
> ---
>  drivers/platform/x86/acer-wmi.c |  113 +++++++++++++++++++++++++++++=
++++++++++
>  1 files changed, 113 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/a=
cer-wmi.c
> index 930df56..0b870d3 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -85,6 +85,7 @@ MODULE_LICENSE("GPL");
>  #define AMW0_GUID2		"431F16ED-0C2B-444C-B267-27DEB140CF9C"
>  #define WMID_GUID1		"6AF4F258-B401-42fd-BE91-3D4AC2D7C0D3"
>  #define WMID_GUID2		"95764E09-FB56-4e83-B31A-37761F60994A"
> +#define WMID_GUID3		"61EF69EA-865C-4BC3-A502-A0DEBA0CB531"
> =20
>  /*
>   * Acer ACPI event GUIDs
> @@ -120,6 +121,20 @@ struct event_return_value {
>  	u32 reserved;
>  } __attribute__((packed));
> =20
> +struct lm_input_params {
> +	u8 function_num;	/* Function Number */
> +	u16 commun_devices;	/* Communication type devices default status */
> +	u16 devices;		/* Other type devices default status */
> +	u8 lm_status;		/* Launch Manager Status */
> +	u16 reserved;
> +} __attribute__((packed));
> +
> +struct lm_return_value {
> +	u8 error_code;		/* Error Code */
> +	u8 ec_return_value;	/* EC Return Value */
> +	u16 reserved;
> +} __attribute__((packed));
> +
>  /*
>   * Interface capability flags
>   */
> @@ -150,15 +165,18 @@ static int mailled =3D -1;
>  static int brightness =3D -1;
>  static int threeg =3D -1;
>  static int force_series;
> +static bool ec_raw_mode;
> =20
>  module_param(mailled, int, 0444);
>  module_param(brightness, int, 0444);
>  module_param(threeg, int, 0444);
>  module_param(force_series, int, 0444);
> +module_param(ec_raw_mode, bool, 0444);
>  MODULE_PARM_DESC(mailled, "Set initial state of Mail LED");
>  MODULE_PARM_DESC(brightness, "Set initial LCD backlight brightness")=
;
>  MODULE_PARM_DESC(threeg, "Set initial state of 3G hardware");
>  MODULE_PARM_DESC(force_series, "Force a different laptop series");
> +MODULE_PARM_DESC(ec_raw_mode, "Enable EC raw mode");
> =20
>  struct acer_data {
>  	int mailled;
> @@ -1393,6 +1411,87 @@ error_debugfs:
>  	return -ENOMEM;
>  }
> =20
> +static acpi_status
> +wmid3_set_lm_mode(struct lm_input_params *params,
> +			struct lm_return_value *return_value)
> +{
> +	acpi_status status;
> +	union acpi_object *obj;
> +
> +	struct acpi_buffer input =3D { sizeof(struct lm_input_params), para=
ms };
> +	struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +
> +	status =3D wmi_evaluate_method(WMID_GUID3, 0, 0x1, &input, &output)=
;
> +	if (ACPI_FAILURE(status))
> +		return status;
> +
> +	obj =3D output.pointer;
> +
> +	if (!obj)
> +		return -EINVAL;
> +	else if (obj->type !=3D ACPI_TYPE_BUFFER) {
> +		kfree(obj);
> +		return -EINVAL;
> +	}
> +	if (obj->buffer.length !=3D 4) {
> +		printk(ACER_WARNING "Unknown buffer length %d\n",
> +			obj->buffer.length);
> +		kfree(obj);
> +		return -EINVAL;
> +	}
> +
> +	*return_value =3D *((struct lm_return_value *)obj->buffer.pointer);
> +	kfree(obj);
> +
> +	return status;
> +}
> +
> +static int acer_wmi_enable_ec_raw(void)
> +{
> +	struct lm_return_value return_value;
> +	acpi_status status;
> +	struct lm_input_params params =3D {
> +		.function_num =3D 0x1,
> +		.commun_devices =3D 0xFFFF,
> +		.devices =3D 0xFFFF,
> +		.lm_status =3D 0x00,		/* Launch Manager Deactive */
> +	};
> +
> +	status =3D wmid3_set_lm_mode(&params, &return_value);
> +
> +	if (return_value.error_code || return_value.ec_return_value)
> +		printk(ACER_WARNING "Enabling EC raw mode failed: "
> +			"0x%x - 0x%x\n", return_value.error_code,
> +			return_value.ec_return_value);
> +	else
> +		printk(ACER_INFO "Enabled EC raw mode");
> +
> +	return status;
> +}
> +
> +static int acer_wmi_enable_lm(void)
> +{
> +	struct lm_return_value return_value;
> +	acpi_status status;
> +	struct lm_input_params params =3D {
> +		.function_num =3D 0x1,
> +		.commun_devices =3D 0x0041,	/* WiFi on, 3G on, BT off */
> +		.devices =3D 0xFFFF,
> +		.lm_status =3D 0x41,		/* Launch Manager Active */
> +	};
> +
> +	status =3D wmid3_set_lm_mode(&params, &return_value);
> +
> +	if (return_value.error_code || return_value.ec_return_value)
> +		printk(ACER_WARNING "Enabling Launch Manager failed: "
> +			"0x%x - 0x%x\n", return_value.error_code,
> +			return_value.ec_return_value);
> +	else
> +		printk(ACER_INFO "Enabled Launch Manager");
> +
> +	return status;
> +}
> +
>  static int __init acer_wmi_init(void)
>  {
>  	int err;
> @@ -1454,6 +1553,20 @@ static int __init acer_wmi_init(void)
>  		       "generic video driver\n");
>  	}
> =20
> +	if (wmi_has_guid(WMID_GUID3)) {
> +		if (ec_raw_mode) {
> +			if (ACPI_FAILURE(acer_wmi_enable_ec_raw())) {
> +				printk(ACER_ERR "Cannot enable EC raw mode\n");
> +				return -ENODEV;
> +			}
> +		} else if (ACPI_FAILURE(acer_wmi_enable_lm())) {
> +			printk(ACER_ERR "Cannot enable Launch Manager mode\n");
> +			return -ENODEV;
> +		}
> +	} else if (!wmi_has_guid(WMID_GUID3) && ec_raw_mode) {
> +		printk(ACER_INFO "No WMID EC raw mode enable method\n");
> +	}
> +
>  	if (wmi_has_guid(ACERWMID_EVENT_GUID)) {
>  		err =3D acer_wmi_input_setup();
>  		if (err)
