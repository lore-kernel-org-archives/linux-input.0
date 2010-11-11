From: Jason Wessel <jason.wessel@windriver.com>
Subject: Re: [RFC/RFT] Reinject Alt+SysRq when no hotkeys have been pressed
Date: Thu, 11 Nov 2010 08:35:31 -0600
Message-ID: <4CDBFF33.6090803@windriver.com>
References: <20101109073416.GA14110@core.coreip.homeip.net> <4CDAFCE0.60002@windriver.com> <201011101227.51837.dmitry.torokhov@gmail.com> <4CDB03F3.3000006@windriver.com> <20101111014240.GF2121@core.coreip.homeip.net> <20101111085548.GF24415@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:37904 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754260Ab0KKOff (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Nov 2010 09:35:35 -0500
In-Reply-To: <20101111085548.GF24415@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Maxim Levitsky <maximlevitsky@gmail.com>

On 11/11/2010 02:55 AM, Dmitry Torokhov wrote:
> On Wed, Nov 10, 2010 at 05:42:41PM -0800, Dmitry Torokhov wrote:
>> On Wed, Nov 10, 2010 at 02:43:31PM -0600, Jason Wessel wrote:
>>> On 11/10/2010 02:27 PM, Dmitry Torokhov wrote:
>>>> On Wednesday, November 10, 2010 12:13:20 pm Jason Wessel wrote:
>>>>> On 11/09/2010 01:34 AM, Dmitry Torokhov wrote:
>>>>>> Now that KGDB knows how to release keys that have been pressed when
>>>>>> entering the debugger the only issue left is that SysRq handler is too
>>>>>> greedy and always swallows Alt+SysRq, causing print screen hotkey to
>>>>>> stop working. The solution is to re-inject the key combo when user
>>>>>> releases SysRq without pressing any other keys. The patch below does
>>>>>> just that and also releases keys that have been pressed before we enter
>>>>>> SysRq mode.
>>>>>>
>>>>>> Note that it depends on a patch to input core that will stop events
>>>>>> injected by one input handler from reaching the very same input handler
>>>>>> (attached).
>>>>>>
>>>>>> Comments/testing/suggestion are sought after.
>>>>> I applied both patches and tested all the known failures cases I had on
>>>>> my list and it looks good, for the non kdb cases.
>>>>>
>>>>> Tested-by: Jason Wessel <jason.wessel@windriver.com>
>>>>>
>>>>> However...  I also tested this with the kdb keyboard release
>>>>> patches plus your latest 2 patches and we appear to have an
>>>>> incompatibility.  The behavior is that when exiting kdb the print
>>>>> screen trigger fires.  I had not had a chance to debug it as of
>>>>> yet.
>>>>>
>>>> Hmm, let me think...
>>>>
>>> So I debugged it.  The key up events are peeled off in linear order
>>> with the kdb release key code.
>>>
>>> The sequence looks like this
>>>
>>> down - alt
>>> down - printScr
>>> down - g           <-- Enters kdb
>>>
>>> The kdb release code simulates the events
>>> up - g
>>> up - alt
>>> up - printScr
>>>
>>> That tells me we have something bad about the key events going on, or
>>> that we care about release ordering in the release handler.
>>>
>> Ah, I see. I bet the shortcut for print screen is actually triggered on
>> _release_ and X drivers do not filter release events for which they have
>> not seen presses. Oh well...

That is in fact what was happening, and I probably should have mentioned that it was print screen handler that was trigging.

I tested you new patch with the prior sequence as well as the one that worked before which was:

down - alt
down - sysrq
up - sysrq
down - g

Both sequences work as desired with the latest patch.


I imagine we want to put this into a pull request for 37 as it is a regression, not being able to use alt-printScreen for the desktop OS's.

Acked-by: Jason Wessel <jason.wessel@windriver.com>

For anyone following the thread, the interdiff of Dmitry's original patch is below.

Thanks,
Jason.

diff -u b/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
--- b/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -633,6 +633,18 @@
                                 */
                                sysrq->need_reinject = true;
                        }
+
+                       /*
+                        * Pretend that sysrq was never pressed at all. This
+                        * is needed to properly handle KGDB which will try
+                        * to release all keys after exiting debugger. If we
+                        * do not clear key bit it KGDB will end up sending
+                        * release events for Alt and SysRq, potentially
+                        * triggering print screen function.
+                        */
+                       if (sysrq->active)
+                               clear_bit(KEY_SYSRQ, handle->dev->key);
+
                        break;
 
                default:

