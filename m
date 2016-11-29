From: Florian Vaussard <florian.vaussard@gmail.com>
Subject: Re: [PATCH 0/2] Input: drv266x: Fix misuse of regmap_update_bits
Date: Tue, 29 Nov 2016 18:24:16 +0100
Message-ID: <90cd6727-4394-1b93-b6fb-1c3d870df229@gmail.com>
References: <1480438754-14794-1-git-send-email-florian.vaussard@heig-vd.ch>
 <583DB6A3.8070305@ti.com>
Reply-To: florian.vaussard@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34186 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758169AbcK2RYV (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 29 Nov 2016 12:24:21 -0500
In-Reply-To: <583DB6A3.8070305@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Florian Vaussard <florian.vaussard@heig-vd.ch>

Hello Dan,

Le 29. 11. 16 à 18:10, Dan Murphy a écrit :
> Florian
> 
> On 11/29/2016 10:59 AM, Florian Vaussard wrote:
>> Hello,
>>
>> This series fixes similar misues of the regmap_update_bits() API found
>> inside the drv2665.c and drv2667.c drivers. More details can be found
>> in the message of each patch.
>>
>> Theses changes are not tested as I do not have the required hardware,
>> but the calls to regmap_update_bits() are clearly wrong in the current
>> code and the fix seems obvious. Any tests are warmly welcome.
>>
>> Best regards,
>> Florian
>>
>> Florian Vaussard (2):
>>   Input: drv2665: Fix misuse of regmap_update_bits
>>   Input: drv2667: Fix misuse of regmap_update_bits
> 
> Thanks for the patches what about the drv260x.c?
> 

>From what I can see, drv260x.c does not have such a bug. The calls to
regmap_update_bits(.., mask, value) in drv260x.c where value > 0 are using
DRV260X_LIB_SEL_MASK and DRV260X_STANDBY_MASK as masks. In both cases, the range
of 'value' is such that (mask & value) is not null (if 'value' is not null of
course). Thus no obvious problems here.

Best regards,
Florian
