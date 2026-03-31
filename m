Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1B530E0F1;
	Tue, 31 Mar 2026 06:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774938970; cv=none; b=BNKzmd58rq9fLkJqpVCtWuncJEPcbuZmC/E9nf3uOoPrrovDrGTK0J55/Jr5Y9o28XSEY8TkUacrb+VmJSrfhygc3davzsbjM7WC3sUDgV6xb9l/cayxcpLL1gXf3GVmUebvyHLARf0k20RBxdhZenZt6VMeA2UC1vHC2M75l+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774938970; c=relaxed/simple;
	bh=36F3BUnlnBlu2fCSx7Iv4KPJhZ4DMud+WtZkG2DTMvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HfgEaU61KRhTzDh/m7q2oqVIsBBXqkI/BWoKofqFEzgMmDNbtzYjscL3+dgI7tjDRzXMBupeNaTgOeIjOf+Q+1flIfThF0qeGHhl3We3x2lGbXWp/X17OjOXylNAXcgw63X4CYm4ESI1qIDTeMLGs6JFYTbirRYasGol1VAPuY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=QCrlpHCj; arc=none smtp.client-ip=188.68.63.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="QCrlpHCj"
Received: from mors-relay8203.netcup.net (localhost [127.0.0.1])
	by mors-relay8203.netcup.net (Postfix) with ESMTPS id 4flJ6C0XQMz8cnW;
	Tue, 31 Mar 2026 06:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1774938371;
	bh=36F3BUnlnBlu2fCSx7Iv4KPJhZ4DMud+WtZkG2DTMvE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QCrlpHCjVElXt9TEFQQugQLG2IqXZc/pu5XrVQJ1rFvdRG7/JOmtFcQ10gcBGmsWg
	 Wjaar9KMRK1hZ1L683P39WOLZM30zIswCadnGVd4dAd72PtddcHzFIfVDPMrFfzvn8
	 C9sheoizqjMIhrVDr4o4ZVTFZgZuYrEh6WpiUbMfxYO9NaWHOGALlhZPd0i+mU6w4I
	 5KZ3wa1rzUHCKiYlQDDnTKSAgVg6p81kqEYeT+l1JJBlGmZrU+A90RerF+OcLRaW/b
	 HB85jJ4EOwJyk4wAJHDTMEM/eJdSJw+vjJnuCdiD2LDBujnSlh/JNu2MgjWu32zHDS
	 ImSlr8IaWhDNw==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay8203.netcup.net (Postfix) with ESMTPS id 4flJ5r1Vzsz8Y7v;
	Tue, 31 Mar 2026 06:25:52 +0000 (UTC)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4flJ5q2sVCz8svf;
	Tue, 31 Mar 2026 08:25:51 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 8871E635B1;
	Tue, 31 Mar 2026 08:25:50 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <6268c55d-2f1b-473c-b82d-1de1416d14b0@leemhuis.info>
Date: Tue, 31 Mar 2026 08:25:49 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: gpd: fix report descriptor on GPD Win handheld
 (2f24:0137)
To: honjow <honjow311@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: denis.benato@linux.dev, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260324013847.68024-1-honjow311@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
X-Enigmail-Draft-Status: N11222
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
In-Reply-To: <20260324013847.68024-1-honjow311@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <177493835088.1692476.3241667397684077929@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 8871E635B1
X-NC-CID: sout73raQrIPAq3oGkQ7mEvzklwWCf/sm8bVStI3ljVUa40jBJQ=

On 3/24/26 02:38, honjow wrote:
> The OEM USB HID interface found on GPD Win handhelds (VID 2f24, registered
> to ShenZhen HuiJiaZhi / GameSir, PID 0137) declares 63-byte Input and
> Feature reports for Report ID 1, but the firmware only transfers 11 data
> bytes per interrupt.
> 
> Since commit 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing
> bogus memset()"), the HID core rejects undersized reports instead of zero-
> padding them. This breaks the device entirely on kernels >= v7.0-rc5.
> 
> Fix it by patching the report descriptor in report_fixup(), reducing
> Report Count from 63 to 11 for both Input and Feature.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221271
> Signed-off-by: honjow <honjow311@gmail.com>
> ---
>  drivers/hid/Kconfig   | 10 +++++++++
>  drivers/hid/Makefile  |  1 +
>  drivers/hid/hid-gpd.c | 52 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/hid/hid-ids.h |  3 +++
>  4 files changed, 66 insertions(+)
>  create mode 100644 drivers/hid/hid-gpd.c
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 10c12d8e65579..20c60f5aca4c5 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -419,6 +419,16 @@ config HID_GLORIOUS
>  	  Support for Glorious PC Gaming Race mice such as
>  	  the Glorious Model O, O- and D.
>  
> +config HID_GPD
> +	tristate "GPD Win handheld OEM HID support"

