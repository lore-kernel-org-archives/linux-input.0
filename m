From: Jeremy Huddleston <jeremyhu@freedesktop.org>
Subject: Re: hid_apple bug: arrow keys interpreted as Fn
Date: Tue, 19 May 2009 18:04:04 -0700
Message-ID: <B9186545-9C33-4ADA-A3D9-8B5A5DA377CE@freedesktop.org>
References: <3E66E0E0-3B2B-4F78-9A62-87015A842A47@freedesktop.org> <C3870FA0-209F-4D40-8923-34D594B75EB1@freedesktop.org> <4A132540.7070409@gmail.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cloud.CS.Berkeley.EDU ([128.32.36.234]:58680 "EHLO
	mail.outersquare.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754888AbZETBEK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 May 2009 21:04:10 -0400
In-Reply-To: <4A132540.7070409@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>


On May 19, 2009, at 14:31, Jiri Slaby wrote:

> On 05/19/2009 07:13 AM, Jeremy Huddleston wrote:
>> I'm sending this to you since you're the most recent maintainer  
>> listed
>> in hid_apple.c ... please let me know if I should look somewhere  
>> else...
>>
>> I've found a weird issue using hid_apple in a recent linux-2.6 git.
>> Pressing 3 arrow keys at once causes a problem whereby the third  
>> press
>> and the first release are interpreted as Fn instead of the actual  
>> key.
>>
>> From evtest.c (http://people.freedesktop.org/~whot/evtest.c):
>
> Could you rebuild your kernel with HID_DEBUG enabled, modprobe hid
> module with hid_debug=2, retry and send the resulting dmesg output?
>
> To me it now looks like the FN is sent from the kbd, but I might be
> wrong again.


I used debug=2 since hid doesn't know about hid_debug on my kernel  
(linux-2.6 git master as of a few hours ago)

starting, no keys pressed

press right:
May 19 18:01:14 aeris kernel: [  256.453247] drivers/hid/hid-core.c:  
report (size 8) (unnumbered)
May 19 18:01:14 aeris kernel: [  256.453259] drivers/hid/hid-core.c:  
report 0 (size 8) =  00 00 4f 00 00 00 00 00
May 19 18:01:14 aeris kernel: [  256.453278] hid-debug: input Keyboard. 
00e0 = 0
May 19 18:01:14 aeris kernel: [  256.453295] hid-debug: input Keyboard. 
00e1 = 0
May 19 18:01:14 aeris kernel: [  256.453304] hid-debug: input Keyboard. 
00e2 = 0
May 19 18:01:14 aeris kernel: [  256.453313] hid-debug: input Keyboard. 
00e3 = 0
May 19 18:01:14 aeris kernel: [  256.453322] hid-debug: input Keyboard. 
00e4 = 0
May 19 18:01:14 aeris kernel: [  256.453331] hid-debug: input Keyboard. 
00e5 = 0
May 19 18:01:14 aeris kernel: [  256.453340] hid-debug: input Keyboard. 
00e6 = 0
May 19 18:01:14 aeris kernel: [  256.453349] hid-debug: input Keyboard. 
00e7 = 0
May 19 18:01:14 aeris kernel: [  256.453359] hid-debug: input Keyboard. 
004f = 1
May 19 18:01:14 aeris kernel: [  256.453373] hid-debug: input 00ff. 
0003 = 0

press down:
May 19 18:01:17 aeris kernel: [  259.429256] drivers/hid/hid-core.c:  
report (size 8) (unnumbered)
May 19 18:01:17 aeris kernel: [  259.429268] drivers/hid/hid-core.c:  
report 0 (size 8) =  00 00 4f 51 00 00 00 00
May 19 18:01:17 aeris kernel: [  259.429288] hid-debug: input Keyboard. 
00e0 = 0
May 19 18:01:17 aeris kernel: [  259.429305] hid-debug: input Keyboard. 
00e1 = 0
May 19 18:01:17 aeris kernel: [  259.429315] hid-debug: input Keyboard. 
00e2 = 0
May 19 18:01:17 aeris kernel: [  259.429324] hid-debug: input Keyboard. 
00e3 = 0
May 19 18:01:17 aeris kernel: [  259.429333] hid-debug: input Keyboard. 
00e4 = 0
May 19 18:01:17 aeris kernel: [  259.429341] hid-debug: input Keyboard. 
00e5 = 0
May 19 18:01:17 aeris kernel: [  259.429350] hid-debug: input Keyboard. 
00e6 = 0
May 19 18:01:17 aeris kernel: [  259.429359] hid-debug: input Keyboard. 
00e7 = 0
May 19 18:01:17 aeris kernel: [  259.429370] hid-debug: input Keyboard. 
0051 = 1
May 19 18:01:17 aeris kernel: [  259.429423] hid-debug: input 00ff. 
0003 = 0

press left:
May 19 18:01:20 aeris kernel: [  262.469256] drivers/hid/hid-core.c:  
report (size 8) (unnumbered)
May 19 18:01:20 aeris kernel: [  262.469269] drivers/hid/hid-core.c:  
report 0 (size 8) =  00 00 01 01 01 01 01 01
May 19 18:01:20 aeris kernel: [  262.469289] hid-debug: input Keyboard. 
00e0 = 0
May 19 18:01:20 aeris kernel: [  262.469307] hid-debug: input Keyboard. 
00e1 = 0
May 19 18:01:20 aeris kernel: [  262.469316] hid-debug: input Keyboard. 
00e2 = 0
May 19 18:01:20 aeris kernel: [  262.469326] hid-debug: input Keyboard. 
00e3 = 0
May 19 18:01:20 aeris kernel: [  262.469334] hid-debug: input Keyboard. 
00e4 = 0
May 19 18:01:20 aeris kernel: [  262.469343] hid-debug: input Keyboard. 
00e5 = 0
May 19 18:01:20 aeris kernel: [  262.469352] hid-debug: input Keyboard. 
00e6 = 0
May 19 18:01:20 aeris kernel: [  262.469361] hid-debug: input Keyboard. 
00e7 = 0
May 19 18:01:20 aeris kernel: [  262.469372] hid-debug: input 00ff. 
0003 = 1

release right:
May 19 18:01:22 aeris kernel: [  264.981247] drivers/hid/hid-core.c:  
report (size 8) (unnumbered)
May 19 18:01:22 aeris kernel: [  264.981258] drivers/hid/hid-core.c:  
report 0 (size 8) =  00 00 51 50 00 00 00 00
May 19 18:01:22 aeris kernel: [  264.981278] hid-debug: input Keyboard. 
00e0 = 0
May 19 18:01:22 aeris kernel: [  264.981295] hid-debug: input Keyboard. 
00e1 = 0
May 19 18:01:22 aeris kernel: [  264.981304] hid-debug: input Keyboard. 
00e2 = 0
May 19 18:01:22 aeris kernel: [  264.981313] hid-debug: input Keyboard. 
00e3 = 0
May 19 18:01:22 aeris kernel: [  264.981322] hid-debug: input Keyboard. 
00e4 = 0
May 19 18:01:22 aeris kernel: [  264.981331] hid-debug: input Keyboard. 
00e5 = 0
May 19 18:01:22 aeris kernel: [  264.981340] hid-debug: input Keyboard. 
00e6 = 0
May 19 18:01:22 aeris kernel: [  264.981349] hid-debug: input Keyboard. 
00e7 = 0
May 19 18:01:22 aeris kernel: [  264.981359] hid-debug: input Keyboard. 
004f = 0
May 19 18:01:22 aeris kernel: [  264.981369] hid-debug: input Keyboard. 
0050 = 1
May 19 18:01:22 aeris kernel: [  264.981411] hid-debug: input 00ff. 
0003 = 0

release down:
May 19 18:01:25 aeris kernel: [  267.405254] drivers/hid/hid-core.c:  
report (size 8) (unnumbered)
May 19 18:01:25 aeris kernel: [  267.405267] drivers/hid/hid-core.c:  
report 0 (size 8) =  00 00 50 00 00 00 00 00
May 19 18:01:25 aeris kernel: [  267.405288] hid-debug: input Keyboard. 
00e0 = 0
May 19 18:01:25 aeris kernel: [  267.405304] hid-debug: input Keyboard. 
00e1 = 0
May 19 18:01:25 aeris kernel: [  267.405314] hid-debug: input Keyboard. 
00e2 = 0
May 19 18:01:25 aeris kernel: [  267.405323] hid-debug: input Keyboard. 
00e3 = 0
May 19 18:01:25 aeris kernel: [  267.405332] hid-debug: input Keyboard. 
00e4 = 0
May 19 18:01:25 aeris kernel: [  267.405340] hid-debug: input Keyboard. 
00e5 = 0
May 19 18:01:25 aeris kernel: [  267.405349] hid-debug: input Keyboard. 
00e6 = 0
May 19 18:01:25 aeris kernel: [  267.405359] hid-debug: input Keyboard. 
00e7 = 0
May 19 18:01:25 aeris kernel: [  267.405369] hid-debug: input Keyboard. 
0051 = 0
May 19 18:01:25 aeris kernel: [  267.405424] hid-debug: input 00ff. 
0003 = 0

release left:
May 19 18:01:26 aeris kernel: [  269.277246] drivers/hid/hid-core.c:  
report (size 8) (unnumbered)
May 19 18:01:26 aeris kernel: [  269.277258] drivers/hid/hid-core.c:  
report 0 (size 8) =  00 00 00 00 00 00 00 00
May 19 18:01:26 aeris kernel: [  269.277278] hid-debug: input Keyboard. 
00e0 = 0
May 19 18:01:26 aeris kernel: [  269.277295] hid-debug: input Keyboard. 
00e1 = 0
May 19 18:01:26 aeris kernel: [  269.277304] hid-debug: input Keyboard. 
00e2 = 0
May 19 18:01:26 aeris kernel: [  269.277313] hid-debug: input Keyboard. 
00e3 = 0
May 19 18:01:26 aeris kernel: [  269.277322] hid-debug: input Keyboard. 
00e4 = 0
May 19 18:01:26 aeris kernel: [  269.277331] hid-debug: input Keyboard. 
00e5 = 0
May 19 18:01:26 aeris kernel: [  269.277340] hid-debug: input Keyboard. 
00e6 = 0
May 19 18:01:26 aeris kernel: [  269.277349] hid-debug: input Keyboard. 
00e7 = 0
May 19 18:01:26 aeris kernel: [  269.277359] hid-debug: input Keyboard. 
0050 = 0
May 19 18:01:26 aeris kernel: [  269.277401] hid-debug: input 00ff. 
0003 = 0

