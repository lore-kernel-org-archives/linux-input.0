Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793024112;
	b=cUxB34gElBKHPabe2t7D+sHWg9rt4AB1B21PlnIEBXR3qjXxjCacwHkI+OChA2DlVR1r
	 lWaZPUSM2lsq+T+Whz5EnG5Qu4Zm7ezhaJpH//f44D6cK0Tapsyt1S3ZDCDaB0NuuYP6n
	 Z4VCGtyhAUf6o94QrPSXhU+n4/zL3x7lYsUdbw10Xk9IBFg2AXwDY+M8ye4OaNzUkfM7R
	 7Jf7fqNccFGiW1CovJmC96LBD12t2x4jYLFQe+XZ0kvDe1TZ7ietErQM37FZlxYmmoKZt
	 OKvDf2NC96GWfMcFIFLLJvxbFMqog6oO4B/ra2x5g0JT4unTOWyBDOvIm42tgAxHOog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793024112;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=Ez5ntbIh+EW8bTl4TijkvlK9dqmEXQTUkScs6BriJM4=;
	b=m04DcZn8FXvapDoMgLrhTmAn5uO3UlvEtGXuec4h7EsJXzUTSFatq4ZbAXMOYkg67OPf
	 TCKo2I74e7ATCrYXHOdpY0KcCA7iPTEigO4o5orURlgmsgr+vEHYdniBLwxJE8V8fh5NY
	 kuCLmeZ4l5Ot4UoowZ3JB/87bGljQm5ygeZci6tYIO38dsHaBK2XXDgxSKjRsgryqooqw
	 nhtnmxzrmqa+vLLNWwAWgSiUt318XIs81IzJwI6aQ5v94Gz6JqzIherUP8DWAFOBg6LmU
	 Y1OLw+E4u2gRD+VPP/3sAx+6kE+d0UMDZZ4AlvtE4LoTFJbPD2ufCHsC6IqipDEPr6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FPBarEr6;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2649F606A31B;
	Mon, 26 Oct 2026 14:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2649F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FPBarEr6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793024111; x=1824560111;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qc4beh/LwtB0vw+iP15WQW0Wl9ZVp8GN+Zby6+YptcI=;
  b=FPBarEr6Z48ed5eQdIWBr/1Wvl8Ey0YsYgfrP0sPfig9UjR030rPkQE9
   jazNXwTAeCLp7QmMvwAK1W2yGYh0eQxf9rwi+rt9BHgxryRoNOC1hbpK2
   y3YXqxwN6bf8aGfNjukUHyq4pKkcfYArw+BJLACmCiYwQ8Te+90ZGFy+T
   BG/jVnL6remkBvg2obgvhTKaLECwRvsTvDu8PK9B2uX3jioVrkoP38BeJ
   n3t4YdfBSxa2RZMCXIz1DVSDd5nSno1qzcpqDDanbNoiw0jSdL/PkB9Bz
   pjJNRfQ5vSs0Mc/OLp7IYsKQd/jAItXmsq8sbm/NTtExxrcFNgyN51QpZ
   w==;
X-CSE-ConnectionGUID: W2iS01voS2mzfvOUU4Ev0w==
X-CSE-MsgGUID: cm+LquatQ5eLCuiSPNzB0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1697599"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1697599"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 07:15:11 -0700
X-CSE-ConnectionGUID: d9jyxAXVQmSMZnS5qFL0gg==
X-CSE-MsgGUID: SRRySvS4RSK0qwR27b/pHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4285214"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 07:15:04 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 26 Oct 2026 16:15:00 +0200 (EET)
To: Denis Benato <denis.benato@linux.dev>
cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    linux-input@vger.kernel.org, kernel@lists.opengamingcollective.org, 
    Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
    "Luke D . Jones" <luke@ljones.dev>, 
    Mateusz Schwartz <matthew.schwartz@linux.dev>, 
    Denis Benato <benato.denis96@gmail.com>, 
    Jonathan LoBue <jlobue10@gmail.com>, 
    Khamunetri Clark <khamunetriclark@gmail.com>, 
    "Derek J. Clark" <derekjohn.clark@gmail.com>, 
    Joshua Leivenzon <hacker1024@users.sourceforge.net>, 
    Nathan Chancellor <nathan@kernel.org>, 
    =?ISO-8859-15?Q?Rebecca_Mara_M=FCller?= <rebecca.mara@posteo.de>, 
    Ivan Levchenko <me@livan.pro>, Corentin Chary <corentin.chary@gmail.com>, 
    Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v11 17/18] HID: asus: report the XG Mobile GPU vendor to
 asus-wmi