Hmmm, why does this need to be a config option? Can't this be enabled
unconditionally? I ask in general, as it's just another point where
things can go wrong. But I mainly ask because it's a regression fix –
and from my understanding wrt to what Linus wants we don't expect users
to turn some .config on to keep their hardware running (unless it can't
be avoided at all costs).

Ciao, Thorsten

> +	depends on USB_HID
> +	help
> +	  Report descriptor fix for the OEM USB HID interface (GameSir
> +	  2f24:0137) found on GPD Win handhelds. The firmware declares 63-byte
> +	  reports but only sends 11 bytes, which the HID core rejects.
> +
> +	  Say Y or M here if you use a GPD Win handheld with this interface.
> +
>  config HID_HOLTEK
>  	tristate "Holtek HID devices"
>  	depends on USB_HID
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index 07dfdb6a49c59..03ef72ec4499f 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -53,6 +53,7 @@ obj-$(CONFIG_HID_ELO)		+= hid-elo.o
>  obj-$(CONFIG_HID_EVISION)	+= hid-evision.o
>  obj-$(CONFIG_HID_EZKEY)		+= hid-ezkey.o
>  obj-$(CONFIG_HID_FT260)		+= hid-ft260.o
> +obj-$(CONFIG_HID_GPD)		+= hid-gpd.o
>  obj-$(CONFIG_HID_GEMBIRD)	+= hid-gembird.o
>  obj-$(CONFIG_HID_GFRM)		+= hid-gfrm.o
>  obj-$(CONFIG_HID_GLORIOUS)  += hid-glorious.o
> diff --git a/drivers/hid/hid-gpd.c b/drivers/hid/hid-gpd.c
> new file mode 100644
> index 0000000000000..5b4d203e24995
> --- /dev/null
> +++ b/drivers/hid/hid-gpd.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  HID report descriptor fixup for GPD Win handhelds.
> + *
> + *  The OEM HID interface (VID 2f24 / GameSir, PID 0137) declares Report ID 1
> + *  with Report Count 63 (8-bit fields) for both Input and Feature, but the
> + *  firmware only sends 11 bytes of payload after the report ID.
> + */
> +
> +#include <linux/hid.h>
> +#include <linux/module.h>
> +
> +#include "hid-ids.h"
> +
> +#define RDESC_LEN		38
> +#define RPT_COUNT_INPUT_OFF	21
> +#define RPT_COUNT_FEATURE_OFF	34
> +
> +static const __u8 *gpd_report_fixup(struct hid_device *hdev, __u8 *rdesc,
> +				    unsigned int *rsize)
> +{
> +	if (*rsize != RDESC_LEN)
> +		return rdesc;
> +
> +	if (rdesc[RPT_COUNT_INPUT_OFF - 1] == 0x95 &&
> +	    rdesc[RPT_COUNT_INPUT_OFF] == 0x3f &&
> +	    rdesc[RPT_COUNT_FEATURE_OFF - 1] == 0x95 &&
> +	    rdesc[RPT_COUNT_FEATURE_OFF] == 0x3f) {
> +		hid_info(hdev, "fixing report counts (63 -> 11 bytes)\n");
> +		rdesc[RPT_COUNT_INPUT_OFF] = 11;
> +		rdesc[RPT_COUNT_FEATURE_OFF] = 11;
> +	}
> +
> +	return rdesc;
> +}
> +
> +static const struct hid_device_id gpd_devices[] = {
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_GAMESIR, USB_DEVICE_ID_GAMESIR_0137) },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(hid, gpd_devices);
> +
> +static struct hid_driver gpd_driver = {
> +	.name = "gpd",
> +	.id_table = gpd_devices,
> +	.report_fixup = gpd_report_fixup,
> +};
> +
> +module_hid_driver(gpd_driver);
> +
> +MODULE_DESCRIPTION("HID report descriptor fix for GPD Win handheld (GameSir 2f24:0137)");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 933b7943bdb50..d0a6c19baa660 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -533,6 +533,9 @@
>  #define USB_VENDOR_ID_FRUCTEL	0x25B6
>  #define USB_DEVICE_ID_GAMETEL_MT_MODE	0x0002
>  
> +#define USB_VENDOR_ID_GAMESIR		0x2f24
> +#define USB_DEVICE_ID_GAMESIR_0137	0x0137
> +
>  #define USB_VENDOR_ID_GAMEVICE	0x27F8
>  #define USB_DEVICE_ID_GAMEVICE_GV186	0x0BBE
>  #define USB_DEVICE_ID_GAMEVICE_KISHI	0x0BBF

