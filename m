From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH] hid-magicmouse: Add pointer and buttonpad properties
 for Magic Trackpad
Date: Tue, 21 Feb 2012 21:53:22 +0100
Message-ID: <4F440442.9040909@canonical.com>
References: <1329192751-6041-1-git-send-email-chase.douglas@canonical.com> <alpine.LNX.2.00.1202211152220.31150@pobox.suse.cz> <4F437D46.6090604@canonical.com> <alpine.LNX.2.00.1202211422190.31150@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:43272 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754088Ab2BUUxY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Feb 2012 15:53:24 -0500
In-Reply-To: <alpine.LNX.2.00.1202211422190.31150@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

On 02/21/2012 02:22 PM, Jiri Kosina wrote:
> On Tue, 21 Feb 2012, Chase Douglas wrote:
> 
>>>> Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
>>>> ---
>>>>  drivers/hid/hid-magicmouse.c |    2 ++
>>>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
>>>> index 2ab7175..7cf3ffe 100644
>>>> --- a/drivers/hid/hid-magicmouse.c
>>>> +++ b/drivers/hid/hid-magicmouse.c
>>>> @@ -418,6 +418,8 @@ static void magicmouse_setup_input(struct input_dev *input, struct hid_device *h
>>>>  		__set_bit(BTN_TOOL_TRIPLETAP, input->keybit);
>>>>  		__set_bit(BTN_TOOL_QUADTAP, input->keybit);
>>>>  		__set_bit(BTN_TOUCH, input->keybit);
>>>> +		__set_bit(INPUT_PROP_POINTER, input->propbit);
>>>> +		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
>>>>  	}
>>>>  
>>>>  	if (report_touches) {
>>>
>>> Applied, although a bit more verbose commit message would be welcome next 
>>> time :)
>>
>> Will you push this for 3.3, or keep it for 3.4?
> 
> As the old set of properties has been there since 2.6.37, I wasn't 
> considering pushing this for 3.3 still. Do you feel otherwise?

My concerns are:

1. I have a branch for xf86-input-synaptics that makes clickpads work as
they are meant to. It uses the buttonpad property to detect a clickpad.
I hope it will be merged for the next release, which is very soon.

2. I plan on pushing the clickpad stuff into Ubuntu Precise, which is
based on 3.2. We prefer to cherry-pick from mainline. If it's going into
3.3, we can wait until it gets there and cherry-pick. If not, then I can
manually get the patch applied. I just need to know which route to take.

I feel it should be pushed for 3.3. However, I have views that are far
different from some others on the list about when properties should be
added to the kernel.

-- Chase
