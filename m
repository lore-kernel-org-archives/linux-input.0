From: Oskari Saarenmaa <os@ohmu.fi>
Subject: Re: [PATCH] Input: sentelic - filter on-pad clicks in absolute mode
Date: Mon, 02 Apr 2012 18:37:04 +0300
Message-ID: <4F79C7A0.6060601@ohmu.fi>
References: <20120401183037.GA23849@timantti.taisia.fi> <4F79B620.7030800@canonical.com> <4F79BE70.90005@ohmu.fi> <4F79C029.3040606@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [213.157.67.235] ([213.157.67.235]:44440 "EHLO mx0.taisia.fi"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751648Ab2DBPhm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Apr 2012 11:37:42 -0400
In-Reply-To: <4F79C029.3040606@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Tai-hwa Liang <avatar@sentelic.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On 02/04/12 18:05, Chase Douglas wrote:
> On 04/02/2012 07:57 AM, Oskari Saarenmaa wrote:
>> On 02/04/12 17:22, Chase Douglas wrote:
>>> On 04/01/2012 11:30 AM, Oskari Saarenmaa wrote:
>>>> On-pad clicks in absolute positioning single-finger mode are reported
>>>> without the PHY_BTN bit set, the on-pad clicks are handled by userspace
>>>> so the kernel shouldn't report them as real clicks.
>>>
>>> What is the definition of an "on-pad" click?
>>
>> In this case it's a tap on the pad without actually clicking it.  The
>> Asus UX21 Zenbook has a touchpad that can be tapped or clicked.
>> Single-finger taps on it are reported by the touchpad with FSP_PB0_LBTN
>> flag set and FSP_PB0_PHY_BTN not set.
>
> So if I understand correctly, the device currently emits a "physical"
> left button click event when the clickpad is tapped. Your patch will
> prevent this event from being sent to userspace, since userspace does
> its own tap detection. Is that correct?

Yes.  Without this patch there's no way to disable click-on-tap in 
userspace.

/ Oskari
