Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2BD3947AA;
	Tue, 14 Apr 2026 08:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.61.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776154293; cv=none; b=rdDfewO1G0XUpd2MQVJoz5Ur4SEfNHrHMzX/5VCRpC+0GRa7yk+67NWgrNApAPiMN12L4/CZ1/m5ooebnzfTGjZnQakpi5/V1DxCTfg6NPdEu9ZNORz6NHLbVvcvdj3sUTB8J/NpHiDcUQQGnFFdQmr11oU1BAa/N/FZq5tGT3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776154293; c=relaxed/simple;
	bh=3II7iFs9k1U9eqXK7mJNp1S6e2prLniTDEA66+b0H64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c6onuUZFq6P6jGbmkSZvpeGJGXW2l+I8WoazlQeO1jG8LwOEDqmMp/qnOZEFPlhSugVTmczbjBvF7UfwGxbZxwZaZRbQxZjUxlSlJCbA9mhfn5wIzuWaPhw3TsgmYMOrxMFtjX40tmr/4fBNPDUNzTJubQdVFDz/pU6ZmqXv3TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=dgwhulhm; arc=none smtp.client-ip=188.68.61.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="dgwhulhm"
Received: from mors-relay-8405.netcup.net (localhost [127.0.0.1])
	by mors-relay-8405.netcup.net (Postfix) with ESMTPS id 4fvxn41m8Sz74SJ;
	Tue, 14 Apr 2026 10:11:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1776154280;
	bh=3II7iFs9k1U9eqXK7mJNp1S6e2prLniTDEA66+b0H64=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dgwhulhmUPKv6z44pNyD5XNkC85t+0zDmHBSK3e+GuOoB6NQF3wRqS3pW/rFeZrCo
	 YpyEW0bH1jdUfFfIoNq3W548SG5vJFrSIds0ZuFhobgDR4q3Rn99WnjrQyGZT2AwfE
	 UDC7RNlMu92OGRpvfdvopn4puyFZzawJkctGjBuQHBEM7tr8rWAFQypcctjMlJKm0v
	 AC1NMdwqfAQ4VAXJbnhLrn2k4mfkfuwyxR36WwKbP9bCKIWGOgoZ/CUB6Qq9tSoJCp
	 YYOMuWvhudo124QvGQqrd6wxBNg+eqx4Qm6d5+II+KEHYv/Z/ZGAUpKbUBEwZHyjGn
	 4Qvc4mnY/vSjA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8405.netcup.net (Postfix) with ESMTPS id 4fvxn412R4z74SG;
	Tue, 14 Apr 2026 10:11:20 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4fvxn33XSKz8sbB;
	Tue, 14 Apr 2026 10:11:19 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 2FEA160305;
	Tue, 14 Apr 2026 10:11:18 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <652713b8-aa98-4ca7-8cd4-8f7ad6cff77f@leemhuis.info>
Date: Tue, 14 Apr 2026 10:11:17 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: core: add short report quirk and use it for GPD Win
 (2f24:0137)
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, denis.benato@linux.dev,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 honjow <honjow311@gmail.com>, Anj D <aduvnjak@hotmail.com>,
 Zhouwang Huang <honjow311@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260407173212.86942-1-honjow311@gmail.com>
 <adZ2PTzQ05iObcGt@beelink>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
X-Enigmail-Draft-Status: N11222
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
In-Reply-To: <adZ2PTzQ05iObcGt@beelink>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <177615427872.897500.17673503289321988800@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 2FEA160305
X-NC-CID: Gs6n8XE4DCV6qwuai70j8wNN5PI8UVILezZqgzGy+/hbPvjVzRg=

