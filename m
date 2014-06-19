From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [RFC] Input: uinput - add new UINPUT_DEV_SETUP ioctl
Date: Thu, 19 Jun 2014 15:14:20 +0200
Message-ID: <CANq1E4Q2mrsoYr7KQva8iW2pUOc9g3SH9viB0+gEHCPbPwZZnA@mail.gmail.com>
References: <1403183515-15621-1-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:36531 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601AbaFSNOU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Jun 2014 09:14:20 -0400
Received: by mail-ie0-f175.google.com with SMTP id tp5so1966551ieb.20
        for <linux-input@vger.kernel.org>; Thu, 19 Jun 2014 06:14:20 -0700 (PDT)
In-Reply-To: <1403183515-15621-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

Hi

On Thu, Jun 19, 2014 at 3:11 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
> This adds a new ioctl UINPUT_DEV_SETUP that replaces the old device setup
> method (by write()'ing "struct uinput_user_dev" to the node). The old
> method is not easily extendable and requires huge payloads. Furthermore,
> overloading write() without properly versioned objects is error-prone.
>
> Therefore, we introduce a new ioctl to replace the old method. The ioctl
> supports all features of the old method, plus a "resolution" field for
> absinfo. Furthermore, it's properly forward-compatible to new ABS codes
> and a growing "struct input_absinfo" structure.
>
> The ioctl also allows user-space to skip unknown axes if not set. The
> payload-size can now be specified by the caller. There is no need to copy
> the whole array temporarily into the kernel, but instead we can iterate
> over it and copy each value manually.
>
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> ---
> Hi
>
> I replaced my old approach with a new ioctl(). In my opinion the write() method
> for setup is error-prone and hard to replace correctly with a dynamic structure
> like I did for this ioctl. The ioctl-way is also much more flexible and allows
> read _and_ write in the same call.
>
> This is untested so far, just wanted to get it out as Peter asked for it.
>
> Btw., this should even perform better than the old method as it avoids copying
> the whole object from the user into a temporary buffer.

I forgot to mention, this obviously relies on my other patch:
    [PATCH] Input: uinput - uinput_validate_absbits() cleanup

Thanks
David
