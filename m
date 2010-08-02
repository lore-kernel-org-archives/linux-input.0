From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH v6 3/3] input: samsung-keypad - Add samsung keypad driver
Date: Mon, 02 Aug 2010 13:41:14 +0900
Message-ID: <4C564C6A.9040204@samsung.com>
References: <1277724824-13308-1-git-send-email-jy0922.shim@samsung.com>
 <1277724824-13308-3-git-send-email-jy0922.shim@samsung.com>
 <4C32E21A.8080100@samsung.com>
 <013401cb1d66$5fbf3fb0$1f3dbf10$%kim@samsung.com>
 <4C33D859.9050708@samsung.com>
 <026901cb1f35$64c63470$2e529d50$%kim@samsung.com>
 <4C36D235.3040702@samsung.com> <4C4688BE.1080409@samsung.com>
 <20100721080725.GA21373@core.coreip.homeip.net> <4C46B777.9010808@samsung.com>
 <009501cb28d1$c54c9f00$4fe5dd00$%kim@samsung.com>
 <4C5636DC.5070703@samsung.com>
 <019a01cb31f4$226a8aa0$673f9fe0$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <019a01cb31f4$226a8aa0$673f9fe0$%kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, kyungmin.park@samsung.com, ben-linux@fluff.org, linux-input@vger.kernel.org, ch.naveen@samsung.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On 8/2/2010 12:38 PM, Kukjin Kim wrote:
> Joonyoung Shim wrote:
>> Hi, I came back from vacation.
>>
>>>>>> Do you have any feedback? If ok, i want to go to input tree or samsung
>>>>>> tree these added sched.h including.
>>>>> I applied the patch adding samsung-keypad.c and the platform data
>>>>> arch/arm/plat-samsung/include/plat/keypad.h and I expect that
>>>>> patches to actually enable keypad will go through appropriate
>>>>> platform tree(s).
>>>>>
>>>> OK, the rest will go through samsung platform tree
>>>>
>>> Ok..will apply.
>>>
>> Kukjin, could you remove keypad.h on the commit "ARM: SAMSUNG: Add
>> keypad device support" of the samsung platform tree. The keypad.h file
>> was included on input tree.
>> (http://git.kernel.org/?p=linux/kernel/git/dtor/input.git;a=commit;h=0fffed27f92d9d7
>> a34de9fe017b7082b5958bb93)
> 
> You mean in plat-samsung/dev-keypad.c?
> If remove inclusion plat/keypad.h in there, following build error happens.
> 

No. I mean to remove arch/arm/plat-samsung/include/plat/keypad.h file on
samsung platform tree, it was applied on input tree already. If needs, i 
can repost.

> arch/arm/plat-samsung/dev-keypad.c:41: warning: 'struct samsung_keypad_platdata' declared inside parameter list
> arch/arm/plat-samsung/dev-keypad.c:41: warning: its scope is only this definition or declaration, which is probably not what you want
> arch/arm/plat-samsung/dev-keypad.c: In function 'samsung_keypad_set_platdata':
> arch/arm/plat-samsung/dev-keypad.c:50: error: invalid application of 'sizeof' to incomplete type 'struct samsung_keypad_platdata'
> arch/arm/plat-samsung/dev-keypad.c:54: error: dereferencing pointer to incomplete type
> arch/arm/plat-samsung/dev-keypad.c:55: error: dereferencing pointer to incomplete type
> arch/arm/plat-samsung/dev-keypad.c:55: error: 'samsung_keypad_cfg_gpio' undeclared (first use in this function)
> arch/arm/plat-samsung/dev-keypad.c:55: error: (Each undeclared identifier is reported only once
> arch/arm/plat-samsung/dev-keypad.c:55: error: for each function it appears in.)
> make[1]: *** [arch/arm/plat-samsung/dev-keypad.o] Error 1
> 
> As you know, released 35 today. So we have no much time for this merge window.
> 

I'm not sure about merge rule, but I think the compile problem can be
solved by merge to 36 of input tree and samsung platform tree.
