From: Tai-hwa Liang <avatar@sentelic.com>
Subject: Re: [PATCH] Input: sentelic - filter on-pad clicks in absolute mode
Date: Tue, 3 Apr 2012 00:06:24 +0800 (CST)
Message-ID: <120403000525D.3978@cnaqrzbavhz.fragryvp.pbz>
References: <20120401183037.GA23849@timantti.taisia.fi> <4F79B620.7030800@canonical.com>
 <4F79BE70.90005@ohmu.fi> <4F79C029.3040606@canonical.com> <4F79C7A0.6060601@ohmu.fi>
 <20120402160416.GA6213@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hermod.sentelic.com ([203.69.18.19]:24936 "EHLO
	hermod.sentelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100Ab2DBQGa (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Apr 2012 12:06:30 -0400
In-Reply-To: <20120402160416.GA6213@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Oskari Saarenmaa <os@ohmu.fi>, Chase Douglas <chase.douglas@canonical.com>, linux-input@vger.kernel.org

On Mon, 2 Apr 2012, Dmitry Torokhov wrote:
> On Mon, Apr 02, 2012 at 06:37:04PM +0300, Oskari Saarenmaa wrote:
>> On 02/04/12 18:05, Chase Douglas wrote:
>>> On 04/02/2012 07:57 AM, Oskari Saarenmaa wrote:
>>>> On 02/04/12 17:22, Chase Douglas wrote:
>>>>> On 04/01/2012 11:30 AM, Oskari Saarenmaa wrote:
>>>>>> On-pad clicks in absolute positioning single-finger mode are reported
>>>>>> without the PHY_BTN bit set, the on-pad clicks are handled by userspace
>>>>>> so the kernel shouldn't report them as real clicks.
>>>>>
>>>>> What is the definition of an "on-pad" click?
>>>>
>>>> In this case it's a tap on the pad without actually clicking it.  The
>>>> Asus UX21 Zenbook has a touchpad that can be tapped or clicked.
>>>> Single-finger taps on it are reported by the touchpad with FSP_PB0_LBTN
>>>> flag set and FSP_PB0_PHY_BTN not set.
>>>
>>> So if I understand correctly, the device currently emits a "physical"
>>> left button click event when the clickpad is tapped. Your patch will
>>> prevent this event from being sent to userspace, since userspace does
>>> its own tap detection. Is that correct?
>>
>> Yes.  Without this patch there's no way to disable click-on-tap in
>> userspace.
>
> Makes sense to me. Tai-hwa, any objections?

   No objection.

 	Reviewed-by:	Tai-hwa Liang <avatar@sentelic.com>

> BTW, I think we should suppress creating vscroll, hscroll and probably
> flags attributes when touchpad is in absolute mode since they are not
> applicable there (via attribute group's visible() methos). I am always
> takig patches ;)
