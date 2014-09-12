From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] Handle spurious backslash key repeats on some keyboards
Date: Fri, 12 Sep 2014 12:29:41 +0200
Message-ID: <CANq1E4Qw3_0M7BCgDJTX0WGHU+CnFdnuASX0JfEK-Btkc=7Rsg@mail.gmail.com>
References: <1407664566-5303-1-git-send-email-megahallon@gmail.com>
	<CAMsZVf_h2fODG2UTs6ddZYZLGfF5hdyY+1PdwXO8N5taDahRwg@mail.gmail.com>
	<alpine.LNX.2.00.1409101025430.5523@pobox.suse.cz>
	<CANq1E4S98gWYSHJ=WxNYKB2t=95WY=4tcC3ioFYcm5ZkwFSs=g@mail.gmail.com>
	<CAMsZVf9_RHYMRmpvenYcHwXFN3B=D5KnZ0zGOR+zzTw1eOqWHw@mail.gmail.com>
	<CANq1E4Q0oiAxDB7osAMrqs=OGEys6GzZh8GDj9B8jAEpxX7now@mail.gmail.com>
	<20140910225134.GH38736@core.coreip.homeip.net>
	<CAMsZVf_NiHJW9mv+k7Tu4hX5EfcAosnyCfn7G1pVWR8oG5qQ0Q@mail.gmail.com>
	<CANq1E4TjgTs+4_84NZGCctGpNJ4x5VG05_ej9=eGjczcdim6Yg@mail.gmail.com>
	<CAMsZVf_K1ji75K3CcqGjED01Lppbk8gFSw0ADB-QOG=wVYiF_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:38229 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776AbaILK3m (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Sep 2014 06:29:42 -0400
Received: by mail-ie0-f169.google.com with SMTP id rl12so613055iec.0
        for <linux-input@vger.kernel.org>; Fri, 12 Sep 2014 03:29:42 -0700 (PDT)
In-Reply-To: <CAMsZVf_K1ji75K3CcqGjED01Lppbk8gFSw0ADB-QOG=wVYiF_g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fredrik Hallenberg <megahallon@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi

On Thu, Sep 11, 2014 at 10:35 PM, Fredrik Hallenberg
<megahallon@gmail.com> wrote:
> Thanks I had no idea about the hwdb but I have tried it now, it works if I use
>
> KEYBOARD_KEY_70031=reserved

Thanks for confirming!

> on my nordic keyboard, but a US keyboard user would have to use
> scancode 70032 instead. If you chose the wrong one the backslash key
> will be disabled.
>
> I don't think this is good solution as long as there is no way to
> detect which version is used with the hardware matcher string.

Well, you can match on "country" tags. Currently, the device
identifiers contain vendor+product+version+country information. I
assume the "country" field is different between your keyboard and a
keyboard that swaps the key reports.

> However I suppose udev should make it possible to do some kind of
> script that does something similar to my original patch, that is,
> detects which of the two keys in actually used and disables the other
> one.

If you post your mod-alias line of your device (or better: all
information you can gather about the device), I can push it into hwdb.
It is up to Dmitry and Jiri to decide whether it makes sense to deal
with it in the kernel.

Thanks
David
