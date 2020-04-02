Return-Path: <SRS0=gVNk=5S=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9404BC43331
	for <linux-input@archiver.kernel.org>; Thu,  2 Apr 2020 08:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5282078E
	for <linux-input@archiver.kernel.org>; Thu,  2 Apr 2020 08:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387574AbgDBI20 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 2 Apr 2020 04:28:26 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:62250 "EHLO
        esa4.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbgDBI2Z (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 2 Apr 2020 04:28:25 -0400
IronPort-SDR: 86xBzyAXgimbX+yrEBnR5DlA1qZWKy9NK2pQBu7Sv5pdzhWQ4bKj6N8ZI/P+cWm+WJGQXxXLQl
 2SK6TGtxceLgJM/9qpsUBqscmlzb0SblY57AUF0wZAGwdtfP728CEGPg9UPczq2h+2hVXXNKKj
 aCWR3qcMa4wlQRVQq2msAQxyWpzN5guNpjJiz2GIn9ylxrM4LbLkPnl+oNAwnNLM9iYQtOKXZS
 fvteiXP0zWBQATbemmkRRoIgpz3JLE8lMCTUmJz64ZRl/XIyl4KIUcD6KcLJ5K+rWO17woFLpr
 OGc=
X-IronPort-AV: E=Sophos;i="5.72,335,1580803200"; 
   d="scan'208";a="47414252"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa4.mentor.iphmx.com with ESMTP; 02 Apr 2020 00:28:25 -0800
IronPort-SDR: HnzTHpxRUTPLRNdw7UbDjJKlLT6DsPKNnJPI2Qdn6c6fSQ+Y4IeOIDcJIpZujzqARSSyxStwLv
 S/tdsDmsqtfT69N5nQc4QxxVpvW+yBY6uoWknkWE9xAWzYXg0AXMxaRLLr3ItUDqH+oURiUZqr
 vzgWyD3lm/5wE16W9pZc1yA95k89WsTMKxYo8n+QU8lFuMEAwXlia221lXDHHJZ66c+hqsIIyQ
 ZoS8ePSeLFQwW5qZAtaELLht9nqIpiEHWSTBIx0I1dXCG4kf/SnGtVD7KqNBcU1AvwEb/9j1W/
 VYQ=
Subject: Re: [PATCH v10 13/55] dt-bindings: input: atmel: add suspend mode
 support
To:     Dmitry Osipenko <digetx@gmail.com>, <nick@shmanahar.org>,
        <dmitry.torokhov@gmail.com>, <jikos@kernel.org>,
        <benjamin.tissoires@redhat.com>, <bsz@semihalf.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <erosca@de.adit-jv.com>, <Andrew_Gabbasov@mentor.com>
References: <20200331105051.58896-1-jiada_wang@mentor.com>
 <20200331105051.58896-14-jiada_wang@mentor.com>
 <dd09ab5d-4e33-7ca0-9dfe-80be1cee307f@gmail.com>
From:   "Wang, Jiada" <jiada_wang@mentor.com>
Message-ID: <ea94e940-50c4-2857-fb4f-8e91ec7bcb5e@mentor.com>
Date:   Thu, 2 Apr 2020 17:28:18 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <dd09ab5d-4e33-7ca0-9dfe-80be1cee307f@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: svr-orw-mbx-04.mgc.mentorg.com (147.34.90.204) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi Dmitry

On 2020/04/02 0:42, Dmitry Osipenko wrote:
> 31.03.2020 13:50, Jiada Wang пишет:
>> Add suspend mode support for atmel touchscreen driver
>>
>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>> ---
>>   .../bindings/input/atmel,maxtouch.txt         |  9 ++++++++
>>   MAINTAINERS                                   |  1 +
>>   include/dt-bindings/input/atmel_mxt_ts.h      | 23 +++++++++++++++++++
>>   3 files changed, 33 insertions(+)
>>   create mode 100644 include/dt-bindings/input/atmel_mxt_ts.h
>>
>> diff --git a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
>> index c88919480d37..0307e7f7bb43 100644
>> --- a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
>> +++ b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
>> @@ -31,6 +31,15 @@ Optional properties for main touchpad device:
>>   
>>   - reset-gpios: GPIO specifier for the touchscreen's reset pin (active low)
>>   
>> +- atmel,suspend-mode: Select method used to suspend:
>> +    MXT_SUSPEND_DEEP_SLEEP - use T7 to suspend the device into deep sleep
>> +    MXT_SUSPEND_T9_CTRL - use T9.CTRL to turn off touch processing
>> +    MXT_SUSPEND_REGULATOR - use regulators to power down device during suspend
>> +    Definitions are in <dt-bindings/input/atmel_mxt_ts.h>.
>> +
>> +- vdd: Required supply regulator when MXT_SUSPEND_REGULATOR is used to suspend
>> +- avdd: Required supply regulator when MXT_SUSPEND_REGULATOR is used to suspend
> 
> Some of NVIDIA Tegra devices have a VDD regulator in a form of GPIO,
> which is turned off by default at a boot time, and thus, the
> power-regulator needs to be enabled by the driver at a probe time in
> order to power-up the touchscreen.
> 
> I think the VDD/AVDD description isn't correct because these are the
> essential power regulators, they aren't used only for the suspending.
> 
> What about something more generic, like this:
> 
> - vdd: phandle to Power supply regulator
> - avdd: phandle to Analog Power supply regulator
> 
I agree, will update with generic descriptions

Thanks,
Jiada
