From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] Handle spurious backslash key repeats on some keyboards
Date: Thu, 11 Sep 2014 14:41:25 +0200
Message-ID: <CANq1E4TjgTs+4_84NZGCctGpNJ4x5VG05_ej9=eGjczcdim6Yg@mail.gmail.com>
References: <1407664566-5303-1-git-send-email-megahallon@gmail.com>
	<CAMsZVf_h2fODG2UTs6ddZYZLGfF5hdyY+1PdwXO8N5taDahRwg@mail.gmail.com>
	<alpine.LNX.2.00.1409101025430.5523@pobox.suse.cz>
	<CANq1E4S98gWYSHJ=WxNYKB2t=95WY=4tcC3ioFYcm5ZkwFSs=g@mail.gmail.com>
	<CAMsZVf9_RHYMRmpvenYcHwXFN3B=D5KnZ0zGOR+zzTw1eOqWHw@mail.gmail.com>
	<CANq1E4Q0oiAxDB7osAMrqs=OGEys6GzZh8GDj9B8jAEpxX7now@mail.gmail.com>
	<20140910225134.GH38736@core.coreip.homeip.net>
	<CAMsZVf_NiHJW9mv+k7Tu4hX5EfcAosnyCfn7G1pVWR8oG5qQ0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:58294 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754600AbaIKMl0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Sep 2014 08:41:26 -0400
Received: by mail-ig0-f176.google.com with SMTP id hn15so840500igb.9
        for <linux-input@vger.kernel.org>; Thu, 11 Sep 2014 05:41:25 -0700 (PDT)
In-Reply-To: <CAMsZVf_NiHJW9mv+k7Tu4hX5EfcAosnyCfn7G1pVWR8oG5qQ0Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fredrik Hallenberg <megahallon@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi

On Thu, Sep 11, 2014 at 10:50 AM, Fredrik Hallenberg
<megahallon@gmail.com> wrote:
>>> The nicest fix, obviously, is to blacklist keys that are not
>>> physically present on the keyboard. But I assume the keyboard reports
>>
>> Hmm, somebody could still load keymap with duplicate keycodes though...
>>
>
> The HID mapping is hardcoded, so only key code 43 will have this
> problem regardless of user keymaps.

I think Dmitry is talking about setkeycode() which can change the
keycode a scancode is mapped to. This is indeed a problem, but I
thought we implicitly tell people to not map two scancodes to the same
keycode.. we simply don't support it (as we only have 1bit state per
keycode, and 0bit per scancode).

But this reminds me: we can use udev hwdb and setkeycode() to fix your
keyboard. Simply add this to /lib/udev/hwdb.d/60-keyboard.hwdb:
    keyboard:name:*Corsair*:dmi:bvn*:bvr*:bd*:svn*:pn*:pvr*
        KEYBOARD_KEY_32=0

this will run setkeycode(0x32, KEY_RESERVED) and thus disable the key
0x32 entirely.
Adding properly crafted match-rules to udev should solve this mess, I
guess. Imho, this is the cleanest solution, but depends on udev, of
course.

Thanks
David
