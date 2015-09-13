From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: ad714x: Convert to using managed resources
Date: Sun, 13 Sep 2015 00:01:23 -0700
Message-ID: <CAKdAkRTaPmLYszYS=eLamoqfhDRjgBbCjjTGQbVmHceSNAisxg@mail.gmail.com>
References: <20150912145618.GA2214@localhost>
	<20150912182228.GA11354@dtor-ws>
	<CAK-LDb+dQRKMchhjiT5_5_oP4CbjNp2_=d=gcBxdhc7NV1Ap_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:33858 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbbIMHBY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Sep 2015 03:01:24 -0400
In-Reply-To: <CAK-LDb+dQRKMchhjiT5_5_oP4CbjNp2_=d=gcBxdhc7NV1Ap_w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vaishali Thakkar <vthakkar1994@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, Sep 12, 2015 at 10:08 PM, Vaishali Thakkar
<vthakkar1994@gmail.com> wrote:
> On Sat, Sep 12, 2015 at 11:52 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> On Sat, Sep 12, 2015 at 08:26:18PM +0530, Vaishali Thakkar wrote:
>>> Use managed resource functions devm_request_threaded_irq,
>>> devm_inpute_allocate_device and devm_kzalloc to simplify
>>> error handling. Also, remove use of input_unregister_device
>>> as input_register_device itself handles it and works as
>>> resource managed function.
>>>
>>> To be compatible with the change, various gotos are replaced
>>> with direct returns, and unneeded labels are dropped. With
>>> these changes remove ad714x_remove and corresponding calls of
>>> it as they are now redundant.
>>>
>>> Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
>>> ---
>>> Please note that this patch is having three lines over 80
>>> characters as limiting them to 80 characters makes code
>>> less readable.
>>
>> You can actually remove input[input_alloc] and that will allow you to
>> stay witing 80 columnts. Does the following version still work for you?
>
> Sure. This makes perfect sense. Thanks.
>
> Can I send v2 of a patch with all changes you suggested or would you
> like me to split this patch in 2 patches?

If the version I sent works for you there is no need to resend/splt.

Thanks.

-- 
Dmitry
