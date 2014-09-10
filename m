From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] Handle spurious backslash key repeats on some keyboards
Date: Wed, 10 Sep 2014 16:22:13 +0200
Message-ID: <CANq1E4Q0oiAxDB7osAMrqs=OGEys6GzZh8GDj9B8jAEpxX7now@mail.gmail.com>
References: <1407664566-5303-1-git-send-email-megahallon@gmail.com>
	<CAMsZVf_h2fODG2UTs6ddZYZLGfF5hdyY+1PdwXO8N5taDahRwg@mail.gmail.com>
	<alpine.LNX.2.00.1409101025430.5523@pobox.suse.cz>
	<CANq1E4S98gWYSHJ=WxNYKB2t=95WY=4tcC3ioFYcm5ZkwFSs=g@mail.gmail.com>
	<CAMsZVf9_RHYMRmpvenYcHwXFN3B=D5KnZ0zGOR+zzTw1eOqWHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:39419 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbaIJOWP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Sep 2014 10:22:15 -0400
Received: by mail-ie0-f174.google.com with SMTP id lx4so3052704iec.19
        for <linux-input@vger.kernel.org>; Wed, 10 Sep 2014 07:22:14 -0700 (PDT)
In-Reply-To: <CAMsZVf9_RHYMRmpvenYcHwXFN3B=D5KnZ0zGOR+zzTw1eOqWHw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fredrik Hallenberg <megahallon@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi

On Wed, Sep 10, 2014 at 1:13 PM, Fredrik Hallenberg
<megahallon@gmail.com> wrote:
> The keyboards in question have n-key rollover, this seems to be
> implemented by sending every single key id every time the keyboard is
> polled, this includes several keys that does not exist physically for
> example 0x31. This may be a bit excessive but not broken. If I press
> a-key and '-key in rapid succession, I get the following events
> (omitting all other keys):
>
> VALUE 1 CODE 30 HID 0x4
> VALUE 0 CODE 43 HID 0x31
> VALUE 0 CODE 43 HID 0x32
> Output: a
>
> VALUE 1 CODE 30 HID 0x4
> VALUE 0 CODE 43 HID 0x31  - 43 is up
> VALUE 1 CODE 43 HID 0x32  - 43 is down
> Output: '
>
> VALUE 0 CODE 30 HID 0x4
> VALUE 0 CODE 43 HID 0x31  - 43 is up
> VALUE 1 CODE 43 HID 0x32  - 43 is down
> Output: '
>
> VALUE 0 CODE 30 HID 0x4
> VALUE 0 CODE 43 HID 0x31  - 43 is up
> VALUE 1 CODE 43 HID 0x32  - 43 is down
> Output: '
>
> So even though the keyboard is behaving a bit weird the problem is in
> the kernel as it will interpret 0x31 and 0x32 as the same key.

Thanks for the information! Please include that in follow-up
commit-messages so others can see it as well. I don't think a report
descriptor is needed, anymore.

This indeed explains the problem. We only track keys on the keycode
level, not scancode level. Therefore, you get weird key-up or
key-repeat events depending on the scan-order.

The nicest fix, obviously, is to blacklist keys that are not
physically present on the keyboard. But I assume the keyboard reports
either key depending on the model (standard vs. European). Given that
this key is indeed special as we only have a single keycode for it, we
probably need some quirk like yours. I'd like to hear Dmitry's
comments on this, maybe he has had similar problems with non-HID
keyboards.

Thanks
David
