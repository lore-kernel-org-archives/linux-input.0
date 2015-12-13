From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HID: enable all buttons on the TiVo Slide Pro remote
Date: Sun, 13 Dec 2015 08:52:23 -0800
Message-ID: <CAKdAkRRbEjW2fTgy6pwPp0JvgFh8W2SiW0x0QDqNNL-5y5LqqA@mail.gmail.com>
References: <i825gaplvjcd1oha4ethkjj325m51ujano@4ax.com>
	<alpine.LNX.2.00.1503151005240.24876@pobox.suse.cz>
	<CAKdAkRS6HfP91-Hn789GQdgcE3whrCey1Dxu+j3xcDNM2ySNYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:36368 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbbLMQwY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Dec 2015 11:52:24 -0500
Received: by oian133 with SMTP id n133so2787864oia.3
        for <linux-input@vger.kernel.org>; Sun, 13 Dec 2015 08:52:23 -0800 (PST)
In-Reply-To: <CAKdAkRS6HfP91-Hn789GQdgcE3whrCey1Dxu+j3xcDNM2ySNYA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Forest Wilkinson <web11.forest@tibit.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Illumi Lore <illumilore@gmail.com>

On Fri, Dec 11, 2015 at 11:18 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Sun, Mar 15, 2015 at 7:05 AM, Jiri Kosina <jkosina@suse.cz> wrote:
>> On Thu, 12 Mar 2015, Forest Wilkinson wrote:
>>
>>> The linux kernel has supported the TiVo Slide remote control for some time,
>>> but does not recognize the USB ID of the newer Slide Pro. This patch adds
>>> the missing data structures so the newer remote will be recognized by the
>>> driver, thereby allowing the TiVo, LiveTV, and Thumbs Up/Down buttons to be
>>> mapped with a hwdb file.
>>>
>>> Signed-off-by: Forest Wilkinson <web11.forest@tibit.com>
>>
>> Applied to for-4.0/upstream-fixes.
>
> There is a complaint in bugzilla that it may have broken their remote:
> https://bugzilla.kernel.org/show_bug.cgi?id=107791

Apparently the breakage was due to systemd/udev changes, not kernel.

-- 
Dmitry
