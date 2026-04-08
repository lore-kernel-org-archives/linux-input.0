Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FEC2BDC1C;
	Wed,  8 Apr 2026 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662893; cv=none; b=B3pShLZb2drTRt+73MTb2DCeWt7vYTWmo+/GO6+iiot5HJubR5Kj42SsjvX3s+3B41zkLayo6CdGDiAsJs351pGDkhirrlgI7IFw429C3hJEkbV93a8S1AkK0zVS5BkfkZXXmW19S8Dfq93vnYuGoSDePyhOC1kgauCRMd8PnDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662893; c=relaxed/simple;
	bh=48MwlT1A9+GO0W/yITpMdQDrXARf8VMcc3YtuzejUiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8tQOndn7G5w9nZlbV3v2A09iqtwon1fUQirApvP+41jUjabvuPQamrot7FQZkBs6q957/Z0xzo8q24KJzD0R1IM9OPHRYV0+BPOJKPqwbm+iEkO22+60BXXEOvof1/ZTYPEWBB3AsSAoRQBtY4HtR6xkjV3Lus/JEVuuuRUDjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGbsGSeI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGbsGSeI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF134C19421;
	Wed,  8 Apr 2026 15:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775662892;
	bh=48MwlT1A9+GO0W/yITpMdQDrXARf8VMcc3YtuzejUiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UGbsGSeIxjLT1vCr+d3ntplao68bluSsMkIsRWQMLerDOrpX+1zRdj6YxUhA7loPM
	 XFntd3g/czaXZk3qTiVwBWzwRjZsFcPJ+CVNyDpWEU9yVuCzMDgSBMWLpIUM2O6Qi+
	 jwdstrNhqXc6AZHUIn8SkmUGVGTqTzNBjKylXjFxxbb3NJDBRrw8SodlJ/nGuvlnzo
	 KodnmNHExOFAPHmtZlrRJ1/i57NvthrpDRh4MEdN8LMJLBY2gRdqgqRqAyi9crfKmN
	 pT+AiHUgY8Bg/UO+CnTc7gDQvR7W9HRZX+xt/JQdYf3WAXUfhh8Ryd/Njk8kT4Cjix
	 r4O8pGiQ8oWLg==
Date: Wed, 8 Apr 2026 17:41:28 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Zhouwang Huang <honjow311@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, denis.benato@linux.dev, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: core: add short report quirk and use it for GPD Win
 (2f24:0137)
Message-ID: <adZ2PTzQ05iObcGt@beelink>
References: <20260407173212.86942-1-honjow311@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260407173212.86942-1-honjow311@gmail.com>

Hi,

Definitely not a big fan of that new quirk. The issue is that current
hid-core fix is too restrictive because it doesn't have enough
information, like the actual allocated buffer size.

