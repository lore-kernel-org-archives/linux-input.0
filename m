From: Jeremy Huddleston <jeremyhu@freedesktop.org>
Subject: Re: hid_apple bug: arrow keys interpreted as Fn
Date: Tue, 23 Jun 2009 08:10:12 -0700
Message-ID: <2871DE1B-76BB-49D2-900E-95687A62440F@freedesktop.org>
References: <3E66E0E0-3B2B-4F78-9A62-87015A842A47@freedesktop.org> <C3870FA0-209F-4D40-8923-34D594B75EB1@freedesktop.org> <4A132540.7070409@gmail.com> <B9186545-9C33-4ADA-A3D9-8B5A5DA377CE@freedesktop.org> <alpine.LNX.2.00.0905201615490.13917@wotan.suse.de> <2784A223-EE31-41FF-BD44-45E5BBDC9B75@freedesktop.org> <alpine.LNX.2.00.0906231504480.7457@wotan.suse.de>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cloud.CS.Berkeley.EDU ([128.32.36.234]:53435 "EHLO
	mail.outersquare.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753975AbZFWPKQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Jun 2009 11:10:16 -0400
In-Reply-To: <alpine.LNX.2.00.0906231504480.7457@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-input@vger.kernel.org


On Jun 23, 2009, at 06:07, Jiri Kosina wrote:

> On Wed, 20 May 2009, Jeremy Huddleston wrote:
>
>>>> press right:
>>>> May 19 18:01:14 aeris kernel: [  256.453247] drivers/hid/hid- 
>>>> core.c: report
>>>> (size 8) (unnumbered)
>>>> May 19 18:01:14 aeris kernel: [  256.453259] drivers/hid/hid- 
>>>> core.c: report
>>>> 0 (size 8) =  00 00 4f 00 00 00 00 00
>>> [ ... ]
>>>> press down:
>>>> May 19 18:01:17 aeris kernel: [  259.429256] drivers/hid/hid- 
>>>> core.c: report
>>>> (size 8) (unnumbered)
>>>> May 19 18:01:17 aeris kernel: [  259.429268] drivers/hid/hid- 
>>>> core.c: report
>>>> 0 (size 8) =  00 00 4f 51 00 00 00 00
>>> [ ... ]
>>>> press left:
>>>> May 19 18:01:20 aeris kernel: [  262.469256] drivers/hid/hid- 
>>>> core.c: report
>>>> (size 8) (unnumbered)
>>>> May 19 18:01:20 aeris kernel: [  262.469269] drivers/hid/hid- 
>>>> core.c: report
>>>> 0 (size 8) =  00 00 01 01 01 01 01 01
>>> [ ... ]
>>>> release right:
>>>> May 19 18:01:22 aeris kernel: [  264.981247] drivers/hid/hid- 
>>>> core.c: report
>>>> (size 8) (unnumbered)
>>>> May 19 18:01:22 aeris kernel: [  264.981258] drivers/hid/hid- 
>>>> core.c: report
>>>> 0 (size 8) =  00 00 51 50 00 00 00 00
>>> [ ... ]
>>>> release down:
>>>> May 19 18:01:25 aeris kernel: [  267.405254] drivers/hid/hid- 
>>>> core.c: report
>>>> (size 8) (unnumbered)
>>>> May 19 18:01:25 aeris kernel: [  267.405267] drivers/hid/hid- 
>>>> core.c: report
>>>> 0 (size 8) =  00 00 50 00 00 00 00 00
>>> [ ... ]
>>>> release left:
>>>> May 19 18:01:26 aeris kernel: [  269.277246] drivers/hid/hid- 
>>>> core.c: report
>>>> (size 8) (unnumbered)
>>>> May 19 18:01:26 aeris kernel: [  269.277258] drivers/hid/hid- 
>>>> core.c: report
>>>> 0 (size 8) =  00 00 00 00 00 00 00 00
>>> Do you have any chance to verify whether this works properly in a
>>> different operating system? It would require very specific handling
>>> violating the standard.
>> So in OSX, I certainly don't see the Fn misinterpretation.  There  
>> is another
>> odd behavior in OSX that is probably related to an underlying  
>> hardware quirk
>> that OSX just deals with more elegantly.
>>
>> In OSX, I see this behavior:
>>
>> press right:
>>  event received that right arrow pressed
>> press down:
>>  event received that down arrow pressed
>> press left:
>>  no event
>> release right:
>>  event received that right arrow released
>>  event received that left arrow pressed
>> release down:
>>  event received that down arrow released
>> release left:
>>  event received that left arrow released
>
> In fact, in your "press left" report, there is
>
> drivers/hid/hid-core.c: report (size 8) (unnumbered)
> drivers/hid/hid-core.c: report 0 (size 8) =  00 00 01 01 01 01 01 01
> hid-debug: input Keyboard.00e0 = 0
> hid-debug: input Keyboard.00e1 = 0
> hid-debug: input Keyboard.00e2 = 0
> hid-debug: input Keyboard.00e3 = 0
> hid-debug: input Keyboard.00e4 = 0
> hid-debug: input Keyboard.00e5 = 0
> hid-debug: input Keyboard.00e6 = 0
> hid-debug: input Keyboard.00e7 = 0
> hid-debug: input 00ff.0003 = 1
>
> Which signalizes that the keyboard thinks that "Fn" key has been  
> pressed.
> Can you please verify that pressing right-down-left-<something>  
> works in a
> same way as fn-<something>?

When I have right-down-left pressed, no other keys pressed generate  
any event that I can see by running evtest.  However, the

Yes.  I'm sorry that hasn't been clear in my description, but on OSX I  
do not see the misbehavior of the third arrow being seen as "Fn".  I  
see exactly the (expected) behavior listed in my quoted text and  
copied here.

So in short:

===OSX (correct, based on HW limitations)===
press right:
  event received that right arrow pressed
press down:
  event received that down arrow pressed
press left:
  no event (atleast as far as applications are told)
release right:
  event received that right arrow released
  event received that left arrow pressed
release down:
  event received that down arrow released
release left:
  event received that left arrow released


===Linux (wrong)===
press right:
  event received that right arrow pressed
press down:
  event received that down arrow pressed
press left:
  ### ERROR ### event received that Fn pressed
release right:
  event received that home pressed ## NOTE: Fn+left is home
  ### ERROR ### event that Fn released (so "right arrow" is still seen  
in a pressed state)
release down:
  event received that down arrow released
release left:
  event received that home released


