From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH] HID: Fix return value in hid-core.c
Date: Mon, 17 Sep 2012 16:41:16 +0530
Message-ID: <CAK9yfHzy16G3-C0Aaogxu0u1zvBfrQv824KOckPOFRUbKw4fAQ@mail.gmail.com>
References: <1347623177-14221-1-git-send-email-sachin.kamat@linaro.org>
	<alpine.LNX.2.00.1209171301500.31149@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:50230 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755748Ab2IQLLR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Sep 2012 07:11:17 -0400
Received: by vcbfo13 with SMTP id fo13so6038876vcb.19
        for <linux-input@vger.kernel.org>; Mon, 17 Sep 2012 04:11:16 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1209171301500.31149@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, patches@linaro.org

On 17 September 2012 16:32, Jiri Kosina <jkosina@suse.cz> wrote:
> On Fri, 14 Sep 2012, Sachin Kamat wrote:
>
>> Return -ENOMEM instead of -1 if memory allocation fails.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> ---
>>  drivers/hid/hid-core.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>> index 16d6454..1011a22 100644
>> --- a/drivers/hid/hid-core.c
>> +++ b/drivers/hid/hid-core.c
>> @@ -134,7 +134,7 @@ static int open_collection(struct hid_parser *parser, unsigned type)
>>                               parser->device->collection_size * 2, GFP_KERNEL);
>>               if (collection == NULL) {
>>                       hid_err(parser->device, "failed to reallocate collection array\n");
>> -                     return -1;
>> +                     return -ENOMEM;
>
> While you are at it, could you please update the return value in case the
> collection stack overflows? I'd go with EINVAL. Thanks.

Sure. I will update and re-send the patch.

>
>>               }
>>               memcpy(collection, parser->device->collection,
>>                       sizeof(struct hid_collection) *
>> --
>> 1.7.4.1
>>
>
> --
> Jiri Kosina
> SUSE Labs



-- 
With warm regards,
Sachin
