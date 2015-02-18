From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH 0/2] HID: huion: add libinput support
Date: Wed, 18 Feb 2015 11:25:22 +0200
Message-ID: <54E45A82.7090706@gmail.com>
References: <1424213653-5970-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:39873 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527AbbBRJZZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Feb 2015 04:25:25 -0500
In-Reply-To: <1424213653-5970-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>

Hi Benjamin,

I'm copying my reply to DIGImend-devel as well.

On 02/18/2015 12:54 AM, Benjamin Tissoires wrote:
> Hi Nikolai,
>
> I know you are actually merging hid-huion and hid-uclogic, so we might not want
> to take this in this current state. We may need to postpone it when you have
> send the merge.

I have it in the out-of-tree driver package [1], which I'll need to release
for users to test first.

> This series makes the Huion tablet (a H610 Pro) behave like a Wacom one from the
> libinput point of view.
> It will introduce a change in the default behavior for the users (which I
> believe is a good change) where the pad part of the tablet will not send
> random keyboard shortcuts but actual button events.

That's awesome, thanks a lot, Benjamin! I tried making something like that
[2], which seems to work reasonably. However, I was not up-to-date with
libinput changes and left the buttons in the same device with the pen. Then I
heard about input groups from Hans and planned to re-make it properly, but now
you did it. Thanks!

> I'd be glad if you could validate the changes with the other huions you have
> (or the Digimend project), because, having only one PID for all their tablets
> is rather weird and difficult to support.

I'll have to incorporate them into the out-of-tree driver [1] to simplify
testing for users. I'll leave some comments to the changes as well, if you
don't mind.

Of course, it would help a lot, if you could contribute your patches to the
out-of-tree driver, from where we could then take them to upstream, after
testing. I can do it myself, though.

> Last, I think we could add these tablets in the libwacom project, so that there
> will be a nice GUI to configure the buttons.

That would be a very welcome change, without doubt, thank you.

However, I can't help wondering, would it be more productive to allow libwacom
to work with just any basic tablet, without the need to add each one to the
database?

> However, not having the PID to discriminate between tablets is going to be a
> problem. Do you have any reliable way of knowing the model from the kernel
> or the user space?

Unfortunately, not. You can take a look at the data I and the users gathered
on some of the Huion tablets [3]. The iProduct string can be used to some
extent, but I wouldn't rely on it to make much sense. Apart from Huion
tablets, there are also Yiynova tablets which work the same way, at least some
Ugee tablets and at least one UC-Logic tablet, but I expect more of the latter
work as well. Among them there is a mix of using dedicated and UC-Logic VIDs
and mostly reusing PIDs. There is something which seems to be an internal
model name in string descriptor 0x7a, but it also doesn't make much sense.

All-in-all it's a mess. I've even seen a tablet with a typo in iManufacturer.

Still, if we make libwacom work with generic tablets not contained in its
database, that wouldn't be a problem.

Nick

[1] https://github.com/DIGImend/digimend-kernel-drivers
[2] https://github.com/DIGImend/digimend-kernel-drivers/blob/huion-abstract-keyboard/hid-huion.c
[3] https://github.com/DIGImend/tablets
