Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBC11A683E
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781109214; cv=none; b=nTo/WfIEJFuEW+X6rEiQihLP0y2NEQo7iW9Tc+tkTH1EEWqKySgjnWTYnlponU87qjhtcQ7UlltvA5dB9opUuA/u8tiWx2pYfryrmiwH5Fe8zo6hqGuplP6+/NMVewd+1+meDF3igMcqSjMMjwXyAehPxNMPfRGXpUETwqfU9N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781109214; c=relaxed/simple;
	bh=5kpGWkfq0u/1/tuV/s/J0N3s7T29aJcVwc8vy1b+vig=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=obPaRtBTggkWS9sBU+OuDot54JKWJNm1b4NcdEzO/hWvZZPFVd7HDR87mquZ2GxvDeAAfoVYnJjHU6dHl0+f56Af/SMkdaPVJpvnGc5t6Zsgr/EthQA54pPyMLGBclPtMFcslgUPQXjX71t+qTPy4+h1aPa76pikWADQzKXjdeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/rRO1YG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/rRO1YG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3F81F00898;
	Wed, 10 Jun 2026 16:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781109212;
	bh=dryW28FA0AuawhCe8JIbzcsEum0BlV7sE1kexLWsj50=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=S/rRO1YGhMqblnXm6+LeoDj9n7dpqQsbFslAqb0YT5hCjr5PnFQ37X5WKsKsLzGlP
	 7e99hsoGNLPMyS28lg8QfxVNRhqItiaXl7Nu6ZXUva0vIqTFJjS9Ns307lwClr5FWs
	 KtKt+HGN14u+23wuVmtsKS3ZV6juPGDXsL8MGTafVL6mbG8pafUfKXayM92Le1VzQv
	 awpZbf26rk455RRP+NzOTuyyHUTb7A4doQaUFGQIsR3uKAqK4wXcSelObbLnEfj2Ex
	 OWm0ONY+3iL7OXRzz1pwEw3/dY0dBwAtAQxzGo20s05MoN5tpOc1HMBphXF25h4Wju
	 ZiFAGi/L3OqvA==
Date: Wed, 10 Jun 2026 18:33:29 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Helge Bahmann <hcb@chaoticmind.net>
cc: Nehal Bakulchandra Shah <Nehal-Bakulchandra.Shah@amd.com>, 
    Sandeep Singh <Sandeep.singh@amd.com>, 
    Basavaraj Natikar <Basavaraj.Natikar@amd.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-hid@vger.kernel.org, 
    linux-input@vger.kernel.org
Subject: Re: [PATCH] amd-sfh-hid: tablet mode switch and asus quirk
In-Reply-To: <6879487.lOV4Wx5bFT@lothlorien>
Message-ID: <167r4rn8-s146-9765-nso2-4ps916o77ps7@xreary.bet>
References: <6879487.lOV4Wx5bFT@lothlorien>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 27 Apr 2026, Helge Bahmann wrote:

> Add an input driver that interprets the "operation mode" sensor offered
> by the amd sfh on some laptop models.
> 
> Add a quirk to make the driver work again with the Asus VivoBook
> VivoBook (turn off the "disable interrupts" flag).
> 
> Expose the intr_disable flag as a module parameter in case it turns out
> to be needed on further laptop models.
> 
> Signed-off-by: Helge Bahmann <hcb@chaoticmind.net>

Basavaraj, could you please review this one? Thanks.

