From: Chen Gang <gang.chen.5i5j-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drivers: Let several drivers depends on HAS_IOMEM for
 'devm_ioremap_resource'
Date: Sun, 20 Jul 2014 17:51:48 +0800
Message-ID: <53CB9134.7080705@gmail.com>
References: <201407130545.23004.marex@denx.de> <6823014.2plXDE9VA9@wuerfel> <53C7A819.40403@metafoo.de> <6485666.LVFO2YCEQx@wuerfel> <53C8114D.30601@nod.at> <53C86C10.2000608@gmail.com> <53C8CE59.3060103@nod.at> <53C8FA78.1020501@gmail.com> <53C8FC1E.9090003@nod.at> <CAF0htA6Vvp+d4=wPuqJJhT+FxEUoT9mbJ3_NQuEJTP-hniS-KQ@mail.gmail.com> <53C9612E.3040001@gmail.com> <53CB801D.1030603@gmail.com> <53CB8FBF.2070206@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53CB8FBF.2070206-/L3Ra7n9ekc@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>
Cc: Lennox Wu <lennox.wu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Tom Gundersen <teg-B22kvLQNl6c@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Liqin Chen <liqin.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, knaack.h-Mmb7MZpHnFY@public.gmane.org, Martin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Mischa.Jonker-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, cmetcalf-kv+TWInifGbQT0dZR+AlfA@public.gmane.orgMartin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, heiko.carstens@
List-Id: linux-input@vger.kernel.org

On 07/20/2014 05:45 PM, Richard Weinberger wrote:
> 
> 
> Am 20.07.2014 10:38, schrieb Chen Gang:
>> On 07/19/2014 02:02 AM, Chen Gang wrote:
>>>> 2014-07-18 18:51 GMT+08:00 Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>:
>>>>> Am 18.07.2014 12:44, schrieb Chen Gang:
>>>>>> On 07/18/2014 03:35 PM, Richard Weinberger wrote:
>>>>>>> Am 18.07.2014 02:36, schrieb Chen Gang:
>>>>>>>>
>>>>>>>> On 07/18/2014 02:09 AM, Richard Weinberger wrote:
>>>>>>>>> Am 17.07.2014 12:48, schrieb Arnd Bergmann:
>>>>>>>>>> AFAICT, NO_IOMEM only has a real purpose on UML these days. Could we take
>>>>>>>>>> a shortcut here and make COMPILE_TEST depend on !UML? Getting random stuff
>>>>>>>>>> to build on UML seems pointless to me and we special-case it in a number of
>>>>>>>>>> places already.
>>>>>>>>>
>>>>>>>>> If UML is the only arch without io memory the dependency on !UML seems
>>>>>>>>> reasonable to me. :-)
>>>>>>>>>
>>>>>>>>
>>>>>>>> For me, if only uml left, I suggest to implement dummy functions within
>>>>>>>> uml instead of let CONFIG_UML appear in generic include directory. And
>>>>>>>> then remove all HAS_IOMEM and NO_IOMEM from kernel.
>>>>>>>
>>>>>>> Erm, this is something completely different.
>>>>>>> I thought we're focusing on COMPILE_TEST?
>>>>>>>
>>>>>>
>>>>>> COMPILE_TEST is none-architecture specific, but UML is. So in generic
>>>>>> include folder, if we're focusing on choosing whether COMPILE_TEST or
>>>>>> UML, for me, I will choose COMPILE_TEST.
>>>>>>
>>>>>> If we're not only focusing on COMPILE_TEST, for me, if something only
>>>>>> depend on one architecture, I'd like to put them under "arch/*/" folder.
>>>>>>
>>>>>> Especially, after that, we can remove all HAS_IOMEM and NO_IOMEM, nobody
>>>>>> has to think of them again. :-)
>>>>>
>>>>> And then we end up with a solution that on UML a lot of completely useless
>>>>> drivers are build which fail in various interesting manners because you'll
>>>>> add stubs for all kinds of io memory related functions to arch/um/?
>>>>> We had this kind of discussion already. You'll need more than ioremap...
>>>>>
>>>>> I like Arnd's idea *much* more to make COMPILE_TEST depend on !UML.
>>>>>
>>>
>>> That will let UML itself against COMPILE_TEST (but all the other
>>> architectures not).
>>>
>>> And if let COMPILE_TEST depend on !UML, can we still remove all
>>> HAS_IOMEM and NO_IOMEM from kernel? (I guess so).
>>>
>>> If we can remove them, we can send related patch firstly -- that will
>>> let current discussion be in UML architecture wide instead of kernel
>>> wide.
>>>
>>
>> Next, I shall:
>>
>>  - Remove HAS_IOMEM and NO_IOMEM from kernel, firstly.
> 
> This needs to be last, otherwise lot's of stuff will break.
> 

OK, thanks, that sounds reasonable to me.

>>  - Try to make dummy IOMEM functions for score architecture.
>>
>>  - Continue discussing with UML for it.
> 
> If you find sane dummy functions for both UML and score I'm fine with it.
> 

For me, what you said is necessary, tile and s390 also need dummy IOMEM
when !PCI.

So for me, I shall implement them in "include/asm-generic", and let uml,
score, tile and s390 use dummy IOMEM when they need.

Welcome any other members ideas, suggestions and completions.


Thanks.
-- 
Chen Gang

Open share and attitude like air water and life which God blessed
