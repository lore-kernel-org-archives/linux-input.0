From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v6 3/3] input: samsung-keypad - Add samsung keypad driver
Date: Tue, 03 Aug 2010 11:10:32 +0900
Message-ID: <00ea01cb32b1$115ae1c0$3410a540$%kim@samsung.com>
References: <4C4688BE.1080409@samsung.com>
 <20100721080725.GA21373@core.coreip.homeip.net> <4C46B777.9010808@samsung.com>
 <009501cb28d1$c54c9f00$4fe5dd00$%kim@samsung.com>
 <4C5636DC.5070703@samsung.com>
 <019a01cb31f4$226a8aa0$673f9fe0$%kim@samsung.com>
 <4C564C6A.9040204@samsung.com>
 <002f01cb3201$5da32480$18e96d80$%kim@samsung.com>
 <4C565D21.8050506@samsung.com>
 <003901cb320c$47daa960$d78ffc20$%kim@samsung.com>
 <20100802075827.GA11903@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20100802075827.GA11903@core.coreip.homeip.net>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Joonyoung Shim' <jy0922.shim@samsung.com>, linux-samsung-soc@vger.kernel.org, kyungmin.park@samsung.com, ben-linux@fluff.org, linux-input@vger.kernel.org, ch.naveen@samsung.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> 
> On Mon, Aug 02, 2010 at 03:30:57PM +0900, Kukjin Kim wrote:
> > Joonyoung Shim wrote:
> > >
> > > On 8/2/2010 2:12 PM, Kukjin Kim wrote:
> > > > Joonyoung Shim wrote:
> > > >> On 8/2/2010 12:38 PM, Kukjin Kim wrote:
> > > >>> Joonyoung Shim wrote:
> > > >>>> Hi, I came back from vacation.
> > > >>>>
> > > >>>>>>>> Do you have any feedback? If ok, i want to go to input tree
or
> samsung
> > > >>>>>>>> tree these added sched.h including.
> > > >>>>>>> I applied the patch adding samsung-keypad.c and the platform
data
> > > >>>>>>> arch/arm/plat-samsung/include/plat/keypad.h and I expect that
> > > >>>>>>> patches to actually enable keypad will go through appropriate
> > > >>>>>>> platform tree(s).
> > > >>>>>>>
> > > >>>>>> OK, the rest will go through samsung platform tree
> > > >>>>>>
> > > >>>>> Ok..will apply.
> > > >>>>>
> > > >>>> Kukjin, could you remove keypad.h on the commit "ARM: SAMSUNG:
> Add
> > > >>>> keypad device support" of the samsung platform tree. The keypad.h
file
> > > >>>> was included on input tree.
> > > >>>>
> > > >>
> > >
>
(http://git.kernel.org/?p=linux/kernel/git/dtor/input.git;a=commit;h=0fffed2
7f92d9d7
> > > >>>> a34de9fe017b7082b5958bb93)
> > > >>> You mean in plat-samsung/dev-keypad.c?
> > > >>> If remove inclusion plat/keypad.h in there, following build error
happens.
> > > >>>
> > > >> No. I mean to remove arch/arm/plat-samsung/include/plat/keypad.h
file on
> > > >> samsung platform tree, it was applied on input tree already. If
needs, i
> > > >> can repost.
> > > >>
> > > > If it is not small change like to remove a file in a patch, I think
should be re-
> > > submitted.
> > > > Will drop your previous patch in my tree.
> > > >
> > > >>> arch/arm/plat-samsung/dev-keypad.c:41: warning: 'struct
> > > >> samsung_keypad_platdata' declared inside parameter list
> > > >>> arch/arm/plat-samsung/dev-keypad.c:41: warning: its scope is only
this
> > > definition
> > > >> or declaration, which is probably not what you want
> > > >>> arch/arm/plat-samsung/dev-keypad.c: In function
> > > >> 'samsung_keypad_set_platdata':
> > > >>> arch/arm/plat-samsung/dev-keypad.c:50: error: invalid application
of
> 'sizeof'
> > > to
> > > >> incomplete type 'struct samsung_keypad_platdata'
> > > >>> arch/arm/plat-samsung/dev-keypad.c:54: error: dereferencing
pointer to
> > > >> incomplete type
> > > >>> arch/arm/plat-samsung/dev-keypad.c:55: error: dereferencing
pointer to
> > > >> incomplete type
> > > >>> arch/arm/plat-samsung/dev-keypad.c:55: error:
> 'samsung_keypad_cfg_gpio'
> > > >> undeclared (first use in this function)
> > > >>> arch/arm/plat-samsung/dev-keypad.c:55: error: (Each undeclared
identifier
> is
> > > >> reported only once
> > > >>> arch/arm/plat-samsung/dev-keypad.c:55: error: for each function it
> appears in.)
> > > >>> make[1]: *** [arch/arm/plat-samsung/dev-keypad.o] Error 1
> > > >>>
> > > >>> As you know, released 35 today. So we have no much time for this
merge
> > > >> window.
> > > >> I'm not sure about merge rule, but I think the compile problem can
be
> > > >> solved by merge to 36 of input tree and samsung platform tree.
> > > >
> > > > Hmm...actually, already informed about that on linux-next.
> > > > If it's just build problem, I or Dmitry can fix it. However, this is
not just that.
> > > > I cannot understand how your 'plat/keypad.h' was included to both of
patch.
> > >
> > > Please see the prior mail history. The keypad.h file is included only
at
> > > the 1/3 patch in the original patch set, but Dmitry applied the 3/3
> > > patch modified with keypad.h.
> > >
> > > The basic problem is that each patches be applied on two tree. It
makes
> > > compile errors at the one tree lacking keypad.h file because both tree
> > > share keypad.h file.
> > >
> > > There are two solutions, First, all patches go to one tree. Second, we
> > > wait for merging to 36 of both tree then apply platform patches.
> > >
> > > > And I'm not sure, should be 'plat/keypad.h' in which tree...
> > > >
> >
> > Hi Dmitry,
> >
> > How can/should I do for it?...Which way is better to us? :-)
> >
> >
> > Joonyoung,
> > Let's wait for Dmitry's reply.
> > I will holding drop your previous patch in my tree till that time.
> >
> 
> Kgene,
> 
> I will be sending pull request to Linus in the next day or so, so it
> will have plat/keypad.h as it is in my tree. Once you merge (with his or
> mine) you have an option to patching the plat/keypad.h with hooks that I
> removed, although I would prefer if you changed the way you initialize
> your devices since having the these hooks defeats the purpose of having
> config pointer in platform data. Another option would be to have a
> separate include file for the hooks, one that
> drivers/input/keyboard/samsung-keypad.c does not use.
> 
> Thanks.
> 
Hi Dmitry,

Hmm...I saw your pull request to Linus...ok...will replace new one which
don't have duplicate 'plat/keypad.h' in my tree.
But..in this case, I'm not sure which way is better to us...

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