> ---
>  drivers/hid/amd-sfh-hid/amd_sfh_client.c | 25 ++++++++------
>  drivers/hid/amd-sfh-hid/amd_sfh_hid.c    | 43 ++++++++++++++++++++++++
>  drivers/hid/amd-sfh-hid/amd_sfh_hid.h    |  6 ++++
>  drivers/hid/amd-sfh-hid/amd_sfh_pcie.c   |  9 +++++
>  drivers/hid/amd-sfh-hid/amd_sfh_pcie.h   |  3 ++
>  5 files changed, 75 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_client.c b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
> index 7017bfa59093..a24757c5a203 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_client.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
> @@ -128,10 +128,16 @@ void amd_sfh_work_buffer(struct work_struct *work)
>  	guard(mutex)(&mp2->lock);
>  	for (i = 0; i < cli_data->num_hid_devices; i++) {
>  		if (cli_data->sensor_sts[i] == SENSOR_ENABLED) {
> -			report_size = mp2->mp2_ops->get_in_rep(i, cli_data->sensor_idx[i],
> -							       cli_data->report_id[i], in_data);
> -			hid_input_report(cli_data->hid_sensor_hubs[i], HID_INPUT_REPORT,
> -					 in_data->input_report[i], report_size, 0);
> +			if (cli_data->hid_sensor_hubs[i]) {
> +				report_size = mp2->mp2_ops->get_in_rep(i, cli_data->sensor_idx[i],
> +								       cli_data->report_id[i],
> +								       in_data);
> +				hid_input_report(cli_data->hid_sensor_hubs[i], HID_INPUT_REPORT,
> +						 in_data->input_report[i], report_size, 0);
> +			} else if (cli_data->sensor_idx[i] == op_idx &&
> +				   cli_data->modeswitch_input) {
> +				amdtp_modeswitch_report(i, cli_data->modeswitch_input, in_data);
> +			}
>  		}
>  	}
>  	schedule_delayed_work(&cli_data->work_buffer, msecs_to_jiffies(AMD_SFH_IDLE_LOOP));
> @@ -327,15 +333,12 @@ int amd_sfh_hid_client_init(struct amd_mp2_dev *privdata)
> 
>  	for (i = 0; i < cl_data->num_hid_devices; i++) {
>  		cl_data->cur_hid_dev = i;
> -		if (cl_data->sensor_idx[i] == op_idx) {
> -			dev_dbg(dev, "sid 0x%x (%s) status 0x%x\n",
> -				cl_data->sensor_idx[i], get_sensor_name(cl_data->sensor_idx[i]),
> -				cl_data->sensor_sts[i]);
> -			continue;
> -		}
> 
>  		if (cl_data->sensor_sts[i] == SENSOR_ENABLED) {
> -			rc = amdtp_hid_probe(i, cl_data);
> +			if (cl_data->sensor_idx[i] != op_idx)
> +				rc = amdtp_hid_probe(i, cl_data);
> +			else
> +				rc = amdtp_modeswitch_probe(i, cl_data);
>  			if (rc)
>  				goto cleanup;
>  		} else {
> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_hid.c b/drivers/hid/amd-sfh-hid/amd_sfh_hid.c
> index 81f3024b7b1b..44008c02b63c 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_hid.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_hid.c
> @@ -181,4 +181,47 @@ void amdtp_hid_remove(struct amdtp_cl_data *cli_data)
>  			cli_data->hid_sensor_hubs[i] = NULL;
>  		}
>  	}
> +
> +	/* note: cli_data->modeswitch_input implicitly cleaned by devres */
> +}
> +
> +int amdtp_modeswitch_probe(u32 cur_hid_dev, struct amdtp_cl_data *cli_data)
> +{
> +	struct amd_mp2_dev *mp2 = container_of(cli_data->in_data, struct amd_mp2_dev, in_data);
> +	struct device *dev = &mp2->pdev->dev;
> +	struct input_dev *input;
> +	int rc;
> +
> +	input = devm_input_allocate_device(dev);
> +	if (IS_ERR(input))
> +		return PTR_ERR(input);
> +
> +	input->name = "AMD SFH tablet mode switch sensor";
> +	input->id.bustype = BUS_PCI;
> +
> +	input_set_capability(input, EV_SW, SW_TABLET_MODE);
> +
> +	rc = input_register_device(input);
> +	if (rc)
> +		goto cleanup;
> +
> +	cli_data->modeswitch_input = input;
> +
> +	return 0;
> +
> +cleanup:
> +	return rc;
> +}
> +
> +void amdtp_modeswitch_report(u32 index, struct input_dev *input, struct amd_input_data *in_data)
> +{
> +	u32 *sensor_virt_addr = in_data->sensor_virt_addr[index];
> +	u32 value = sensor_virt_addr[0];
> +
> +	if (value == AMD_SFH_OP_IDX_MODE_TABLET)
> +		input_report_switch(input, SW_TABLET_MODE, 1);
> +	else
> +		input_report_switch(input, SW_TABLET_MODE, 0);
> +
> +	input_sync(input);
>  }
> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_hid.h b/drivers/hid/amd-sfh-hid/amd_sfh_hid.h
> index 7452b0302953..20aff7b75fbd 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_hid.h
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_hid.h
> @@ -11,6 +11,8 @@
>  #ifndef AMDSFH_HID_H
>  #define AMDSFH_HID_H
> 
> +#include <linux/input.h>
> +
>  #define MAX_HID_DEVICES		7
>  #define AMD_SFH_HID_VENDOR	0x1022
>  #define AMD_SFH_HID_PRODUCT	0x0001
> @@ -50,6 +52,7 @@ struct amdtp_cl_data {
>  	u8 sensor_idx[MAX_HID_DEVICES];
>  	u8 *feature_report[MAX_HID_DEVICES];
>  	u8 request_done[MAX_HID_DEVICES];
> +	struct input_dev *modeswitch_input;
>  	struct amd_input_data *in_data;
>  	struct delayed_work work;
>  	struct delayed_work work_buffer;
> @@ -78,4 +81,7 @@ void amdtp_hid_remove(struct amdtp_cl_data *cli_data);
>  int amd_sfh_get_report(struct hid_device *hid, int report_id, int report_type);
>  void amd_sfh_set_report(struct hid_device *hid, int report_id, int report_type);
>  void amdtp_hid_wakeup(struct hid_device *hid);
> +int amdtp_modeswitch_probe(u32 cur_hid_dev, struct amdtp_cl_data *cli_data);
> +void amdtp_modeswitch_report(u32 index, struct input_dev *input, struct amd_input_data *in_data);
> +
>  #endif
> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> index 1d9f955573aa..cd9cff75f114 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> @@ -39,6 +39,8 @@ module_param_named(sensor_mask, sensor_mask_override, int, 0444);
>  MODULE_PARM_DESC(sensor_mask, "override the detected sensors mask");
> 
>  static bool intr_disable = true;
> +module_param_named(intr_disable, intr_disable, bool, 0444);
> +MODULE_PARM_DESC(intr_disable, "override the interrupt disable sensor bit");
> 
>  static int amd_sfh_wait_response_v2(struct amd_mp2_dev *mp2, u8 sid, u32 sensor_sts)
>  {
> @@ -317,6 +319,13 @@ static const struct dmi_system_id dmi_sfh_table[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "HP ProBook x360 435 G7"),
>  		},
>  	},
> +	{
> +		.callback = mp2_disable_intr,
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "VivoBook_ASUSLaptop TP420UA_TM420UA"),
> +		}
> +	},
>  	{}
>  };
> 
> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
> index 2eb61f4e8434..5e968894ebe4 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
> @@ -83,6 +83,9 @@ enum sensor_idx {
>  	als_idx = 19
>  };
> 
> +#define AMD_SFH_OP_IDX_MODE_LAPTOP 1
> +#define AMD_SFH_OP_IDX_MODE_TABLET 3
> +
>  enum mem_use_type {
>  	USE_DRAM,
>  	USE_C2P_REG,
> --
> 2.47.3
> 
> 
> 
> 

-- 
Jiri Kosina
SUSE Labs

