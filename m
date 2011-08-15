From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 2/5] input: wacom - remove pressure for touch devices
Date: Sun, 14 Aug 2011 22:27:00 -0500
Message-ID: <CAGzDe_YC2afYK-Xr5JNveZC-=h9dpnysLxwQSM0i7q3tN91--g@mail.gmail.com>
References: <1313194109-4987-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f170.google.com ([209.85.210.170]:44965 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469Ab1HOD1B (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 14 Aug 2011 23:27:01 -0400
Received: by iye16 with SMTP id 16so6611780iye.1
        for <linux-input@vger.kernel.org>; Sun, 14 Aug 2011 20:27:01 -0700 (PDT)
In-Reply-To: <1313194109-4987-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

On Fri, Aug 12, 2011 at 7:08 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> Touch devices do not report valid pressure or capacitance.
>
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---

I'd prefer if we kept pressure support.  At least for Bamboo's with
product ID between 0xd0 and 0xd4.

In my testing of an 0xd1 device, pressure works fine (low pressure and
high pressure work great.  Not much middle pressure sensitivity.
Multi-touch will increase pressure reading.  All pretty common
behaviour).

I don't use the pressure in day-to-day usage but do use it to drive
testing of pressure features of some apps/drivers and so don't want to
lose it.

>From looking at the touch data on Bamboo's > 0xd4 that people have
emailed me, it looks like pressure data was removed from firmware so a
version of this patch will be useful for those.  But that patch needs
to also change the way it parses the touch data to reduce from 8-bits
to 1-bit.

Chris
