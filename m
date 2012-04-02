From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH] Input: sentelic - filter on-pad clicks in absolute mode
Date: Mon, 02 Apr 2012 08:05:13 -0700
Message-ID: <4F79C029.3040606@canonical.com>
References: <20120401183037.GA23849@timantti.taisia.fi> <4F79B620.7030800@canonical.com> <4F79BE70.90005@ohmu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:42027 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656Ab2DBPEg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Apr 2012 11:04:36 -0400
In-Reply-To: <4F79BE70.90005@ohmu.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oskari Saarenmaa <os@ohmu.fi>
Cc: Tai-hwa Liang <avatar@sentelic.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On 04/02/2012 07:57 AM, Oskari Saarenmaa wrote:
> On 02/04/12 17:22, Chase Douglas wrote:
>> On 04/01/2012 11:30 AM, Oskari Saarenmaa wrote:
>>> On-pad clicks in absolute positioning single-finger mode are reported
>>> without the PHY_BTN bit set, the on-pad clicks are handled by userspace
>>> so the kernel shouldn't report them as real clicks.
>>
>> What is the definition of an "on-pad" click?
> 
> In this case it's a tap on the pad without actually clicking it.  The 
> Asus UX21 Zenbook has a touchpad that can be tapped or clicked.
> Single-finger taps on it are reported by the touchpad with FSP_PB0_LBTN 
> flag set and FSP_PB0_PHY_BTN not set.

So if I understand correctly, the device currently emits a "physical"
left button click event when the clickpad is tapped. Your patch will
prevent this event from being sent to userspace, since userspace does
its own tap detection. Is that correct?

-- Chase
