From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH] Input: sentelic - filter on-pad clicks in absolute mode
Date: Mon, 02 Apr 2012 09:35:26 -0700
Message-ID: <4F79D54E.4060500@canonical.com>
References: <20120401183037.GA23849@timantti.taisia.fi> <4F79B620.7030800@canonical.com> <4F79BE70.90005@ohmu.fi> <4F79C029.3040606@canonical.com> <4F79C7A0.6060601@ohmu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:42587 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345Ab2DBQes (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Apr 2012 12:34:48 -0400
In-Reply-To: <4F79C7A0.6060601@ohmu.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oskari Saarenmaa <os@ohmu.fi>
Cc: Tai-hwa Liang <avatar@sentelic.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On 04/02/2012 08:37 AM, Oskari Saarenmaa wrote:
> On 02/04/12 18:05, Chase Douglas wrote:
>> On 04/02/2012 07:57 AM, Oskari Saarenmaa wrote:
>>> On 02/04/12 17:22, Chase Douglas wrote:
>>>> On 04/01/2012 11:30 AM, Oskari Saarenmaa wrote:
>>>>> On-pad clicks in absolute positioning single-finger mode are reported
>>>>> without the PHY_BTN bit set, the on-pad clicks are handled by userspace
>>>>> so the kernel shouldn't report them as real clicks.
>>>>
>>>> What is the definition of an "on-pad" click?
>>>
>>> In this case it's a tap on the pad without actually clicking it.  The
>>> Asus UX21 Zenbook has a touchpad that can be tapped or clicked.
>>> Single-finger taps on it are reported by the touchpad with FSP_PB0_LBTN
>>> flag set and FSP_PB0_PHY_BTN not set.
>>
>> So if I understand correctly, the device currently emits a "physical"
>> left button click event when the clickpad is tapped. Your patch will
>> prevent this event from being sent to userspace, since userspace does
>> its own tap detection. Is that correct?
> 
> Yes.  Without this patch there's no way to disable click-on-tap in 
> userspace.

Ok. May I suggest improving the commit message to distinguish between
taps and clicks. This was the cause of my confusion. I would suggest
something like:

"""

Input: sentelic - filter taps in absolute mode

Taps in absolute positioning single-finger mode are currently reported
as physical clicks by the driver. This should be handled by userspace,
not the kernel.

When a tap occurs, the FSP_PB0_LBTN bit is set, but the FSP_PB0_PHY_BTN
is not. We use this to filter out physical clicks from taps.

"""

Otherwise, the code looks right and the desired result makes sense, so:

Reviewed-by: Chase Douglas <chase.douglas@canonical.com>
