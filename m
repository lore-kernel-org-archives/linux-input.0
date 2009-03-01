From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] Input notifier support
Date: Sun, 1 Mar 2009 12:16:24 +0900
Message-ID: <9c9fda240902281916m221e1996gbfccd1d53b2ffa75@mail.gmail.com>
References: <20090225044730.GA9106@july> <87skly16gh.fsf@basil.nowhere.org>
	 <20090228164126.ZZRA012@mailhub.coreip.homeip.net>
	 <9c9fda240902281852n32b41cc7ref61dff7d5c1249f@mail.gmail.com>
	 <20090228190644.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.217.174]:48166 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755276AbZCADQ1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Feb 2009 22:16:27 -0500
In-Reply-To: <20090228190644.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi,

On Sun, Mar 1, 2009 at 12:07 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Sun, Mar 01, 2009 at 11:52:56AM +0900, Kyungmin Park wrote:
>> On Sun, Mar 1, 2009 at 9:42 AM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > On Sun, Mar 01, 2009 at 12:34:38AM +0100, Andi Kleen wrote:
>> >> Kyungmin Park <kmpark@infradead.org> writes:
>> >>
>> >> > Some hardware doesn't connected with key button and led. In this case key should be connected with led by software. Of course each application can control it however it's too big burden to application programmer.
>> >> >
>> >> > So add input notifier and then use it at other frameworks such as led.
>> >> > Of course, other input device can use this one.
>> >> >
>> >> > Any commnets are welcome.
>> >>
>> >> It looks like the perfect interface for a password stealing root kit.
>> >>
>> >> Yes there are probably other ways to do this, but still this seems to
>> >> make it very easy.
>> >>
>> >
>> > We already have good interface for that. That's why you want to limit
>> > access to /dev/input/eventX ;) and not make it world-readable.
>> >
>>
>> Hi Dmitry,
>>
>> Could you tell me know which interface you're talking?
>> I agreed it's not good idea to pass key code value to drivers. it
>> caused security issues.
>>
>
> The interface to steal the root password. One can simply open all input
> devices and read all events (if the process has sufficient rights).
>
"I don't think we need to do the notifier route. It is very easy to add
another input handler in style of rfkill-input or apm-power that would
listen to events from all ungrabbed input devices and act accordingly.
Your LED trigger example should work very well if implemented as another
input handler."

Ah, I mean the this one, sorry for confusing you. You mean add led
trigger using input handler.
Then my question how to know which input device is connected trigger
As know it's input device is allocated by dynamically then how do we
know which input event is used and set?

Thank you,
Kyungmin Park
