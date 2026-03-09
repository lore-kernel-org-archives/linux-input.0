Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092F136B04D;
	Mon,  9 Mar 2026 08:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773043316; cv=none; b=B5TDevP7Mcjbw0imAeJBu/dx8FijhB1KyONaN2bYq2B+eDHYuujjU77FcAgPBy/6aLdix1lxKxmJ1/QRQpN5EAtlpR8p28WPcoEus+stcFYxAJ0qzGCjhBWU/8wAD8LG67z7VWe5sqQ9k1HMlJLr6T11iDOkGXVq1VtNybvIPbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773043316; c=relaxed/simple;
	bh=MA5fU7jyFYzGOSNzkFLBFwZggtqhZftn5JVfVtkiQpU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Dn9phG77Op3d8uOTOQi9EbXq5A2x2HoFFS7/57xVhG1p6khXr5YURe97IwmtkjdupUb0OJZqtQpyngEvKMxnPi0Z4eD/3HEvxqFpyLnr7UZcbmA4qiTgH646fCwPmyQ5Rez/TDZfujVIWpKmOUmIm0uYffNVbdAwy9MrMcz6gxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mMp27Y1s; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mMp27Y1s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773043315; x=1804579315;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MA5fU7jyFYzGOSNzkFLBFwZggtqhZftn5JVfVtkiQpU=;
  b=mMp27Y1sjUoK49HqWDGfbGxosn+cbMyeDnu0zx+5z/OdK5T4uyKoAow2
   AP+oj3fDe9ajy6u6DyrNqIih2L4AaU8VFaNEX8f44vCYHU3EVUHsr0HmP
   J75as1qn2wYAk/bXblYHi/NoT/tE0GPNGjcQci6171TeT0s8+tNzaBs+k
   isd7z5IYLH2gDALL6am3iSq81tjrHwuvSifp8Z4i+GMkS34KYuGMehJzX
   IRamFbwDMyr1cNSEU3jmClz40Zsr3XWcf8KxAVF5z0A8MJraANGBbIazy
   Q1XUsLb8PH5P3sKB+18EDmA7/gsTfsqD73poeeiE2qEDZdE3wZHaFa8P9
   A==;
X-CSE-ConnectionGUID: 9kBgHXM/SY6C/gdJ2+t+IQ==
X-CSE-MsgGUID: ycpiZ5m3SLKbziJmKU3R5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="85149963"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="85149963"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 01:01:54 -0700
X-CSE-ConnectionGUID: S/uk6le0T/iC5vm4uR0gkw==
X-CSE-MsgGUID: jxDVSM65SRi7NwRx3mRcyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="242692254"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.153])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 01:01:49 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 9 Mar 2026 10:01:45 +0200 (EET)
To: Vishnu Sankar <vishnuocv@gmail.com>
cc: Mark Pearson <mpearson-lenovo@squebb.ca>, dmitry.torokhov@gmail.com, 
    hmh@hmh.eng.br, Hans de Goede <hansg@kernel.org>, corbet@lwn.net, 
    derekjohn.clark@gmail.com, linux-input@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, 
    linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
    vsankar@lenovo.com
Subject: Re: [PATCH v7 1/3] input: trackpoint - Enable doubletap by default
 on capable devices
In-Reply-To: <20260209063355.491189-2-vishnuocv@gmail.com>
Message-ID: <fdd1d48e-61b7-2543-8a30-c7ad416f5dd3@linux.intel.com>
References: <20260209063355.491189-1-vishnuocv@gmail.com> <20260209063355.491189-2-vishnuocv@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 9 Feb 2026, Vishnu Sankar wrote:

