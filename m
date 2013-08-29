From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 1/1] MAINTAINERS: Change maintainer for cyttsp driver
Date: Thu, 29 Aug 2013 11:48:57 +0200
Message-ID: <CABxcv=mOasXUvC301Dn3fGQqo2ipk_oYEaU8ht1VCJiz2bC8Sw@mail.gmail.com>
References: <1373838082-12372-1-git-send-email-javier@dowhile0.org>
	<1373838082-12372-2-git-send-email-javier@dowhile0.org>
	<51E4EEEA.4000208@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51E4EEEA.4000208@cypress.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ferruh Yigit <fery@cypress.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, ttdrivers@cypress.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Jul 16, 2013 at 8:57 AM, Ferruh Yigit <fery@cypress.com> wrote:
>
> On 07/15/2013 12:41 AM, Javier Martinez Canillas wrote:
>>
>> I haven't had time to work on this driver for a long time and
>> Ferruh has been doing a great job making it more generic,
>> adding support for new hardware and providing bug fixes.
>
> Thank you a lot for your work on cyttsp drivers,
> we would like to see your support back whenever you have time again.
> Your expertise/know-how on issue is valuable.
>
>
>>
>> So, let's make MAINTAINERS reflect reality and add him as the
>> cyttsp maintainer instead of me.
>>
>> Also, since Ferruh works for Cypress, we may change the driver
>> status from Maintained to Supported.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
>> ---
>>
>> Ferruh, please send your ack if you are willing to take over
>> maintainance of this driver.
>
>
> Acked-by: Ferruh Yigit <fery@cypress.com>
>
>
>>
>> Also, please confirm that you have been working on behalf of
>> Cypress instead of doing it on your free time. Otherwise we
>> should keep the driver status to maintained instead supported.
>
> Right, I am a Cypress employee and working on TrueTouch drivers.
>
>>
>> Thanks a lot and best regards,
>> Javier
>>
>>   MAINTAINERS |    4 ++--
>>   1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 9d771d9..4ba996c 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2458,9 +2458,9 @@ S:        Maintained
>>   F:    drivers/media/common/cypress_firmware*
>>     CYTTSP TOUCHSCREEN DRIVER
>> -M:     Javier Martinez Canillas <javier@dowhile0.org>
>> +M:     Ferruh Yigit <fery@cypress.com>
>>   L:    linux-input@vger.kernel.org
>> -S:     Maintained
>> +S:     Supported
>>   F:    drivers/input/touchscreen/cyttsp*
>>   F:    include/linux/input/cyttsp.h
>>
>
>
>
> --
>
> Regards,
> ferruh
>

Hi Dmitry and Henrik,

Any comments about this patch? It was sent a couple of months ago...

Thanks a lot and best regards,
Javier
