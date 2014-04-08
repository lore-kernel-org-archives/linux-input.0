From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH 1/3] Input: synaptics-rmi4 - add capabilities for touchpads
Date: Mon, 7 Apr 2014 18:04:47 -0700
Message-ID: <53434B2F.4060304@synaptics.com>
References: <1395191031-3144-1-git-send-email-cheiny@synaptics.com> <5329A9CE.1080504@redhat.com> <20140328161505.GC22658@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [192.147.44.131] ([192.147.44.131]:12246 "EHLO
	us-mx2.synaptics.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1756395AbaDHBFS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Apr 2014 21:05:18 -0400
In-Reply-To: <20140328161505.GC22658@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On 03/28/2014 09:15 AM, Dmitry Torokhov wrote:
> On Wed, Mar 19, 2014 at 10:29:34AM -0400, Benjamin Tissoires wrote:
>> Hi Chris,
>>
>> On 03/18/2014 09:03 PM, Christopher Heiny wrote:
>>> When the device is a touchpad additional capabilities need to
>>> be set and reported.
>>>
>>
>> We have a problem here. While this patch would have been fine in the
>> pre-v3.8 era, it is not true anymore.
>> However, the current branch where synaptics-rmi4 is attached is v3.4.
>>
>> So if you use the right API (the current one), it will not compile :(
>>
>> Dmitry, would it be possible to update the branch to at least v3.8
>> to get the new input-mt API? (if the Synaptics guys are ok).
>
> If we are getting ready to pull it into mainline (and I think we are
> for F01 and F11 support) then I think I should simply uprev to the
> latest released kernel.

Looking at this further, we can rebase pretty easily to 3.9 or 3.10.

New kernels would be more work, as we don't currently have a dev 
platform available for those.  A quick nose around the intertubes shows 
some 3.14 implementations for at least one of our dev platforms 
(BeagleBone Black), so it's not like it would be painful - it'd just 
take soemwhat longer.

In either case, I'd like to get the current patch backlog addressed 
before rebasing.  That way the change set can be limited to those needed 
for the rebase.

Dmitry - how do you want to approach this?

					Chris
