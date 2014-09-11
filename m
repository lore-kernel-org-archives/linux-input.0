From: Fredrik Hallenberg <megahallon@gmail.com>
Subject: Re: [PATCH] Handle spurious backslash key repeats on some keyboards
Date: Thu, 11 Sep 2014 22:35:52 +0200
Message-ID: <CAMsZVf_K1ji75K3CcqGjED01Lppbk8gFSw0ADB-QOG=wVYiF_g@mail.gmail.com>
References: <1407664566-5303-1-git-send-email-megahallon@gmail.com>
	<CAMsZVf_h2fODG2UTs6ddZYZLGfF5hdyY+1PdwXO8N5taDahRwg@mail.gmail.com>
	<alpine.LNX.2.00.1409101025430.5523@pobox.suse.cz>
	<CANq1E4S98gWYSHJ=WxNYKB2t=95WY=4tcC3ioFYcm5ZkwFSs=g@mail.gmail.com>
	<CAMsZVf9_RHYMRmpvenYcHwXFN3B=D5KnZ0zGOR+zzTw1eOqWHw@mail.gmail.com>
	<CANq1E4Q0oiAxDB7osAMrqs=OGEys6GzZh8GDj9B8jAEpxX7now@mail.gmail.com>
	<20140910225134.GH38736@core.coreip.homeip.net>
	<CAMsZVf_NiHJW9mv+k7Tu4hX5EfcAosnyCfn7G1pVWR8oG5qQ0Q@mail.gmail.com>
	<CANq1E4TjgTs+4_84NZGCctGpNJ4x5VG05_ej9=eGjczcdim6Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:51883 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757290AbaIKUfy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Sep 2014 16:35:54 -0400
Received: by mail-qg0-f50.google.com with SMTP id z60so6234205qgd.9
        for <linux-input@vger.kernel.org>; Thu, 11 Sep 2014 13:35:52 -0700 (PDT)
In-Reply-To: <CANq1E4TjgTs+4_84NZGCctGpNJ4x5VG05_ej9=eGjczcdim6Yg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Thanks I had no idea about the hwdb but I have tried it now, it works if I use

KEYBOARD_KEY_70031=reserved

on my nordic keyboard, but a US keyboard user would have to use
scancode 70032 instead. If you chose the wrong one the backslash key
will be disabled.

I don't think this is good solution as long as there is no way to
detect which version is used with the hardware matcher string.

However I suppose udev should make it possible to do some kind of
script that does something similar to my original patch, that is,
detects which of the two keys in actually used and disables the other
one.

On Thu, Sep 11, 2014 at 2:41 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
> Hi
>
> On Thu, Sep 11, 2014 at 10:50 AM, Fredrik Hallenberg
> <megahallon@gmail.com> wrote:
>>>> The nicest fix, obviously, is to blacklist keys that are not
>>>> physically present on the keyboard. But I assume the keyboard reports
>>>
>>> Hmm, somebody could still load keymap with duplicate keycodes though...
>>>
>>
>> The HID mapping is hardcoded, so only key code 43 will have this
>> problem regardless of user keymaps.
>
> I think Dmitry is talking about setkeycode() which can change the
> keycode a scancode is mapped to. This is indeed a problem, but I
> thought we implicitly tell people to not map two scancodes to the same
> keycode.. we simply don't support it (as we only have 1bit state per
> keycode, and 0bit per scancode).
>
> But this reminds me: we can use udev hwdb and setkeycode() to fix your
> keyboard. Simply add this to /lib/udev/hwdb.d/60-keyboard.hwdb:
>     keyboard:name:*Corsair*:dmi:bvn*:bvr*:bd*:svn*:pn*:pvr*
>         KEYBOARD_KEY_32=0
>
> this will run setkeycode(0x32, KEY_RESERVED) and thus disable the key
> 0x32 entirely.
> Adding properly crafted match-rules to udev should solve this mess, I
> guess. Imho, this is the cleanest solution, but depends on udev, of
> course.
>
> Thanks
> David
