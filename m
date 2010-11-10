From: Jason Wessel <jason.wessel@windriver.com>
Subject: Re: [RFC/RFT] Reinject Alt+SysRq when no hotkeys have been pressed
Date: Wed, 10 Nov 2010 14:43:31 -0600
Message-ID: <4CDB03F3.3000006@windriver.com>
References: <20101109073416.GA14110@core.coreip.homeip.net> <4CDAFCE0.60002@windriver.com> <201011101227.51837.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:42368 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076Ab0KJUne (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Nov 2010 15:43:34 -0500
In-Reply-To: <201011101227.51837.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Maxim Levitsky <maximlevitsky@gmail.com>

On 11/10/2010 02:27 PM, Dmitry Torokhov wrote:
> On Wednesday, November 10, 2010 12:13:20 pm Jason Wessel wrote:
>> On 11/09/2010 01:34 AM, Dmitry Torokhov wrote:
>>> Now that KGDB knows how to release keys that have been pressed when
>>> entering the debugger the only issue left is that SysRq handler is too
>>> greedy and always swallows Alt+SysRq, causing print screen hotkey to
>>> stop working. The solution is to re-inject the key combo when user
>>> releases SysRq without pressing any other keys. The patch below does
>>> just that and also releases keys that have been pressed before we enter
>>> SysRq mode.
>>>
>>> Note that it depends on a patch to input core that will stop events
>>> injected by one input handler from reaching the very same input handler
>>> (attached).
>>>
>>> Comments/testing/suggestion are sought after.
>> I applied both patches and tested all the known failures cases I had on
>> my list and it looks good, for the non kdb cases.
>>
>> Tested-by: Jason Wessel <jason.wessel@windriver.com>
>>

>> However...  I also tested this with the kdb keyboard release
>> patches plus your latest 2 patches and we appear to have an
>> incompatibility.  The behavior is that when exiting kdb the print
>> screen trigger fires.  I had not had a chance to debug it as of
>> yet.
>>
>
> Hmm, let me think...
>

So I debugged it.  The key up events are peeled off in linear order
with the kdb release key code.

The sequence looks like this

down - alt
down - printScr
down - g           <-- Enters kdb

The kdb release code simulates the events
up - g
up - alt
up - printScr

That tells me we have something bad about the key events going on, or
that we care about release ordering in the release handler.

Jason
