From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH 4/4] Input: extend the number of event (and other) devices
Date: Sun, 7 Oct 2012 16:56:20 +0200
Message-ID: <CANq1E4Qoxfge6LDr2TOVSo=-=Vxo-L2wnHsCA5sT5yVSV4GD-w@mail.gmail.com>
References: <1349298182-22452-1-git-send-email-dmitry.torokhov@gmail.com>
	<1349298182-22452-4-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:51295 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753308Ab2JGO4V (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 7 Oct 2012 10:56:21 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so2061592wey.19
        for <linux-input@vger.kernel.org>; Sun, 07 Oct 2012 07:56:20 -0700 (PDT)
In-Reply-To: <1349298182-22452-4-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry

On Wed, Oct 3, 2012 at 11:03 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Extend the amount of character devices, such as eventX, mouseX and jsX,
> from a hard limit of 32 per input handler to about 1024 shared across
> all handlers.
>
> To be compatible with legacy installations input handlers will start
> creating char devices with minors in their legacy range, however once
> legacy range is exhausted they will start allocating minors from the
> dynamic range 256-1024.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

I just reviewed the other patches 1-3 as well. Thanks for factoring
them out! Feel free to add my reviewed-by to those as well.

Regards
David
