Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBC8C19F28
	for <linux-input@archiver.kernel.org>; Tue,  2 Aug 2022 18:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiHBSrw (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 2 Aug 2022 14:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiHBSrv (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 2 Aug 2022 14:47:51 -0400
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB05474DF
        for <linux-input@vger.kernel.org>; Tue,  2 Aug 2022 11:47:49 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id Iwvio9xK7nnjOIwvjoZh45; Tue, 02 Aug 2022 20:47:47 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 02 Aug 2022 20:47:47 +0200
X-ME-IP: 90.11.190.129
Message-ID: <f0faa492-e619-ee32-c8eb-fca7a35d2cde@wanadoo.fr>
Date:   Tue, 2 Aug 2022 20:47:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] HID: wacom: Simplify comments
Content-Language: en-US
To:     Ping Cheng <pinglinux@gmail.com>
Cc:     Ping Cheng <ping.cheng@wacom.com>,
        Jason Gerecke <jason.gerecke@wacom.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-input@vger.kernel.org
References: <bb1df380b64dd708f480261548fb303046352878.1659296372.git.christophe.jaillet@wanadoo.fr>
 <CAF8JNhJBwaxUqWXLEejirRRoFo7mM2y99cPTByCpgba0cDjOFg@mail.gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <CAF8JNhJBwaxUqWXLEejirRRoFo7mM2y99cPTByCpgba0cDjOFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Le 02/08/2022 à 20:41, Ping Cheng a écrit :
> Hi Christophe,
> 
> Thank you for cleaning up the driver code.
> 
> On Sun, Jul 31, 2022 at 12:51 PM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>>
>> Remove a left-over from commit 2874c5fd2842 ("treewide: Replace GPLv2
>> boilerplate/reference with SPDX - rule 152").
>> An empty comment block can be removed.
> 
> While you are here, can you update your patch to include the removal
> of the empty comment blocks and paths in the other three files:
> wacom.h, wacom_wac.h, and wacom_wac.c?

I'll send a v2.
Thanks for pointing it out.

CJ


> 
> Thanks,
> Ping
> 
>> While at it remove, also remove what is supposed to be the path/filename of
>> the file.
>> This is really low value... and wrong since commit 471d17148c8b
>> ("Input: wacom - move the USB (now hid) Wacom driver in drivers/hid")
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/hid/wacom_sys.c | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
>> index 194a2e327591..21612fdae9c3 100644
>> --- a/drivers/hid/wacom_sys.c
>> +++ b/drivers/hid/wacom_sys.c
>> @@ -1,13 +1,8 @@
>>   // SPDX-License-Identifier: GPL-2.0-or-later
>>   /*
>> - * drivers/input/tablet/wacom_sys.c
>> - *
>>    *  USB Wacom tablet support - system specific code
>>    */
>>
>> -/*
>> - */
>> -
>>   #include "wacom_wac.h"
>>   #include "wacom.h"
>>   #include <linux/input/mt.h>
>> --
>> 2.34.1
>>
> 

