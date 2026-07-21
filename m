Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1AA2EB0F
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784645231; cv=none; b=fMnK2lYZAJr5m9OKecwl+Y79TaTd6w5ipSbFHR90Z+2Rj5Ap4PuyHbTGG1T7/HJl6m4G7Etn+4Sn16QbVzoNs9zEeao2FcJzQfKeOOZ0tRE+rD/7inr9mqPCx0BKClsMQt6Grj0JdD3OVP7FZniotcuiIYo9KcTEfW6s6TGZX/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784645231; c=relaxed/simple;
	bh=abQNiIbBA0dlzX07lSG/G2ESO9aqdFJFOVttAJbDKRA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aaOhCZbm26UAxvOdZ9r7yzEacfUd7zMznrPXEMb7s7AzbUAFYNZ8JMlFXq2LbGj+oQ8GuPqnKNHPGMPk72GB3ukg8R+j4HXaJ/QizM/JONhYHO1V0nRhGBgdJfkHdgkjjQA9B2I9WWGhH3PZjrRUWPJV3e5VQrDkSxmlFrVAmp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEfdAwI+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEfdAwI+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D022C1F00A3D;
	Tue, 21 Jul 2026 14:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784645230;
	bh=ejr+spST/unWeNZdj5amn15tN2Ogqq6e1fgnigbWXXU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JEfdAwI+YmrQqI1T0QipBPontHp/ALxPdU5FwN5u+Q7DBswVlmRW/YOPcOlQWTYvz
	 NmnUxl3klXHGaYqrTLCO//2mygV+PURi2b6CCcijn50bLupivujOZOaGWGjT2fAs+7
	 +IU6XIJny6KieIcrVOrtfv8TZ+3LmPkf60geZL8iiySZqMGHLamu5nNrG/8impzXIF
	 IUOcQyvGHhy3qk+hiJVutDeOtmF8dJvBtd4bxcginDJgy2F5YzphtiC3G0kjSy02OZ
	 EAuh6D2MuRzzi54mM/C5K0OJMvkRg5GRNjNzs+XDhX9FoyT7uniM/23nkcbE1HB05D
	 oMVQXFGtrr3Ig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] amd-sfh-hid: tablet mode hid report and asus quirk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Helge Bahmann" <hcb@chaoticmind.net>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <2108873.tdWV9SEqCh@zephyr>
References: <6879487.lOV4Wx5bFT@lothlorien> <2632507.ElGaqSPkdT@lothlorien>
 <ecadaac8-e222-420a-ac5b-4d529fb3317e@amd.com> <2108873.tdWV9SEqCh@zephyr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 14:47:09 +0000
Message-Id: <20260721144709.D022C1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [Medium] Missing HID Input Mapping for tablet mode switch
- [Low] Incomplete Implementation / Dead Code for Feature Report
- [Low] Unintentional Parameter Override via DMI Quirk
- [Low] Unused Macros for Tablet State Evaluated by Magic Number
- [Low] Introduction of Non-English Comments

Pre-existing issues:
- [High] Double Free / Use-After-Free in amdtp_hid_probe error path
--

--- Patch [1]: [PATCH 1/2] amd-sfh-hid: tablet mode hid report and asus qui=
rk ---
commit 8025fc07a2e48355e8daeee6c47f30c940eb5a30
Author: Helge Bahmann <hcb@chaoticmind.net>

amd-sfh-hid: tablet mode hid report and asus quirk

Add an input driver that interprets the "operation mode" sensor offered
by the amd sfh as a hid driver to generate a custom hid report (tablet
mode switch).

