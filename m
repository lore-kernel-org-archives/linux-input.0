From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH 1/3] Input: synaptics-rmi4 - add capabilities for touchpads
Date: Fri, 21 Mar 2014 15:24:40 -0700
Message-ID: <532CBC28.9000301@synaptics.com>
References: <1395191031-3144-1-git-send-email-cheiny@synaptics.com> <5329A9CE.1080504@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:63566 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462AbaCUWYl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Mar 2014 18:24:41 -0400
In-Reply-To: <5329A9CE.1080504@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On 03/19/2014 07:29 AM, Benjamin Tissoires wrote:
> Hi Chris,
>
> On 03/18/2014 09:03 PM, Christopher Heiny wrote:
>> When the device is a touchpad additional capabilities need to
>> be set and reported.
>>
>
> We have a problem here. While this patch would have been fine in the
> pre-v3.8 era, it is not true anymore.
> However, the current branch where synaptics-rmi4 is attached is v3.4.
>
> So if you use the right API (the current one), it will not compile :(
>
> Dmitry, would it be possible to update the branch to at least v3.8 to
> get the new input-mt API? (if the Synaptics guys are ok).

Hi Benjamin,

Yes, v3.8 migration is OK with us.  Touchpad related development is 
already there, and we're in the process of migrating to v3.8 for the 
touchscreen development work.

>
>> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
>> Acked-by: Christopher Heiny <cheiny@synaptics.com>
>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>> Cc: Linux Walleij <linus.walleij@linaro.org>
>> Cc: David Herrmann <dh.herrmann@gmail.com>
>> Cc: Jiri Kosina <jkosina@suse.cz>

[snip]

Since Andrew is the most familiar with the code in this patchset, I've 
asked him to reply to most of the direct code-related comments.

					Cheers,
						Chris
