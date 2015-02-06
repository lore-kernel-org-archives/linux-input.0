From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [v3] synaptics: match PNP-Id is not sufficient for min/max quirks
Date: Fri, 6 Feb 2015 09:35:58 -0500
Message-ID: <CAN+gG=GhebVqXvHuQvxMO+_s35uC5xJrmzTFmBrCd6s6_8O6rQ@mail.gmail.com>
References: <1423229108-29268-1-git-send-email-daniel.martin@secunet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:63714 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755446AbbBFOf6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Feb 2015 09:35:58 -0500
Received: by mail-qa0-f45.google.com with SMTP id n8so11040410qaq.4
        for <linux-input@vger.kernel.org>; Fri, 06 Feb 2015 06:35:58 -0800 (PST)
In-Reply-To: <1423229108-29268-1-git-send-email-daniel.martin@secunet.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Martin <daniel.martin@secunet.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>

Again, Thanks for the respin.

On Fri, Feb 6, 2015 at 8:25 AM, Daniel Martin <daniel.martin@secunet.com> wrote:
> Hi folks,
>
> this is the third version of my patches to address the bug:
>     https://bugzilla.kernel.org/show_bug.cgi?id=91541
>
> One task on top of patch 5 remains: Find suitable board id ranges.
> I.e. in the first comment of the bug, the board id 2962 is the lowest
> one that I know of for a post-2013 model. So, the quirk with PnP id
> LEN0036 could have a max board id of 2961.

I think that is sensible. We can always update it later if we find a
new board id lower, but I doubt there will be much different board ids
between the refreshes.

On a private mail you told me that I could take over this work, so
I'll send the 6/5 patch with the board id sets and a v4 of the 3/5
with the small fix in the test.

Cheers,
Benjamin

>
> Changes to v2 are:
>
> [PATCH 3/5] Input: synaptics - Query min dimensions for fw v8.1
> - Here I have replaced the "safe fw" list with a simple check for
>   version 8.1
>
> [PATCH 4/5] Input: synaptics - Remove obsolete min/max quirk for X240
> - This patch has been moved from the patch set tail here.
>
> [PATCH 5/5] Input: synaptics - Support min/max board id in
> - With that we can restrict min/max quirks by board id ranges. It
>   replaces the previous patch:
>       Input: synaptics - Skip quirks when post-2013 dimensions
>
>
> Cheers,
>     Daniel Martin