On Apr 08 2026, Zhouwang Huang wrote:
> Commit 9e2a17d2e808 ("HID: gpd: fix report descriptor on GPD Win
> handheld (2f24:0137)") used report_fixup to shrink Report Count from
> 63 to 11 so that short reports from firmware <= 1.09 would not be
> rejected by hid_report_raw_event().
> 
> However, firmware 1.10 fixed the report length and now sends the full
> 63 bytes.  Because report_fixup already shrank the descriptor,
> usbhid allocates a 12-byte URB buffer — far too small for the 64-byte
> transfer — causing continuous -EOVERFLOW on every interrupt-in URB.
> The HID report descriptor and bcdDevice are identical across firmware
> versions, so report_fixup cannot conditionally apply.

OK, so if a firmware already fixed the bug, I'll drop 9e2a17d2e808 from
for-next and not include it in the final 7.0 PR I'll need to send. We
can tell people to upgrade to the latest firmware while I work on a
proper fix.

BTW, technically we could also not change the report descriptor if we
detect the correct firmware version. That would be easier to implement
than a global quirk. But hopefully we won't have to do anything and get
the proper hid-core fix soon.

Cheers,
Benjamin

> 
> Replace the report_fixup driver with a new per-device quirk
> HID_QUIRK_ALLOW_SHORT_REPORTS.  When set, hid_report_raw_event()
> zero-pads short reports instead of rejecting them — the same behaviour
> the core had before commit 0a3fe972a7cb ("HID: core: Mitigate
> potential OOB by removing bogus memset()").  The descriptor is left
> unmodified so the URB buffer matches the declared report size and works
> with any firmware version.
> 
> Remove hid-gpd.c, its Kconfig entry and Makefile line; the device is
> now handled by hid-generic with the quirk applied from hid-quirks.c.
> 
> Fixes: 9e2a17d2e808 ("HID: gpd: fix report descriptor on GPD Win handheld (2f24:0137)")
> Signed-off-by: Zhouwang Huang <honjow311@gmail.com>
> ---
>  drivers/hid/Kconfig      | 10 --------
>  drivers/hid/Makefile     |  1 -
>  drivers/hid/hid-core.c   | 11 +++++----
>  drivers/hid/hid-gpd.c    | 52 ----------------------------------------
>  drivers/hid/hid-quirks.c |  2 ++
>  include/linux/hid.h      |  2 ++
>  6 files changed, 11 insertions(+), 67 deletions(-)
>  delete mode 100644 drivers/hid/hid-gpd.c
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 2159d0fb7020..c1d9f7c6a5f2 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -419,16 +419,6 @@ config HID_GLORIOUS
>  	  Support for Glorious PC Gaming Race mice such as
>  	  the Glorious Model O, O- and D.
>  
> -config HID_GPD
> -	tristate "GPD Win handheld OEM HID support"
> -	depends on USB_HID
> -	help
> -	  Report descriptor fix for the OEM USB HID interface (GameSir
> -	  2f24:0137) found on GPD Win handhelds. The firmware declares 63-byte
> -	  reports but only sends 11 bytes, which the HID core rejects.
> -
> -	  Say Y or M here if you use a GPD Win handheld with this interface.
> -
>  config HID_HOLTEK
>  	tristate "Holtek HID devices"
>  	depends on USB_HID
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index f69cd6015465..e01838239ae6 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -53,7 +53,6 @@ obj-$(CONFIG_HID_ELO)		+= hid-elo.o
>  obj-$(CONFIG_HID_EVISION)	+= hid-evision.o
>  obj-$(CONFIG_HID_EZKEY)		+= hid-ezkey.o
>  obj-$(CONFIG_HID_FT260)		+= hid-ft260.o
> -obj-$(CONFIG_HID_GPD)		+= hid-gpd.o
>  obj-$(CONFIG_HID_GEMBIRD)	+= hid-gembird.o
>  obj-$(CONFIG_HID_GFRM)		+= hid-gfrm.o
>  obj-$(CONFIG_HID_GLORIOUS)  += hid-glorious.o
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index f5587b786f87..52e86f927a38 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2057,10 +2057,13 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
>  		rsize = max_buffer_size;
>  
>  	if (csize < rsize) {
> -		hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %d)\n",
> -				     report->id, rsize, csize);
> -		ret = -EINVAL;
> -		goto out;
> +		if (!(hid->quirks & HID_QUIRK_ALLOW_SHORT_REPORTS)) {
> +			hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %d)\n",
> +					     report->id, rsize, csize);
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +		memset(cdata + csize, 0, rsize - csize);
>  	}
>  
>  	if ((hid->claimed & HID_CLAIMED_HIDDEV) && hid->hiddev_report_event)
> diff --git a/drivers/hid/hid-gpd.c b/drivers/hid/hid-gpd.c
> deleted file mode 100644
> index 5b4d203e2499..000000000000
> --- a/drivers/hid/hid-gpd.c
> +++ /dev/null
> @@ -1,52 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - *  HID report descriptor fixup for GPD Win handhelds.
> - *
> - *  The OEM HID interface (VID 2f24 / GameSir, PID 0137) declares Report ID 1
> - *  with Report Count 63 (8-bit fields) for both Input and Feature, but the
> - *  firmware only sends 11 bytes of payload after the report ID.
> - */
> -
> -#include <linux/hid.h>
> -#include <linux/module.h>
> -
> -#include "hid-ids.h"
> -
> -#define RDESC_LEN		38
> -#define RPT_COUNT_INPUT_OFF	21
> -#define RPT_COUNT_FEATURE_OFF	34
> -
> -static const __u8 *gpd_report_fixup(struct hid_device *hdev, __u8 *rdesc,
> -				    unsigned int *rsize)
> -{
> -	if (*rsize != RDESC_LEN)
> -		return rdesc;
> -
> -	if (rdesc[RPT_COUNT_INPUT_OFF - 1] == 0x95 &&
> -	    rdesc[RPT_COUNT_INPUT_OFF] == 0x3f &&
> -	    rdesc[RPT_COUNT_FEATURE_OFF - 1] == 0x95 &&
> -	    rdesc[RPT_COUNT_FEATURE_OFF] == 0x3f) {
> -		hid_info(hdev, "fixing report counts (63 -> 11 bytes)\n");
> -		rdesc[RPT_COUNT_INPUT_OFF] = 11;
> -		rdesc[RPT_COUNT_FEATURE_OFF] = 11;
> -	}
> -
> -	return rdesc;
> -}
> -
> -static const struct hid_device_id gpd_devices[] = {
> -	{ HID_USB_DEVICE(USB_VENDOR_ID_GAMESIR, USB_DEVICE_ID_GAMESIR_0137) },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(hid, gpd_devices);
> -
> -static struct hid_driver gpd_driver = {
> -	.name = "gpd",
> -	.id_table = gpd_devices,
> -	.report_fixup = gpd_report_fixup,
> -};
> -
> -module_hid_driver(gpd_driver);
> -
> -MODULE_DESCRIPTION("HID report descriptor fix for GPD Win handheld (GameSir 2f24:0137)");
> -MODULE_LICENSE("GPL");
> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> index f6be3ffee023..b9ae1442eba9 100644
> --- a/drivers/hid/hid-quirks.c
> +++ b/drivers/hid/hid-quirks.c
> @@ -97,6 +97,8 @@ static const struct hid_device_id hid_quirks[] = {
>  		HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_GAMEVICE, USB_DEVICE_ID_GAMEVICE_KISHI),
>  		HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_GAMESIR, USB_DEVICE_ID_GAMESIR_0137),
> +		HID_QUIRK_ALLOW_SHORT_REPORTS },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_DRIVING), HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FIGHTING), HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FLYING), HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index 31324609af4d..212dd13bfcfa 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -381,6 +381,7 @@ struct hid_item {
>   * | @HID_QUIRK_X_INVERT:
>   * | @HID_QUIRK_Y_INVERT:
>   * | @HID_QUIRK_IGNORE_MOUSE:
> + * | @HID_QUIRK_ALLOW_SHORT_REPORTS: accept shorter-than-expected reports, zero-pad
>   * | @HID_QUIRK_SKIP_OUTPUT_REPORTS:
>   * | @HID_QUIRK_SKIP_OUTPUT_REPORT_ID:
>   * | @HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP:
> @@ -408,6 +409,7 @@ struct hid_item {
>  #define HID_QUIRK_X_INVERT			BIT(12)
>  #define HID_QUIRK_Y_INVERT			BIT(13)
>  #define HID_QUIRK_IGNORE_MOUSE			BIT(14)
> +#define HID_QUIRK_ALLOW_SHORT_REPORTS		BIT(15)
>  #define HID_QUIRK_SKIP_OUTPUT_REPORTS		BIT(16)
>  #define HID_QUIRK_SKIP_OUTPUT_REPORT_ID		BIT(17)
>  #define HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP	BIT(18)
> -- 
> 2.53.0
> 
> 