Add a quirk to restore compatibility of the driver with the Asus
VivoBook (turn off the "disable interrupts flag). Expose the
intr_disable flag as a module parameter in case it turns out to be
needed on further laptop models.

> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_client.c b/drivers/hid/amd-s=
fh-hid/amd_sfh_client.c
> index 96ae792beeb6c..8c03279646023 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_client.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
[ ... ]
> @@ -327,12 +314,6 @@ int amd_sfh_hid_client_init(struct amd_mp2_dev *priv=
data)
> =20
>  	for (i =3D 0; i < cl_data->num_hid_devices; i++) {
>  		cl_data->cur_hid_dev =3D i;
> -		if (cl_data->sensor_idx[i] =3D=3D op_idx) {
> -			dev_dbg(dev, "sid 0x%x (%s) status 0x%x\n",
> -				cl_data->sensor_idx[i], get_sensor_name(cl_data->sensor_idx[i]),
> -				cl_data->sensor_sts[i]);
> -			continue;
> -		}
> =20
>  		if (cl_data->sensor_sts[i] =3D=3D SENSOR_ENABLED) {
>  			rc =3D amdtp_hid_probe(i, cl_data);

[Severity: High]
This isn't a bug introduced by this patch, but is a pre-existing issue in t=
he
driver's error-handling path.

If amdtp_hid_probe() fails (e.g., in hid_add_device()), it destroys the hid
device but does not clear the dangling pointer in
cli_data->hid_sensor_hubs[cur_hid_dev].

When this failure propagates up to amd_sfh_hid_client_init(), it jumps to t=
he
cleanup label and invokes amd_sfh_hid_client_deinit() -> amdtp_hid_remove().

amdtp_hid_remove() will then iterate over the hid_sensor_hubs array and call
hid_destroy_device() again on the dangling pointer, which can cause a double
free.

Should the pointer be set to NULL in amdtp_hid_probe() on error?

> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh=
-hid/amd_sfh_pcie.c
> index 4b81cebdc3359..924329bfef8fe 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> @@ -39,6 +39,8 @@ module_param_named(sensor_mask, sensor_mask_override, i=
nt, 0444);
>  MODULE_PARM_DESC(sensor_mask, "override the detected sensors mask");
> =20
>  static bool intr_disable =3D true;
> +module_param_named(intr_disable, intr_disable, bool, 0444);
> +MODULE_PARM_DESC(intr_disable, "override the interrupt disable sensor bi=
t");

[Severity: Low]
Because intr_disable is implemented as a simple boolean, the DMI match quirk
for Asus VivoBook unconditionally invokes mp2_disable_intr(), which
overwrites intr_disable to false.

Does this prevent the driver from differentiating between the default state
and an explicit user override on the command line (e.g.,
amd_sfh.intr_disable=3D1)?

> diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c b/=
drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
> index ef1f9be8b8938..7e807b92d2960 100644
> --- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
> +++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
[ ... ]
> @@ -164,6 +180,11 @@ static u8 get_feature_report(int sensor_idx, int rep=
ort_id, u8 *feature_report)
>  		memcpy(feature_report, &gyro_feature, sizeof(gyro_feature));
>  		report_size =3D sizeof(gyro_feature);
>  		break;
> +	case op_idx: /* op */
> +		get_common_features(&tablet_mode_feature.common_property, report_id);
> +		memcpy(feature_report, &tablet_mode_feature, sizeof(tablet_mode_featur=
e));
> +		report_size =3D sizeof(tablet_mode_feature);
> +		break;

[Severity: Low]
The driver allocates and populates a Feature report
(tablet_mode_feature_report) here, but the corresponding
tablet_mode_report_descriptor lacks any Feature items (0xB1).

Since the HID core strictly relies on the parsed descriptor to create repor=
ts,
will a feature report with ID 0x11 ever be requested, or is this unused
dead code?

> @@ -238,6 +260,15 @@ static u8 get_input_report(u8 current_index, int sen=
sor_idx, int report_id,
>  		memcpy(input_report, &gyro_input, sizeof(gyro_input));
>  		report_size =3D sizeof(gyro_input);
>  		break;
> +	case op_idx: /* op */
> +		tablet_mode_input.report_id =3D 0x11;
> +		if (sensor_virt_addr[0] =3D=3D 3)
> +			tablet_mode_input.tablet_state =3D 1;
> +		else
> +			tablet_mode_input.tablet_state =3D 0;

[Severity: Low]
This code relies on a hardcoded magic number 3. Should this evaluate the
sensor payload using the newly defined AMD_SFH_OP_IDX_MODE_TABLET macro
instead?

> diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h b/=
drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h
> index 882434b1501ff..ff82e47eb3ca4 100644
> --- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h
> +++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h
> @@ -114,4 +114,13 @@ struct hpd_input_report {
>  	u8 human_presence;
>  } __packed;
> =20
> +struct tablet_mode_feature_report {
> +	struct common_feature_property common_property;
> +} __packed;
> +
> +struct tablet_mode_input_report {
> +	u8 report_id;    /* Muss 0x11 (17) sein */

[Severity: Low]
Is this German comment intentional? Kernel coding style typically requires =
all
comments to be written in English.

> diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_de=
sc.h b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
> index 67ec2d6a417de..f95368534fc60 100644
> --- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
> +++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
> @@ -776,4 +776,22 @@ static const u8 hpd_report_descriptor[] =3D {
>  0X81, 0x02,		 /* HID Input (Data_Var_Abs) */
>  0xC0			 /* HID end collection */
>  };
> +
> +/* tablet mode switch */
> +static const u8 tablet_mode_report_descriptor[] =3D {
> +0x05, 0x0C,		/* HID usage consumer electronics */
> +0x09, 0x01,		/* HID usage */
> +0xA1, 0x00,		/* HID collection (Physical) */
> +0x85, 0x11,		/* HID report id */
> +0x0A, 0xFF, 0x02,	/* HID usage (unallocated -- (ab)used for tablet mode)=
 */

[Severity: Medium]
Because the driver does not provide a custom .input_mapping callback to
intercept and map this unallocated Consumer usage to SW_TABLET_MODE, will t=
he
standard hid-input core ignore it or map it to KEY_UNKNOWN (240)?

Could this result in physical changes in tablet mode emitting spurious unkn=
own
key events instead of a standard EV_SW switch event?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/ecadaac8-e222-420a-=
ac5b-4d529fb3317e@amd.com?part=3D1
