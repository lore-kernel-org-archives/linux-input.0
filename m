Return-Path: <SRS0=X7PX=EE=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F3AC55179
	for <linux-input@archiver.kernel.org>; Thu, 29 Oct 2020 16:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7831C20EDD
	for <linux-input@archiver.kernel.org>; Thu, 29 Oct 2020 16:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgJ2Qqk (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 29 Oct 2020 12:46:40 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:44835 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726105AbgJ2QqU (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 29 Oct 2020 12:46:20 -0400
Received: from [192.168.0.2] (ip5f5af455.dynamic.kabel-deutschland.de [95.90.244.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6408120643C72;
        Thu, 29 Oct 2020 17:46:18 +0100 (CET)
Subject: Re: Dell XPS 13 9310: PNP: DLL0991 PNP0f13 supports different bus
To:     Mario Limonciello <Mario.Limonciello@dell.com>
Cc:     it+linux-input@molgen.mpg.de, linux-input@vger.kernel.org
References: <22fc1c31-3fcc-c029-1fc5-26859a68da0d@molgen.mpg.de>
 <DM6PR19MB26367B8BBE1FE7912ABABC14FA140@DM6PR19MB2636.namprd19.prod.outlook.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <d9c42be7-8678-d4e7-48f3-533aef54c829@molgen.mpg.de>
Date:   Thu, 29 Oct 2020 17:46:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB26367B8BBE1FE7912ABABC14FA140@DM6PR19MB2636.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Dear Mario,


Am 29.10.20 um 17:21 schrieb Limonciello, Mario:

>> From: Paul Menzel <pmenzel@molgen.mpg.de>
>> Sent: Thursday, October 29, 2020 11:16

>> [EXTERNAL EMAIL]

>> On a Dell XPS 13 9310, Linux 5.9.1 from Debian Sid/unstable displays the
>> message below.
>>
>>       [    2.218614] psmouse serio1: synaptics: Your touchpad (PNP: DLL0991 PNP0f13) says it can support a different bus. If i2c-hid and hid-rmi are not used, you might want to try setting psmouse.synaptics_intertouch to 1 and report this to linux-input@vger.kernel.org.
>>
>> I am going to ask the user for a test of
>> `psmouse.synaptics_intertouch=1`, so the ID can be added to the force
>> list, but until know no Dell DLLXXXX ids show up there.
> 
> I happen to have one of these on my desk and on 5.10-rc1 I don't see this behavior:
> 
> $ sudo dmesg | grep DLL0945
> [    1.244165] i2c_hid i2c-DLL0945:00: supply vdd not found, using dummy regulator
> [    1.244201] i2c_hid i2c-DLL0945:00: supply vddl not found, using dummy regulator
> [    1.404053] input: DLL0945:00 06CB:CDE6 Mouse as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-2/i2c-DLL0945:00/0018:06CB:CDE6.0001/input/input6
> [    1.404134] input: DLL0945:00 06CB:CDE6 Touchpad as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-2/i2c-DLL0945:00/0018:06CB:CDE6.0001/input/input7
> [    1.404196] hid-generic 0018:06CB:CDE6.0001: input,hidraw0: I2C HID v1.00 Mouse [DLL0945:00 06CB:CDE6] on i2c-DLL094
> :00
> [   42.971148] input: DLL0945:00 06CB:CDE6 Mouse as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-2/i2c-DLL0945:00/0018:06CB:CDE6.0001/input/input12
> [   42.972073] input: DLL0945:00 06CB:CDE6 Touchpad as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-2/i2c-DLL0945:00/0018:06CB:CDE6.0001/input/input13
> [   42.972182] hid-multitouch 0018:06CB:CDE6.0001: input,hidraw0: I2C HID v1.00 Mouse [DLL0945:00 06CB:CDE6] on i2c-DLL0945:00
> 
> Can you please make sure that pinctrl_tigerlake is loaded?

Debian’s Linux configuration does not build the driver.

     # CONFIG_PINCTRL_TIGERLAKE is not set

I reported bug *linux: Select PINCTRL_TIGERLAKE to support current 
hardware* to Debian bug tracking system [1].

Thank you very much.


Kind regards,

Paul


[1]: https://bugs.debian.org/973372
