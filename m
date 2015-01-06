From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] HID: input: fix confusion on conflicting mappings
Date: Tue, 6 Jan 2015 13:47:18 +0100
Message-ID: <CANq1E4TUrUS3=5cZiODfXmcvuSNfFrhPxV5h+PMfB=oQ31Rttw@mail.gmail.com>
References: <20141230165739.050cc0b9@kruskal.home.chead.ca>
	<CAMsZVf_UT+m_8BWqz0+aYGJB+8Z_u6xRU7efLZ-Bd7WNhn4ZYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:41196 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754549AbbAFMrS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Jan 2015 07:47:18 -0500
Received: by mail-ig0-f169.google.com with SMTP id z20so4710027igj.2
        for <linux-input@vger.kernel.org>; Tue, 06 Jan 2015 04:47:18 -0800 (PST)
In-Reply-To: <CAMsZVf_UT+m_8BWqz0+aYGJB+8Z_u6xRU7efLZ-Bd7WNhn4ZYA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fredrik Hallenberg <megahallon@gmail.com>
Cc: Christopher Head <chead@chead.ca>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi

On Tue, Jan 6, 2015 at 1:37 PM, Fredrik Hallenberg <megahallon@gmail.com> wrote:
> I can confirm that the patch breaks things when not using n key
> rollover. If using the Corsair K70 in "BIOS mode" or just using a
> plain USB-keyboard keys repeat forever as reported.
>
> David, I noticed that in the first version of your patch, where the
> ignore check was done in hid-core.c, you only checked events that had
> the HID_MAIN_ITEM_VARIABLE flag set. I can see that "plain" keyboards
> don't have this bit set on the release event so if I keep this check
> in the new patch it works in both cases.
>
> So, the if-clause now looks like this:
>
> ...
>     if (!(field->flags & (HID_MAIN_ITEM_RELATIVE |
>                   HID_MAIN_ITEM_BUFFERED_BYTE)) &&
>         (field->flags & HID_MAIN_ITEM_VARIABLE) &&
>         usage->usage_index < field->maxusage &&
>         value == field->value[usage->usage_index]) {
> ...

Nice catch! Of course, we must not apply this to ARRAY reports. I will
send v2 tomorrow (still on the road..).

Thanks
David
