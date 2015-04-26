From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Logitech wireless adaptor ID 046d:c52b not showing up
 xfce-powermanager since kernel 3.19
Date: Sun, 26 Apr 2015 18:08:42 -0400
Message-ID: <CAN+gG=FWbgZBa8cj5a_q=Q3N1A2yyZ0_bBNgdobQBEn0HBkf-A@mail.gmail.com>
References: <553D24AA.8030804@bits-fritz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:35778 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbbDZWIn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 26 Apr 2015 18:08:43 -0400
Received: by qkhg7 with SMTP id g7so54142875qkh.2
        for <linux-input@vger.kernel.org>; Sun, 26 Apr 2015 15:08:42 -0700 (PDT)
In-Reply-To: <553D24AA.8030804@bits-fritz.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Friedrich Strohmaier <damokles4-listen@bits-fritz.de>
Cc: linux-input <linux-input@vger.kernel.org>

Hi,

On Sun, Apr 26, 2015 at 1:47 PM, Friedrich Strohmaier
<damokles4-listen@bits-fritz.de> wrote:
> Hi all,
>
> I'm not familiar writing to kernel lists so bear with me ;o))
>
> subject
> Since kernel update to 3.19 my logitech M570 trackball doesn't show up in
> xfce4-power-manager as doesn't my logitech k230 keyboard.
> My Logitech Mouse M315 still does.
> All are connected via wireless usb Receiver.
>
> That's what lsusb tells regarding Logitech devices:
> Bus 007 Device 006: ID 046d:c52b Logitech, Inc. Unifying Receiver
> Bus 007 Device 011: ID 046d:c52b Logitech, Inc. Unifying Receiver
> Bus 007 Device 010: ID 046d:c52f Logitech, Inc. Unifying Receiver
>
> Finally
>
> this appears plugging in the mouse:
> Bus 007 Device 010: ID 046d:c52f Logitech, Inc. Unifying Receiver
>
> those appear plugin in trackball and keyboard :
> Bus 007 Device 006: ID 046d:c52b Logitech, Inc. Unifying Receiver
> Bus 007 Device 011: ID 046d:c52b Logitech, Inc. Unifying Receiver
>
> All devices work fine regarding functionality.
>

Yeah, sorry for this mess. We detected (Peter Wu actually) the problem
during v3.19-rc, and we sent a fix right away. We messed things up and
it did not get applied until recently, so it is still not in any
upower release yet.
The patch in question:
http://cgit.freedesktop.org/upower/commit/?id=f8104a112eb967cd4c2aaf57b5a59aafe7c4738f

You can directly grab the file
http://cgit.freedesktop.org/upower/tree/rules/95-upower-csr.rules,
replace the one in /usr/lib/udev/rules.d/, reboot and you should be
all set.

Sorry again,
Benjamin

> I run up to date archlinux 64-bit.
>
> Proposal to post here I got at arch-general Mailinglist:
> http://thread.gmane.org/gmane.linux.arch.general/53543/focus=53680
>
> If of any interest for You please ask for more information if needed.
>
> btw. I'm not subscribed to the list - please cc me.
>
> regards
> --
> Friedrich
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
