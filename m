From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: HTC: touchscreen driver
Date: Tue, 14 Jul 2009 23:48:13 -0700
Message-ID: <d6200be20907142348k6962ef63o9a6ae444ca1f065c@mail.gmail.com>
References: <20090710084323.GA6522@elf.ucw.cz>
	 <20090713202302.GC2569@elf.ucw.cz> <20090713205749.GE2569@elf.ucw.cz>
	 <20090713220726.GA28375@elf.ucw.cz>
	 <d6200be20907131829o77bce3d8w8f238bc079478368@mail.gmail.com>
	 <20090714094629.GB2076@elf.ucw.cz>
	 <d6200be20907141507s39b54cccq9f0cedc325d3a203@mail.gmail.com>
	 <20090714221638.GA6512@elf.ucw.cz>
	 <d6200be20907141545k2b40b790x1af853b89517891c@mail.gmail.com>
	 <5d5443650907142321r1a4381eel96b955d85cd87114@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752532AbZGOGsW@vger.kernel.org>
In-Reply-To: <5d5443650907142321r1a4381eel96b955d85cd87114@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Brian Swetland <swetland@google.com>, kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

2009/7/14 Trilok Soni <soni.trilok@gmail.com>:
> Hi Arve,
>
> 2009/7/15 Arve Hj=F8nnev=E5g <arve@android.com>:
>> On Tue, Jul 14, 2009 at 3:16 PM, Pavel Machek<pavel@ucw.cz> wrote:
>> ...
>>>> >> This driver only supports a subset of Synaptics' devices so a m=
ore
>>>> >> generic driver will eventually be needed. The patch below adds =
support
>>>> >> for a more recent but similar panel.
>>>> >
>>>> > Ok, that should be simple enough to apply, but lets do improveme=
nts
>>>> > when we cleaned the code enough for the mainline...?
>>>>
>>>> We need this change now. Your cleanup will cause conflicts for any=
one
>>>> using our driver, so it would be better if it includes all our fix=
es.
>>>
>>> Well, I don't expect you to use the cleaned-up driver as-is: I had =
to
>>> remove the wakelocks functionality as infrastructure is not in
>>> mainline.
>>
>> OK. The driver does not use wakelocks tough, only earlysuspend, so
>> your cleaned up version should be fully functional. The early suspen=
d
>> hooks are only used to save power in idle when the screen is off.
>>
>>> (Plus, I do not have hardware to test your latest version).
>>
>> True, but the protocol documentation is available:
>> http://www.synaptics.com/sites/default/files/511_000099_01F.pdf
>>
>>>
>>> Applying small patch on top of cleaned up driver should be better t=
han
>>> carrying whole driver itself, right?
>>
>> Perhaps, but the only problem I encountered with this driver so far
>> was when calling disable_irq from the interrupt handler stopped
>> working on non-smp systems in 2.6.30 (which is another patch you
>> should probably apply first).
>
> disable_irq review comment is already given in the patch posted on
> linux-input by Pavel. We should convert this driver to
> request_threaded_irq infrastructure instead. I have added linux-input
> ML in CC.
>

I looked into using request_threaded_irq a while ago, but decided it
was not worth it since I would still need to create the workqueue if
the interrupt was not available. However, if we drop support for
running without an irq then using request_threaded_irq should be
simpler.

--=20
Arve Hj=F8nnev=E5g
