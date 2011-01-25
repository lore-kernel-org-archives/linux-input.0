From: Mark Lord <kernel@teksavvy.com>
Subject: Re: 2.6.36/2.6.37: broken compatibility with userspace input-utils
 ?
Date: Tue, 25 Jan 2011 09:28:23 -0500
Message-ID: <4D3EDE07.1080200@teksavvy.com>
References: <4D3C5F73.2050408@teksavvy.com> <20110124175456.GA17855@core.coreip.homeip.net> <4D3E1A08.5060303@teksavvy.com> <20110125005555.GA18338@core.coreip.homeip.net> <4D3E4DD1.60705@teksavvy.com> <20110125042016.GA7850@core.coreip.homeip.net> <4D3E5372.9010305@teksavvy.com> <20110125045559.GB7850@core.coreip.homeip.net> <4D3E59CA.6070107@teksavvy.com> <20110125052902.GC7850@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:27659 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753677Ab1AYO21 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Jan 2011 09:28:27 -0500
In-Reply-To: <20110125052902.GC7850@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, mchehab@redhat.com

On 11-01-25 12:29 AM, Dmitry Torokhov wrote:
> On Tue, Jan 25, 2011 at 12:04:10AM -0500, Mark Lord wrote:
>> On 11-01-24 11:55 PM, Dmitry Torokhov wrote:
>>> On Mon, Jan 24, 2011 at 11:37:06PM -0500, Mark Lord wrote:
..
>>> The options are:
>>>
>>> 1. Convert to EVIOCGKEYCODE2
>>> 2. Ignore errors from EVIOCGKEYCODE and go through all 65536 iterations.
>>
>> or 3. Revert/fix the in-kernel regression.
>>
>> The EVIOCGKEYCODE ioctl is supposed to return KEY_RESERVED for unmapped
>> (but value) keycodes, and only return -EINVAL when the keycode itself
>> is out of range.
> 
> You are inventing rules.  You are requesting a scancode->keycode
> mapping. If scancode is unknown/invalid for the device ioctl returns
> -EINVAL.

-EINVAL signals bad/invalid parameters.
That's NOT what is happening here.

> For unmapped - yes, either KEY_RESERVED or KEY_UNKNOWN should be
> returned. For invalid scancodes -EINVAL shoudl be returned. 

Exactly my point.  The scancode in question is 100% valid and mapable,
yet the kernel is rejecting it as -EINVAL.  Incorrect.

BUG. Regression. Breaks userspace. Must get fixed.

Cheers
