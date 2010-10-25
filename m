From: Tom Vier <tom@triadsys.com>
Subject: Re: Bug#594089: keyboard-configuration: caps lock keycode problem
Date: Mon, 25 Oct 2010 09:37:26 -0400
Message-ID: <4CC58816.3090301@triadsys.com>
References: <20100823154353.2805.13525.reportbug@tom.tse> <20100903235540.GA9149@const> <4C866913.3030201@triadsys.com> <4C8E6861.1070502@triadsys.com> <20101024144150.GV24091@const.famille.thibault.fr> <20101025045003.GA1438@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp138.iad.emailsrvr.com ([207.97.245.138]:41959 "EHLO
	smtp138.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755465Ab0JYNqm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Oct 2010 09:46:42 -0400
In-Reply-To: <20101025045003.GA1438@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Samuel Thibault <sthibault@debian.org>, 594089@bugs.debian.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/25/2010 12:50 AM, Dmitry Torokhov wrote:
> On Sun, Oct 24, 2010 at 04:41:51PM +0200, Samuel Thibault wrote:
>> The short story is: Tom's keyboard sends all that when he presses caps
>> lock:
>>
>> press: 0x3a 0xe0 0x66
>> repeat: 0x3a
>> release: 0xba 0xe0 0xe6
>>
>> 0xe0 0x66 happens to be the "favorites" key on his keyboard with
>> internet navigation keys.  I thus believe there's a bug in his keyboard
>> that needs to be filtered at the kernel level.
>>
>> The long story can be read on http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=594089
>
> Hmm, the question is whether the real "favorites" key send the same
> usage and the fake one after caps lock. Any chance Tom could locate
> evtest utility and see what MSC_SCAN events being emitted?
>
> Thanks.

Sure. Here's caps-lock:

Event: time 1288013671.633008, -------------- Report Sync ------------
Event: time 1288013674.171812, type 4 (Misc), code 4 (ScanCode), value 70039
Event: time 1288013674.171853, type 1 (Key), code 58 (CapsLock), value 1
Event: time 1288013674.171862, -------------- Report Sync ------------
Event: time 1288013674.172210, type 17 (LED), code 1 (CapsLock), value 1
Event: time 1288013674.299553, type 4 (Misc), code 4 (ScanCode), value 70039
Event: time 1288013674.299580, type 1 (Key), code 58 (CapsLock), value 0
Event: time 1288013674.299593, -------------- Report Sync ------------


Right-shift (the other problem key):

Event: time 1288013798.388025, -------------- Report Sync ------------
Event: time 1288013800.742088, type 4 (Misc), code 4 (ScanCode), value 700e5
Event: time 1288013800.742130, type 1 (Key), code 54 (RightShift), value 1
Event: time 1288013800.742142, -------------- Report Sync ------------
Event: time 1288013800.861777, type 4 (Misc), code 4 (ScanCode), value 700e5
Event: time 1288013800.861812, type 1 (Key), code 54 (RightShift), value 0
Event: time 1288013800.861824, -------------- Report Sync ------------

--
Tom Vier <tom@triadsys.com>
Senior Net/Sys Admin
Triad Systems Engineering, Inc.
