From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: hid_apple bug: arrow keys interpreted as Fn
Date: Tue, 23 Jun 2009 15:07:51 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0906231504480.7457@wotan.suse.de>
References: <3E66E0E0-3B2B-4F78-9A62-87015A842A47@freedesktop.org> <C3870FA0-209F-4D40-8923-34D594B75EB1@freedesktop.org> <4A132540.7070409@gmail.com> <B9186545-9C33-4ADA-A3D9-8B5A5DA377CE@freedesktop.org> <alpine.LNX.2.00.0905201615490.13917@wotan.suse.de>
 <2784A223-EE31-41FF-BD44-45E5BBDC9B75@freedesktop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42751 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754348AbZFWNHv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Jun 2009 09:07:51 -0400
In-Reply-To: <2784A223-EE31-41FF-BD44-45E5BBDC9B75@freedesktop.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeremy Huddleston <jeremyhu@freedesktop.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-input@vger.kernel.org

On Wed, 20 May 2009, Jeremy Huddleston wrote:

> > >press right:
> > >May 19 18:01:14 aeris kernel: [  256.453247] drivers/hid/hid-core.c: report
> > >(size 8) (unnumbered)
> > >May 19 18:01:14 aeris kernel: [  256.453259] drivers/hid/hid-core.c: report
> > >0 (size 8) =  00 00 4f 00 00 00 00 00
> >[ ... ]
> > >press down:
> > >May 19 18:01:17 aeris kernel: [  259.429256] drivers/hid/hid-core.c: report
> > >(size 8) (unnumbered)
> > >May 19 18:01:17 aeris kernel: [  259.429268] drivers/hid/hid-core.c: report
> > >0 (size 8) =  00 00 4f 51 00 00 00 00
> >[ ... ]
> > >press left:
> > >May 19 18:01:20 aeris kernel: [  262.469256] drivers/hid/hid-core.c: report
> > >(size 8) (unnumbered)
> > >May 19 18:01:20 aeris kernel: [  262.469269] drivers/hid/hid-core.c: report
> > >0 (size 8) =  00 00 01 01 01 01 01 01
> >[ ... ]
> > >release right:
> > >May 19 18:01:22 aeris kernel: [  264.981247] drivers/hid/hid-core.c: report
> > >(size 8) (unnumbered)
> > >May 19 18:01:22 aeris kernel: [  264.981258] drivers/hid/hid-core.c: report
> > >0 (size 8) =  00 00 51 50 00 00 00 00
> >[ ... ]
> > >release down:
> > >May 19 18:01:25 aeris kernel: [  267.405254] drivers/hid/hid-core.c: report
> > >(size 8) (unnumbered)
> > >May 19 18:01:25 aeris kernel: [  267.405267] drivers/hid/hid-core.c: report
> > >0 (size 8) =  00 00 50 00 00 00 00 00
> >[ ... ]
> > >release left:
> > >May 19 18:01:26 aeris kernel: [  269.277246] drivers/hid/hid-core.c: report
> > >(size 8) (unnumbered)
> > >May 19 18:01:26 aeris kernel: [  269.277258] drivers/hid/hid-core.c: report
> > >0 (size 8) =  00 00 00 00 00 00 00 00
> >Do you have any chance to verify whether this works properly in a
> >different operating system? It would require very specific handling
> >violating the standard.
> So in OSX, I certainly don't see the Fn misinterpretation.  There is another
> odd behavior in OSX that is probably related to an underlying hardware quirk
> that OSX just deals with more elegantly.
> 
> In OSX, I see this behavior:
> 
> press right:
>   event received that right arrow pressed
> press down:
>   event received that down arrow pressed
> press left:
>   no event
> release right:
>   event received that right arrow released
>   event received that left arrow pressed
> release down:
>   event received that down arrow released
> release left:
>   event received that left arrow released

In fact, in your "press left" report, there is

drivers/hid/hid-core.c: report (size 8) (unnumbered)
drivers/hid/hid-core.c: report 0 (size 8) =  00 00 01 01 01 01 01 01
hid-debug: input Keyboard.00e0 = 0
hid-debug: input Keyboard.00e1 = 0
hid-debug: input Keyboard.00e2 = 0
hid-debug: input Keyboard.00e3 = 0
hid-debug: input Keyboard.00e4 = 0
hid-debug: input Keyboard.00e5 = 0
hid-debug: input Keyboard.00e6 = 0
hid-debug: input Keyboard.00e7 = 0
hid-debug: input 00ff.0003 = 1

Which signalizes that the keyboard thinks that "Fn" key has been pressed. 
Can you please verify that pressing right-down-left-<something> works in a 
same way as fn-<something>?

Preferably both in linux and other operating system.

Thanks,

-- 
Jiri Kosina
SUSE Labs
