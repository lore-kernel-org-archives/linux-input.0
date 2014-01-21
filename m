From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 4/5 v3] input: tc3589x-keypad: support probing from device tree
Date: Tue, 21 Jan 2014 14:32:50 +0100
Message-ID: <CACRpkdab32Cfj73D5zyVLDr9JTsQ2xxS3kDKjTBi4f+vLtZMAw@mail.gmail.com>
References: <1384270261-15889-1-git-send-email-linus.walleij@linaro.org>
	<20131126023431.GC31517@core.coreip.homeip.net>
	<CACRpkdZW-Nay-wOywq4SG1bwQf_+J4tqYuS=tQmzTHOtBskGVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:43070 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbaAUNcu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jan 2014 08:32:50 -0500
Received: by mail-ob0-f182.google.com with SMTP id wm4so3151237obc.41
        for <linux-input@vger.kernel.org>; Tue, 21 Jan 2014 05:32:50 -0800 (PST)
In-Reply-To: <CACRpkdZW-Nay-wOywq4SG1bwQf_+J4tqYuS=tQmzTHOtBskGVw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Rutland <mark.rutland@arm.com>

On Tue, Jan 21, 2014 at 2:28 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Nov 26, 2013 at 3:34 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> On Tue, Nov 12, 2013 at 04:31:01PM +0100, Linus Walleij wrote:
>>>       irq = platform_get_irq(pdev, 0);
>>> --
>>
>> Don't you also want to add MODULE_DEVICE_TABLE entry?
>
> Probably, but that'd be a separate subject though, I think?
> I'll make a patch for this so you get something you can
> actually merge.

No, wait, this driver only matches on driver name, it has no
match table of any kind. This is typical for MFD-spun cells
if they don't need additional info from the compat match.
I think it only needs the MODULE_ALIAS() it already
has.

Yours,
Linus Walleij
