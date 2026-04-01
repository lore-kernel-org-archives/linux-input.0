Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F241547D937
	for <linux-input@vger.kernel.org>; Wed,  1 Apr 2026 17:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775065242; cv=none; b=K3cTeH3NpIl2762ZGZufwPyYJhiJ9yfStRjGvOB9gxc+Zy2nDRznT7cwMuEfGhdgioDZ1b25r+H6bzlW4r77n2xKWBVMdmj+Zx8EFkUArMPClN3hSLDDh8c8JXKbjCO0OSXQWk0TbHSfW1Kibws2oUgxItBq/2jjD6SuoyqO7NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775065242; c=relaxed/simple;
	bh=jETJFmDzLG+xn/mptGxjZkoBLI5/UTLH1Zjl05oy6zE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5gYViNgCN/BxnUYlaC62yjXZX2SJdVqNcdoItpE5SXbPsYQiNjRs50wNUhX7buK9ZTNeyJN5VM1DAaY5YQIgrdOCVUDkf9pKMhHJO4As73ZUqaIg7rDWAjWdxNfi2bE7Vb5YcFOnHZyPg7UrPy+HlZ+JZYJJREV7yzkfDmoQ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W9BQ9ApA; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W9BQ9ApA"
Message-ID: <76510dfe-d6da-4398-a78c-a02c596d6f75@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775065239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPJvl03OMvaDc2B8pMNuuJg5KOn+6pycqLc7jF79zoI=;
	b=W9BQ9ApAmE3osoHpxoLcf85EPjlTbqnO7dUyYTEdVm9muGRYSjKkZdaZ1Eb4JhUu5uTv1P
	+nIVEcBH1fUjE+QN4+K+rGbyNsUYEbQf/a2Qw8ZsJGDD2W4C0hB9p5rlR/TmyfC/Jjfg7J
	jXYYkLNkRbSDeUrn4/3lf7k5hkZHp0c=
Date: Wed, 1 Apr 2026 19:40:32 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] HID: gpd: fix report descriptor on GPD Win handheld
 (2f24:0137)
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 honjow <honjow311@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260324013847.68024-1-honjow311@gmail.com>
 <6268c55d-2f1b-473c-b82d-1de1416d14b0@leemhuis.info>