On 4/8/26 17:41, Benjamin Tissoires wrote:
> Definitely not a big fan of that new quirk. The issue is that current
> hid-core fix is too restrictive because it doesn't have enough
> information, like the actual allocated buffer size.
> 
> On Apr 08 2026, Zhouwang Huang wrote:
>> Commit 9e2a17d2e808 ("HID: gpd: fix report descriptor on GPD Win
>> handheld (2f24:0137)") used report_fixup to shrink Report Count from
>> 63 to 11 so that short reports from firmware <= 1.09 would not be
>> rejected by hid_report_raw_event().
>>
>> However, firmware 1.10 fixed the report length and now sends the full
>> 63 bytes.  Because report_fixup already shrank the descriptor,
>> usbhid allocates a 12-byte URB buffer — far too small for the 64-byte
>> transfer — causing continuous -EOVERFLOW on every interrupt-in URB.
>> The HID report descriptor and bcdDevice are identical across firmware
>> versions, so report_fixup cannot conditionally apply.
> 
> OK, so if a firmware already fixed the bug, I'll drop 9e2a17d2e808 from
> for-next and not include it in the final 7.0 PR I'll need to send.

Well, that meanwhile dropped commit 9e2a17d2e808 ("HID: gpd: fix report
descriptor on GPD Win handheld (2f24:0137)") was supposed to fix a
regression honjow (now CCed) reported on 2026-03-23:
https://bugzilla.kernel.org/show_bug.cgi?id=221271
https://lore.kernel.org/all/20260324013847.68024-1-honjow311@gmail.com/

So it is still unfixed as of now, I assume?

Side note: was honjow even notified about dropping the commit?

> We can tell people to upgrade to the latest firmware

Well, that should not be required by users when it comes to regressions
-- unless maybe no other way to fix a severe issue can be found. Is that
the case here?

> while I work on a proper fix.

How far is a proper fix away? And will that be GPD Win specific, or fix
issues with other issues, too. Because Anj D (now CCed) recently
reported a flooded dmesg caused by 0a3fe972a7cb ("HID: core: Mitigate
potential OOB by removing bogus memset()") with a APC UPS (USB VID/PID
051D:0002):
https://lore.kernel.org/all/MW5PR84MB135613E7947113897DD9FDA4C7272@MW5PR84MB1356.NAMPRD84.PROD.OUTLOOK.COM/

That's with 6.19.12, as the commit was recently backported to 6.18.y and
6.19.y.

Ciao, Thorsten

> BTW, technically we could also not change the report descriptor if we
> detect the correct firmware version. That would be easier to implement
> than a global quirk. But hopefully we won't have to do anything and get
> the proper hid-core fix soon.
> 
> Cheers,
> Benjamin
> 
>>
>> Replace the report_fixup driver with a new per-device quirk
>> HID_QUIRK_ALLOW_SHORT_REPORTS.  When set, hid_report_raw_event()
>> zero-pads short reports instead of rejecting them — the same behaviour
>> the core had before commit 0a3fe972a7cb ("HID: core: Mitigate
>> potential OOB by removing bogus memset()").  The descriptor is left
>> unmodified so the URB buffer matches the declared report size and works
>> with any firmware version.
>>
>> Remove hid-gpd.c, its Kconfig entry and Makefile line; the device is
>> now handled by hid-generic with the quirk applied from hid-quirks.c.
>>
>> Fixes: 9e2a17d2e808 ("HID: gpd: fix report descriptor on GPD Win handheld (2f24:0137)")
>> Signed-off-by: Zhouwang Huang <honjow311@gmail.com>
>> ---
>>  drivers/hid/Kconfig      | 10 --------
>>  drivers/hid/Makefile     |  1 -
>>  drivers/hid/hid-core.c   | 11 +++++----
>>  drivers/hid/hid-gpd.c    | 52 ----------------------------------------
>>  drivers/hid/hid-quirks.c |  2 ++
>>  include/linux/hid.h      |  2 ++
>>  6 files changed, 11 insertions(+), 67 deletions(-)
>>  delete mode 100644 drivers/hid/hid-gpd.c
>>
>> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>> index 2159d0fb7020..c1d9f7c6a5f2 100644
>> --- a/drivers/hid/Kconfig
>> +++ b/drivers/hid/Kconfig
>> @@ -419,16 +419,6 @@ config HID_GLORIOUS
>>  	  Support for Glorious PC Gaming Race mice such as
>>  	  the Glorious Model O, O- and D.
>>  
>> -config HID_GPD
>> -	tristate "GPD Win handheld OEM HID support"
>> -	depends on USB_HID
>> -	help
>> -	  Report descriptor fix for the OEM USB HID interface (GameSir
>> -	  2f24:0137) found on GPD Win handhelds. The firmware declares 63-byte
>> -	  reports but only sends 11 bytes, which the HID core rejects.
>> -
>> -	  Say Y or M here if you use a GPD Win handheld with this interface.
>> -
>>  config HID_HOLTEK
>>  	tristate "Holtek HID devices"
>>  	depends on USB_HID
>> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
>> index f69cd6015465..e01838239ae6 100644
>> --- a/drivers/hid/Makefile
>> +++ b/drivers/hid/Makefile
>> @@ -53,7 +53,6 @@ obj-$(CONFIG_HID_ELO)		+= hid-elo.o
>>  obj-$(CONFIG_HID_EVISION)	+= hid-evision.o
>>  obj-$(CONFIG_HID_EZKEY)		+= hid-ezkey.o
>>  obj-$(CONFIG_HID_FT260)		+= hid-ft260.o
>> -obj-$(CONFIG_HID_GPD)		+= hid-gpd.o
>>  obj-$(CONFIG_HID_GEMBIRD)	+= hid-gembird.o
>>  obj-$(CONFIG_HID_GFRM)		+= hid-gfrm.o
>>  obj-$(CONFIG_HID_GLORIOUS)  += hid-glorious.o
>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>> index f5587b786f87..52e86f927a38 100644
>> --- a/drivers/hid/hid-core.c
>> +++ b/drivers/hid/hid-core.c
>> @@ -2057,10 +2057,13 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
>>  		rsize = max_buffer_size;
>>  
>>  	if (csize < rsize) {
>> -		hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %d)\n",
>> -				     report->id, rsize, csize);
>> -		ret = -EINVAL;
>> -		goto out;
>> +		if (!(hid->quirks & HID_QUIRK_ALLOW_SHORT_REPORTS)) {
>> +			hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %d)\n",
>> +					     report->id, rsize, csize);
>> +			ret = -EINVAL;
>> +			goto out;
>> +		}
>> +		memset(cdata + csize, 0, rsize - csize);
>>  	}
>>  
>>  	if ((hid->claimed & HID_CLAIMED_HIDDEV) && hid->hiddev_report_event)
>> diff --git a/drivers/hid/hid-gpd.c b/drivers/hid/hid-gpd.c
>> deleted file mode 100644
>> index 5b4d203e2499..000000000000
>> --- a/drivers/hid/hid-gpd.c
>> +++ /dev/null
>> @@ -1,52 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0-or-later
>> -/*
>> - *  HID report descriptor fixup for GPD Win handhelds.
>> - *
>> - *  The OEM HID interface (VID 2f24 / GameSir, PID 0137) declares Report ID 1
>> - *  with Report Count 63 (8-bit fields) for both Input and Feature, but the
>> - *  firmware only sends 11 bytes of payload after the report ID.
>> - */
>> -
>> -#include <linux/hid.h>
>> -#include <linux/module.h>
>> -
>> -#include "hid-ids.h"
>> -
>> -#define RDESC_LEN		38
>> -#define RPT_COUNT_INPUT_OFF	21
>> -#define RPT_COUNT_FEATURE_OFF	34
>> -
>> -static const __u8 *gpd_report_fixup(struct hid_device *hdev, __u8 *rdesc,
>> -				    unsigned int *rsize)
>> -{
>> -	if (*rsize != RDESC_LEN)
>> -		return rdesc;
>> -
>> -	if (rdesc[RPT_COUNT_INPUT_OFF - 1] == 0x95 &&
>> -	    rdesc[RPT_COUNT_INPUT_OFF] == 0x3f &&
>> -	    rdesc[RPT_COUNT_FEATURE_OFF - 1] == 0x95 &&
>> -	    rdesc[RPT_COUNT_FEATURE_OFF] == 0x3f) {
>> -		hid_info(hdev, "fixing report counts (63 -> 11 bytes)\n");
>> -		rdesc[RPT_COUNT_INPUT_OFF] = 11;
>> -		rdesc[RPT_COUNT_FEATURE_OFF] = 11;
>> -	}
>> -
>> -	return rdesc;
>> -}
>> -
>> -static const struct hid_device_id gpd_devices[] = {
>> -	{ HID_USB_DEVICE(USB_VENDOR_ID_GAMESIR, USB_DEVICE_ID_GAMESIR_0137) },
>> -	{ }
>> -};
>> -MODULE_DEVICE_TABLE(hid, gpd_devices);
>> -
>> -static struct hid_driver gpd_driver = {
>> -	.name = "gpd",
>> -	.id_table = gpd_devices,
>> -	.report_fixup = gpd_report_fixup,
>> -};
>> -
>> -module_hid_driver(gpd_driver);
>> -
>> -MODULE_DESCRIPTION("HID report descriptor fix for GPD Win handheld (GameSir 2f24:0137)");
>> -MODULE_LICENSE("GPL");
>> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
>> index f6be3ffee023..b9ae1442eba9 100644
>> --- a/drivers/hid/hid-quirks.c
>> +++ b/drivers/hid/hid-quirks.c
>> @@ -97,6 +97,8 @@ static const struct hid_device_id hid_quirks[] = {
>>  		HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE },
>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_GAMEVICE, USB_DEVICE_ID_GAMEVICE_KISHI),
>>  		HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE },
>> +	{ HID_USB_DEVICE(USB_VENDOR_ID_GAMESIR, USB_DEVICE_ID_GAMESIR_0137),
>> +		HID_QUIRK_ALLOW_SHORT_REPORTS },
>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_DRIVING), HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FIGHTING), HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FLYING), HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
>> diff --git a/include/linux/hid.h b/include/linux/hid.h
>> index 31324609af4d..212dd13bfcfa 100644
>> --- a/include/linux/hid.h
>> +++ b/include/linux/hid.h
>> @@ -381,6 +381,7 @@ struct hid_item {
>>   * | @HID_QUIRK_X_INVERT:
>>   * | @HID_QUIRK_Y_INVERT:
>>   * | @HID_QUIRK_IGNORE_MOUSE:
>> + * | @HID_QUIRK_ALLOW_SHORT_REPORTS: accept shorter-than-expected reports, zero-pad
>>   * | @HID_QUIRK_SKIP_OUTPUT_REPORTS:
>>   * | @HID_QUIRK_SKIP_OUTPUT_REPORT_ID:
>>   * | @HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP:
>> @@ -408,6 +409,7 @@ struct hid_item {
>>  #define HID_QUIRK_X_INVERT			BIT(12)
>>  #define HID_QUIRK_Y_INVERT			BIT(13)
>>  #define HID_QUIRK_IGNORE_MOUSE			BIT(14)
>> +#define HID_QUIRK_ALLOW_SHORT_REPORTS		BIT(15)
>>  #define HID_QUIRK_SKIP_OUTPUT_REPORTS		BIT(16)
>>  #define HID_QUIRK_SKIP_OUTPUT_REPORT_ID		BIT(17)
>>  #define HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP	BIT(18)
>> -- 
>> 2.53.0
>>
>>
> 

