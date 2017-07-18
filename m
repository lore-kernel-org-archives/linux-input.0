From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: Re: [PATCH 0/2] use correct values for startup time bits for
 AXP22X/AXP8XX PEKs
Date: Tue, 18 Jul 2017 09:25:05 +0200
Message-ID: <1f2d37bd-b4a1-2653-c1c6-6dced95b814a@free-electrons.com>
References: <20170717095307.15986-1-quentin.schulz@free-electrons.com>
 <ce4d0385-a88b-d0cf-ee99-8b4b93f11244@free-electrons.com>
 <20170718071847.bkujmrmna72wqwb7@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:45861 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751203AbdGRHZH (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 18 Jul 2017 03:25:07 -0400
In-Reply-To: <20170718071847.bkujmrmna72wqwb7@dell>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: dmitry.torokhov@gmail.com, wens@csie.org, hdegoede@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, thomas.petazzoni@free-electrons.com, maxime.ripard@free-electrons.com

Hi Lee,

On 18/07/2017 09:18, Lee Jones wrote:
> On Mon, 17 Jul 2017, Quentin Schulz wrote:
> 
>> Hi all,
>>
>> On 17/07/2017 11:53, Quentin Schulz wrote:
>>> According to their datasheets, the AXP221, AXP223, AXP288, AXP803,
>>> AXP809 and AXP813 PEK have different values for startup time bits from
>>> the AXP20X PEK (which are currently used for all the aforementioned PMICs).
>>>
>>> This patch series adds support for platform_device_id to axp20x-pek driver
>>> to support different startup time bits depending on PMIC's variant and set
>>> the correct platform_device_id in the mfd.
>>>
>>> This has been tested on AXP813. To perform the test, modify the value of
>>> startup and/or shutdown of the pek in sysfs. Press the button soldered to
>>> PEK input of the AXP the amount of time you set in sysfs. The PMIC shuts
>>> down the board without needing to unplug any power supply. Press PEK button
>>> the amount of time you set in sysfs for startup and the PMIC will start the
>>> board. Note that the time bits are obivoulsy hardware reset to their
>>> default when you unplug all power supplies from the board.
>>>
>>
>> I forgot to add that it depends on this patch series (particularly the
>> third patch (3/6) "mfd: axp20x: Add support for AXP813 PMIC") from
>> Chen-Yu:
>> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1428284.html
> 
> So you are going to re-send?
> 

You put your acked-by just yesterday on this patch. Do I need to resend
it anyway?

The link I provided seems to be really slow/not working today, so I give
you another one for reference: https://patchwork.kernel.org/patch/9803439/

Thanks,
Quentin

>>> Quentin Schulz (2):
>>>   Input: axp20x-pek: add support for AXP221 PEK
>>>   mfd: axp20x: use correct platform device id for many PEK
>>>
>>>  drivers/input/misc/axp20x-pek.c | 62 ++++++++++++++++++++++++++++++++++-------
>>>  drivers/mfd/axp20x.c            | 12 ++++----
>>>  2 files changed, 58 insertions(+), 16 deletions(-)
>>>
>>
> 

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
