Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D6AC433ED
	for <linux-input@archiver.kernel.org>; Thu, 15 Apr 2021 13:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE10961131
	for <linux-input@archiver.kernel.org>; Thu, 15 Apr 2021 13:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhDONje (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 15 Apr 2021 09:39:34 -0400
Received: from forward101j.mail.yandex.net ([5.45.198.241]:49658 "EHLO
        forward101j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230056AbhDONje (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 15 Apr 2021 09:39:34 -0400
X-Greylist: delayed 320 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Apr 2021 09:39:34 EDT
Received: from iva3-4874dd324817.qloud-c.yandex.net (iva3-4874dd324817.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:49a4:0:640:4874:dd32])
        by forward101j.mail.yandex.net (Yandex) with ESMTP id B69A61BE05D9;
        Thu, 15 Apr 2021 16:33:45 +0300 (MSK)
Received: from iva8-174eb672ffa9.qloud-c.yandex.net (iva8-174eb672ffa9.qloud-c.yandex.net [2a02:6b8:c0c:b995:0:640:174e:b672])
        by iva3-4874dd324817.qloud-c.yandex.net (mxback/Yandex) with ESMTP id JI89YSemc9-XjImR8tT;
        Thu, 15 Apr 2021 16:33:45 +0300
Authentication-Results: iva3-4874dd324817.qloud-c.yandex.net; dkim=pass
Received: by iva8-174eb672ffa9.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id Q6DFAUP7nk-XiKSj4Sv;
        Thu, 15 Apr 2021 16:33:44 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: UPD: hid-multitouch: goodix: hovering works as touch
To:     Dmitry Mastykin <dmastykin@astralinux.ru>,
        linux-input@vger.kernel.org
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Daniele Gobbetti <daniele@gobbetti.name>
References: <ab5ad25b-d39c-83fe-4a88-eebed7f8b23a@minko.me>
 <7b7af64e-8e70-3a9c-eee9-010574adc241@astralinux.ru>
From:   Vitaly Minko <vitaly@minko.me>
Message-ID: <8e25e7c4-53bd-98d5-35da-cb596f84e9c4@minko.me>
Date:   Thu, 15 Apr 2021 16:33:44 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <7b7af64e-8e70-3a9c-eee9-010574adc241@astralinux.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: ru
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hello Dmitry,


I have tested your patches on the kernel version 5.10.27. I had to add 
one define for I2C_DEVICE_ID_GOODIX_0113. Everything else was applied 
successfully.

The digitizer works fine now. So the original issue is solved. Both pen 
buttons also work as expected (right and middle mouse buttons).

All tests performed on One-Netbook A1.

Thanks a lot for your efforts. Could you please send me a private email 
with your credentials for sending a tip (I would like to buy you a coffee).


Best regards,

Vitaly


15.04.2021 10:13, Dmitry Mastykin wrote:
> Hi Vitaly,
>
> Yes, we made a quirk for separate non-multitouch processing of the 
> HID_DG_PEN application for Goodix gt7385p (I2C_DEVICE_ID_GOODIX_0113 
> == 0x0113). It works well, BTN_TOOL_PEN and BTN_TOUCH events have 
> right order.
> I attach patches for kernel 5.4
> Buttons support was very tricky, because the panel tries to imitate 
> eraser usage with combination of tip's and eraser's bits off and on, 
> seems that Windows driver needs this. In second patch we add 
> state-machines for pen buttons to simulate right and middle click. It 
> works also well with this panel/pen, but I'm not sure if it works with 
> other devices.
>
> Kind regards,
> Dmitry Mastykin
>
>
> On 4/14/21 6:35 PM, Vitaly Minko wrote:
>> Hello Dmitry,
>>
>>
>> I have faced with exactly the same problem. Have you managed to solve 
>> the issue?
>>
>> If yes, could you please share the patch?
>>
>> Thanks in advance!
>>
>>
>> Best regards,
>>
>> Vitaly
>>
