From: Fredrik Hallenberg <megahallon@gmail.com>
Subject: Re: [PATCH] Handle spurious backslash key repeats on some keyboards
Date: Thu, 11 Sep 2014 10:50:40 +0200
Message-ID: <CAMsZVf_NiHJW9mv+k7Tu4hX5EfcAosnyCfn7G1pVWR8oG5qQ0Q@mail.gmail.com>
References: <1407664566-5303-1-git-send-email-megahallon@gmail.com>
	<CAMsZVf_h2fODG2UTs6ddZYZLGfF5hdyY+1PdwXO8N5taDahRwg@mail.gmail.com>
	<alpine.LNX.2.00.1409101025430.5523@pobox.suse.cz>
	<CANq1E4S98gWYSHJ=WxNYKB2t=95WY=4tcC3ioFYcm5ZkwFSs=g@mail.gmail.com>
	<CAMsZVf9_RHYMRmpvenYcHwXFN3B=D5KnZ0zGOR+zzTw1eOqWHw@mail.gmail.com>
	<CANq1E4Q0oiAxDB7osAMrqs=OGEys6GzZh8GDj9B8jAEpxX7now@mail.gmail.com>
	<20140910225134.GH38736@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:63693 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbaIKIul (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Sep 2014 04:50:41 -0400
Received: by mail-qg0-f50.google.com with SMTP id z60so5149344qgd.9
        for <linux-input@vger.kernel.org>; Thu, 11 Sep 2014 01:50:41 -0700 (PDT)
In-Reply-To: <20140910225134.GH38736@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

>> The nicest fix, obviously, is to blacklist keys that are not
>> physically present on the keyboard. But I assume the keyboard reports
>
> Hmm, somebody could still load keymap with duplicate keycodes though...
>

The HID mapping is hardcoded, so only key code 43 will have this
problem regardless of user keymaps.

Regarding blacklisting it would be good but I don't think there is any
way to know in advance which key (0x31 or 0x32) the keyboard actually
uses. If anybody has ideas on how this could be done let me know.

Jiri, do you still think this should be a hardware specific quirk?
