From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH v6 3/3] input: samsung-keypad - Add samsung keypad driver
Date: Mon, 02 Aug 2010 12:09:16 +0900
Message-ID: <4C5636DC.5070703@samsung.com>
References: <1277724824-13308-1-git-send-email-jy0922.shim@samsung.com>
 <1277724824-13308-3-git-send-email-jy0922.shim@samsung.com>
 <4C32E21A.8080100@samsung.com>
 <013401cb1d66$5fbf3fb0$1f3dbf10$%kim@samsung.com>
 <4C33D859.9050708@samsung.com>
 <026901cb1f35$64c63470$2e529d50$%kim@samsung.com>
 <4C36D235.3040702@samsung.com> <4C4688BE.1080409@samsung.com>
 <20100721080725.GA21373@core.coreip.homeip.net> <4C46B777.9010808@samsung.com>
 <009501cb28d1$c54c9f00$4fe5dd00$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <009501cb28d1$c54c9f00$4fe5dd00$%kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, linux-samsung-soc@vger.kernel.org, kyungmin.park@samsung.com, ben-linux@fluff.org, linux-input@vger.kernel.org, ch.naveen@samsung.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Hi, I came back from vacation.

>>>> Do you have any feedback? If ok, i want to go to input tree or samsung
>>>> tree these added sched.h including.
>>> I applied the patch adding samsung-keypad.c and the platform data
>>> arch/arm/plat-samsung/include/plat/keypad.h and I expect that
>>> patches to actually enable keypad will go through appropriate
>>> platform tree(s).
>>>
>> OK, the rest will go through samsung platform tree
>>
> Ok..will apply.
> 

Kukjin, could you remove keypad.h on the commit "ARM: SAMSUNG: Add 
keypad device support" of the samsung platform tree. The keypad.h file
was included on input tree.
(http://git.kernel.org/?p=linux/kernel/git/dtor/input.git;a=commit;h=0fffed27f92d9d7a34de9fe017b7082b5958bb93)

>>> The only caveat is that I removed declarations for copying platform data
>>> around and for gpio config function - if it is there there is no point
>>> of invoking it through the pointer in platform data.
>>>
>> I agree, but currently samsung platform framework uses such this way. I
>> believe these can change later at once.
>>

Dmitry, could you apply original keypad.h. We can get problem such this
on most samsung device driver too. As i said before, these can be fixed
later.

>>> Overall I am confused why you set up keypad in platform code in the
>>> way you do. I'd put the device definitions and all supporting functions
>>> in the same module that registers platform device and be done with it.
>>>
>> Thanks.
> 
> 
> Thanks.
> 
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
