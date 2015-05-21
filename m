From: "Hn Chen" <hn.chen@weidahitech.com>
Subject: RE: [PATCH v3] Fix endian issues and remove the board specific codes
Date: Thu, 21 May 2015 15:43:08 +0800
Message-ID: <1A63A1423E772B419A9D2E882CBCF6C401FD49D8@mail>
References: <1431277899-28948-1-git-send-email-hn.chen@weidahitech.com> <20150521063316.GA30576@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ml01.weidahitech.com ([61.222.87.235]:1247 "EHLO
	ml01.weidahitech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbbEUHn0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 May 2015 03:43:26 -0400
Content-class: urn:content-classes:message
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi, Dmitry,

Thanks for your comments. 
Here are my replies for some comments.

> +	fw_id = ((fw_chunk_info.chunk_info.version_number >> 12) & 0xF);
> +	chip_id = (((dev_wdt87xx->sys_param.fw_id) >> 12) & 0xF);
> +
> +	if (fw_id != chip_id) {
> +		wdt87xx_get_sysparam(client, dev_wdt87xx);

>Why would it be different now?
This driver is intend to support two controllers, WDT8753 & WDT8756. 
The chip_id and the the firmware are different for them, so we have to check if 
The firmware is suitable for this controller.

> +
> +	return (unsigned short) y;

>I think I might have asked this before, by anyway: are we sure that we don't already have this checksum implementation in lib/? And if we don't maybe we should?
The MISR is a checksum function which the full name is "Multiple Input Signature Register". 
I checked the kernel library and not found any algorithm like this.
You mean I have to submit the checksum function into kernel/lib ?

> Can you tell me a bit more about the way device sends touch data? Does it always send all 10 contacts regardless of data in raw_buf[TOUCH_PK_OFFSET_FNGR_NUM]?
Yes, it always send all 10 contacts data.


Best Regards,
Hn.chen.