> Enable doubletap functionality by default on TrackPoint devices that
> support it. The feature is detected using firmware ID pattern matching
> (PNP: LEN03xxx) with a deny list of incompatible devices.
> 
> This provides immediate doubletap functionality without requiring
> userspace configuration. The hardware is enabled during device
> detection, while event filtering continues to be handled by the
> thinkpad_acpi driver as before.
> 
> Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
> Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> Changes in v7:
> - Removed unwanted comments
> - Removed psmouse_info ()
> 
> Changes in v6:
> - No Changes
> 
> Changes in v5:
> - Renamed function to trackpoint_is_dt_capable()
> - Simplified string comparison without sscanf()
> - Removed wrapper function as suggested
> - Fixed missing period in comment
> 
> Changes in v4:
> - Simplified approach: removed all sysfs attributes and user interface
> - Enable doubletap by default during device detection
> - Removed global variables and complex attribute infrastructure
> - Uses minimal firmware ID detection with deny list
> - Follows KISS principle as suggested by reviewers
> 
> Changes in v3:
> - No changes
> 
> Changes in v2:
> - Improve commit messages
> - Sysfs attributes moved to trackpoint.c
> - Removed unnecessary comments
> - Removed unnecessary debug messages
> - Using strstarts() instead of strcmp()
> - is_trackpoint_dt_capable() modified
> - Removed _BIT suffix and used BIT() define
> - Reverse the trackpoint_doubletap_status() logic to return error first
> - Removed export functions as a result of the design change
> - Changed trackpoint_dev->psmouse to parent_psmouse
> - The path of trackpoint.h is not changed
> ---
>  drivers/input/mouse/trackpoint.c | 45 ++++++++++++++++++++++++++++++++
>  drivers/input/mouse/trackpoint.h |  5 ++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpoint.c
> index 5f6643b69a2c..e12d76350252 100644
> --- a/drivers/input/mouse/trackpoint.c
> +++ b/drivers/input/mouse/trackpoint.c
> @@ -393,6 +393,45 @@ static int trackpoint_reconnect(struct psmouse *psmouse)
>  	return 0;
>  }
>  
> +/* List of known incapable device PNP IDs */
> +static const char * const dt_incompatible_devices[] = {
> +	"LEN0304",
> +	"LEN0306",
> +	"LEN0317",
> +	"LEN031A",
> +	"LEN031B",
> +	"LEN031C",
> +	"LEN031D",
> +};
> +
> +/*
> + * Checks if it's a doubletap capable device.
> + * The PNP ID format is "PNP: LEN030d PNP0f13".
> + */
> +static bool trackpoint_is_dt_capable(const char *pnp_id)
> +{
> +	size_t i;
> +
> +	if (!pnp_id)
> +		return false;
> +
> +	/* Must start with "PNP: LEN03" */
> +	if (!strstarts(pnp_id, "PNP: LEN03"))

Missing include.

> +		return false;
> +
> +	/* Ensure enough length before comparing */
> +	if (strlen(pnp_id) < 12)
> +		return false;
> +
> +	/* Check deny-list */
> +	for (i = 0; i < ARRAY_SIZE(dt_incompatible_devices); i++) {

Missing include for ARRAY_SIZE().

> +		if (!strncmp(pnp_id + 5,
> +			     dt_incompatible_devices[i], 7))

Fits to one line.

> +			return false;
> +	}
> +	return true;
> +}
> +
>  int trackpoint_detect(struct psmouse *psmouse, bool set_properties)
>  {
>  	struct ps2dev *ps2dev = &psmouse->ps2dev;
> @@ -470,6 +509,12 @@ int trackpoint_detect(struct psmouse *psmouse, bool set_properties)
>  		     psmouse->vendor, firmware_id,
>  		     (button_info & 0xf0) >> 4, button_info & 0x0f);
>  
> +	if (trackpoint_is_dt_capable(ps2dev->serio->firmware_id)) {
> +		error = trackpoint_write(ps2dev, TP_DOUBLETAP, TP_DOUBLETAP_ENABLE);
> +		if (error)
> +			psmouse_warn(psmouse, "Failed to enable doubletap: %d\n", error);
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/input/mouse/trackpoint.h b/drivers/input/mouse/trackpoint.h
> index eb5412904fe0..3e03cdb39449 100644
> --- a/drivers/input/mouse/trackpoint.h
> +++ b/drivers/input/mouse/trackpoint.h
> @@ -69,6 +69,8 @@
>  					/* (how hard it is to drag */
>  					/* with Z-axis pressed) */
>  
> +#define TP_DOUBLETAP		0x58	/* TrackPoint doubletap register */
> +
>  #define TP_MINDRAG		0x59	/* Minimum amount of force needed */
>  					/* to trigger dragging */
>  
> @@ -110,6 +112,9 @@
>  					   external device will be forced to 1 */
>  #define TP_MASK_EXT_TAG			0x04
>  
> +/* Doubletap register values */
> +#define TP_DOUBLETAP_ENABLE	0xFF	/* Enable value */
> +#define TP_DOUBLETAP_DISABLE	0xFE	/* Disable value */
>  
>  /* Power on Self Test Results */
>  #define TP_POR_SUCCESS		0x3B
> 

-- 
 i.

