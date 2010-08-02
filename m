From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v6 3/3] input: samsung-keypad - Add samsung keypad driver
Date: Mon, 02 Aug 2010 12:38:08 +0900
Message-ID: <019a01cb31f4$226a8aa0$673f9fe0$%kim@samsung.com>
References: <1277724824-13308-1-git-send-email-jy0922.shim@samsung.com>
	<1277724824-13308-3-git-send-email-jy0922.shim@samsung.com>
	<4C32E21A.8080100@samsung.com>
	<013401cb1d66$5fbf3fb0$1f3dbf10$%kim@samsung.com>
	<4C33D859.9050708@samsung.com>
	<026901cb1f35$64c63470$2e529d50$%kim@samsung.com>
	<4C36D235.3040702@samsung.com> <4C4688BE.1080409@samsung.com>
	<20100721080725.GA21373@core.coreip.homeip.net>
	<4C46B777.9010808@samsung.com>
	<009501cb28d1$c54c9f00$4fe5dd00$%kim@samsung.com>
	<4C5636DC.5070703@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <4C5636DC.5070703@samsung.com>
Content-language: ko
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: 'Joonyoung Shim' <jy0922.shim@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, kyungmin.park@samsung.com, ben-linux@fluff.org, linux-input@vger.kernel.org, ch.naveen@samsung.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Joonyoung Shim wrote:
> 
> Hi, I came back from vacation.
> 
> >>>> Do you have any feedback? If ok, i want to go to input tree or samsung
> >>>> tree these added sched.h including.
> >>> I applied the patch adding samsung-keypad.c and the platform data
> >>> arch/arm/plat-samsung/include/plat/keypad.h and I expect that
> >>> patches to actually enable keypad will go through appropriate
> >>> platform tree(s).
> >>>
> >> OK, the rest will go through samsung platform tree
> >>
> > Ok..will apply.
> >
> 
> Kukjin, could you remove keypad.h on the commit "ARM: SAMSUNG: Add
> keypad device support" of the samsung platform tree. The keypad.h file
> was included on input tree.
> (http://git.kernel.org/?p=linux/kernel/git/dtor/input.git;a=commit;h=0fffed27f92d9d7
> a34de9fe017b7082b5958bb93)

You mean in plat-samsung/dev-keypad.c?
If remove inclusion plat/keypad.h in there, following build error happens.

arch/arm/plat-samsung/dev-keypad.c:41: warning: 'struct samsung_keypad_platdata' declared inside parameter list
arch/arm/plat-samsung/dev-keypad.c:41: warning: its scope is only this definition or declaration, which is probably not what you want
arch/arm/plat-samsung/dev-keypad.c: In function 'samsung_keypad_set_platdata':
arch/arm/plat-samsung/dev-keypad.c:50: error: invalid application of 'sizeof' to incomplete type 'struct samsung_keypad_platdata'
arch/arm/plat-samsung/dev-keypad.c:54: error: dereferencing pointer to incomplete type
arch/arm/plat-samsung/dev-keypad.c:55: error: dereferencing pointer to incomplete type
arch/arm/plat-samsung/dev-keypad.c:55: error: 'samsung_keypad_cfg_gpio' undeclared (first use in this function)
arch/arm/plat-samsung/dev-keypad.c:55: error: (Each undeclared identifier is reported only once
arch/arm/plat-samsung/dev-keypad.c:55: error: for each function it appears in.)
make[1]: *** [arch/arm/plat-samsung/dev-keypad.o] Error 1

As you know, released 35 today. So we have no much time for this merge window.

> 
> >>> The only caveat is that I removed declarations for copying platform data
> >>> around and for gpio config function - if it is there there is no point
> >>> of invoking it through the pointer in platform data.
> >>>
> >> I agree, but currently samsung platform framework uses such this way. I
> >> believe these can change later at once.
> >>
> 
> Dmitry, could you apply original keypad.h. We can get problem such this
> on most samsung device driver too. As i said before, these can be fixed
> later.
> 
> >>> Overall I am confused why you set up keypad in platform code in the
> >>> way you do. I'd put the device definitions and all supporting functions
> >>> in the same module that registers platform device and be done with it.
> >>>
> >> Thanks.
> >
> >

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