In-Reply-To: <20261025235232.129945-18-denis.benato@linux.dev>
Message-ID: <8353d073-2abd-96d6-e861-b170f5b95f45@linux.intel.com>
References: <20261025235232.129945-1-denis.benato@linux.dev> <20261025235232.129945-18-denis.benato@linux.dev>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 25 Oct 2026, Denis Benato wrote:

> The version query answers with the 4-part PCI ID of the GPU installed
> in the station. Parse it, report its vendor part to asus-wmi as soon
> as the station is identified and clear it when the station goes away,
> so that enabling the eGPU through egpu_enable composes the right
> activation value for NVIDIA, AMD and Intel stations alike.
> 
> Signed-off-by: Denis Benato <denis.benato@linux.dev>
> ---
>  drivers/hid/hid-asus.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index e444cad85b32..244d103fbd4c 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -186,6 +186,7 @@ struct asus_xgm_info {
>  	char part_number[ASUS_XGM_INFO_LEN];
>  	char firmware_version[ASUS_XGM_INFO_LEN];
>  	char generation[ASUS_XGM_INFO_LEN];
> +	u8 gpu_id[4];
>  };
>  
>  struct asus_touchpad_info {
> @@ -6313,6 +6314,12 @@ static int asus_xgm_get_version(struct hid_device *hdev,
>  	asus_xgm_tlv_str(info->firmware_version, sizeof(info->firmware_version),
>  			 buf, len, "VER");
>  
> +	/* the 4-part PCI ID of the GPU installed in the station: buf[3..10] */
> +	if (len < 11)
> +		return -ENODATA;
> +
> +	memcpy(info->gpu_id, buf + 3, sizeof(info->gpu_id));

Is this 3 also related to tag length (the literals comment I had to the 
other patch)?

--
 i.

> +
>  	return 0;
>  }
>  
> @@ -6685,6 +6692,8 @@ static int asus_xgm_init(struct hid_device *hdev, struct asus_drvdata *drvdata)
>  		hid_info(hdev, "XG Mobile: firmware %s, generation %s\n",
>  			 info->firmware_version, info->generation);
>  
> +	asus_wmi_egpu_set_vendor(info->gpu_id[0]);
> +
>  	/*
>  	 * The attribute group is not devm-managed: a creation failure is
>  	 * fatal and unwound through asus_xgm_init_err, while on the unbind
> @@ -6732,6 +6741,7 @@ static int asus_xgm_init(struct hid_device *hdev, struct asus_drvdata *drvdata)
>  
>  	return 0;
>  asus_xgm_init_err:
> +	asus_wmi_egpu_set_vendor(0);
>  	sysfs_remove_group(&hdev->dev.kobj, &asus_xgm_attr_group);
>  	drvdata->xgm_info = NULL;
>  	drvdata->xgm_led = NULL;
> @@ -6951,8 +6961,10 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  	if (drvdata->listener.brightness_set)
>  		asus_hid_unregister_listener(&drvdata->listener);
>  
> -	if (drvdata->xgm_info)
> +	if (drvdata->xgm_info) {
> +		asus_wmi_egpu_set_vendor(0);
>  		sysfs_remove_group(&hdev->dev.kobj, &asus_xgm_attr_group);
> +	}
>  
>  	if (drvdata->xgm_led)
>  		devm_led_classdev_unregister(&hdev->dev, &drvdata->xgm_led->cdev);
> @@ -6972,8 +6984,10 @@ static void asus_remove(struct hid_device *hdev)
>  	if (drvdata->listener.brightness_set)
>  		asus_hid_unregister_listener(&drvdata->listener);
>  
> -	if (drvdata->xgm_info)
> +	if (drvdata->xgm_info) {
> +		asus_wmi_egpu_set_vendor(0);
>  		sysfs_remove_group(&hdev->dev.kobj, &asus_xgm_attr_group);
> +	}
>  
>  	if (drvdata->xgm_led)
>  		devm_led_classdev_unregister(&hdev->dev, &drvdata->xgm_led->cdev);
> 