Content-Language: en-US, it-IT, en-US-large
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <6268c55d-2f1b-473c-b82d-1de1416d14b0@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/31/26 08:25, Thorsten Leemhuis wrote:
> On 3/24/26 02:38, honjow wrote:
>> The OEM USB HID interface found on GPD Win handhelds (VID 2f24, registered
>> to ShenZhen HuiJiaZhi / GameSir, PID 0137) declares 63-byte Input and
>> Feature reports for Report ID 1, but the firmware only transfers 11 data
>> bytes per interrupt.
>>
>> Since commit 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing
>> bogus memset()"), the HID core rejects undersized reports instead of zero-
>> padding them. This breaks the device entirely on kernels >= v7.0-rc5.
>>
>> Fix it by patching the report descriptor in report_fixup(), reducing
>> Report Count from 63 to 11 for both Input and Feature.
>>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221271
>> Signed-off-by: honjow <honjow311@gmail.com>
>> ---
>>  drivers/hid/Kconfig   | 10 +++++++++
>>  drivers/hid/Makefile  |  1 +
>>  drivers/hid/hid-gpd.c | 52 +++++++++++++++++++++++++++++++++++++++++++
>>  drivers/hid/hid-ids.h |  3 +++
>>  4 files changed, 66 insertions(+)
>>  create mode 100644 drivers/hid/hid-gpd.c
>>
>> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>> index 10c12d8e65579..20c60f5aca4c5 100644
>> --- a/drivers/hid/Kconfig
>> +++ b/drivers/hid/Kconfig
>> @@ -419,6 +419,16 @@ config HID_GLORIOUS
>>  	  Support for Glorious PC Gaming Race mice such as
>>  	  the Glorious Model O, O- and D.
>>  
>> +config HID_GPD
>> +	tristate "GPD Win handheld OEM HID support"
> Hmmm, why does this need to be a config option? Can't this be enabled
> unconditionally? I ask in general, as it's just another point where
> things can go wrong. But I mainly ask because it's a regression fix –
> and from my understanding wrt to what Linus wants we don't expect users
> to turn some .config on to keep their hardware running (unless it can't
> be avoided at all costs).
>
> Ciao, Thorsten
>
Perhaps the place of this, just for affected kernel series that are out
(assuming stable has the bug, I haven't checked) is to do this on hid-generic,
otherwise it's a change of driver managing the device?
>> +	depends on USB_HID
>> +	help
>> +	  Report descriptor fix for the OEM USB HID interface (GameSir
>> +	  2f24:0137) found on GPD Win handhelds. The firmware declares 63-byte
>> +	  reports but only sends 11 bytes, which the HID core rejects.
>> +
>> +	  Say Y or M here if you use a GPD Win handheld with this interface.
>> +
>>  config HID_HOLTEK
>>  	tristate "Holtek HID devices"
>>  	depends on USB_HID
>> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
>> index 07dfdb6a49c59..03ef72ec4499f 100644
>> --- a/drivers/hid/Makefile
>> +++ b/drivers/hid/Makefile
>> @@ -53,6 +53,7 @@ obj-$(CONFIG_HID_ELO)		+= hid-elo.o
>>  obj-$(CONFIG_HID_EVISION)	+= hid-evision.o
>>  obj-$(CONFIG_HID_EZKEY)		+= hid-ezkey.o
>>  obj-$(CONFIG_HID_FT260)		+= hid-ft260.o
>> +obj-$(CONFIG_HID_GPD)		+= hid-gpd.o
>>  obj-$(CONFIG_HID_GEMBIRD)	+= hid-gembird.o
>>  obj-$(CONFIG_HID_GFRM)		+= hid-gfrm.o
>>  obj-$(CONFIG_HID_GLORIOUS)  += hid-glorious.o
>> diff --git a/drivers/hid/hid-gpd.c b/drivers/hid/hid-gpd.c
>> new file mode 100644
>> index 0000000000000..5b4d203e24995
>> --- /dev/null
>> +++ b/drivers/hid/hid-gpd.c
>> @@ -0,0 +1,52 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + *  HID report descriptor fixup for GPD Win handhelds.
>> + *
>> + *  The OEM HID interface (VID 2f24 / GameSir, PID 0137) declares Report ID 1
>> + *  with Report Count 63 (8-bit fields) for both Input and Feature, but the
>> + *  firmware only sends 11 bytes of payload after the report ID.
>> + */
>> +
>> +#include <linux/hid.h>
>> +#include <linux/module.h>
>> +
>> +#include "hid-ids.h"
>> +
>> +#define RDESC_LEN		38
>> +#define RPT_COUNT_INPUT_OFF	21
>> +#define RPT_COUNT_FEATURE_OFF	34
>> +
>> +static const __u8 *gpd_report_fixup(struct hid_device *hdev, __u8 *rdesc,
>> +				    unsigned int *rsize)
>> +{
>> +	if (*rsize != RDESC_LEN)
>> +		return rdesc;
>> +
>> +	if (rdesc[RPT_COUNT_INPUT_OFF - 1] == 0x95 &&
>> +	    rdesc[RPT_COUNT_INPUT_OFF] == 0x3f &&
>> +	    rdesc[RPT_COUNT_FEATURE_OFF - 1] == 0x95 &&
>> +	    rdesc[RPT_COUNT_FEATURE_OFF] == 0x3f) {
>> +		hid_info(hdev, "fixing report counts (63 -> 11 bytes)\n");
>> +		rdesc[RPT_COUNT_INPUT_OFF] = 11;
>> +		rdesc[RPT_COUNT_FEATURE_OFF] = 11;
>> +	}
>> +
>> +	return rdesc;
>> +}
>> +
>> +static const struct hid_device_id gpd_devices[] = {
>> +	{ HID_USB_DEVICE(USB_VENDOR_ID_GAMESIR, USB_DEVICE_ID_GAMESIR_0137) },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(hid, gpd_devices);
>> +
>> +static struct hid_driver gpd_driver = {
>> +	.name = "gpd",
>> +	.id_table = gpd_devices,
>> +	.report_fixup = gpd_report_fixup,
>> +};
>> +
>> +module_hid_driver(gpd_driver);
>> +
>> +MODULE_DESCRIPTION("HID report descriptor fix for GPD Win handheld (GameSir 2f24:0137)");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index 933b7943bdb50..d0a6c19baa660 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -533,6 +533,9 @@
>>  #define USB_VENDOR_ID_FRUCTEL	0x25B6
>>  #define USB_DEVICE_ID_GAMETEL_MT_MODE	0x0002
>>  
>> +#define USB_VENDOR_ID_GAMESIR		0x2f24
>> +#define USB_DEVICE_ID_GAMESIR_0137	0x0137
>> +
>>  #define USB_VENDOR_ID_GAMEVICE	0x27F8
>>  #define USB_DEVICE_ID_GAMEVICE_GV186	0x0BBE
>>  #define USB_DEVICE_ID_GAMEVICE_KISHI	0x0BBF
