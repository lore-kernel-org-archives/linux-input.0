From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Creating multiple event nodes for A composite HID Device.
Date: Fri, 22 Jan 2016 23:36:09 +0100
Message-ID: <CAN+gG=E579-B-mGyFZPqAHADCFcF1+XG7yB_3a-jvvKJRpP+AA@mail.gmail.com>
References: <CAKafyqpeJi+ZZccawr4EJFEO02a_jZk02XS-xZ_is8D0ZGd=Ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36340 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754534AbcAVWgL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Jan 2016 17:36:11 -0500
Received: by mail-wm0-f50.google.com with SMTP id l65so1878330wmf.1
        for <linux-input@vger.kernel.org>; Fri, 22 Jan 2016 14:36:10 -0800 (PST)
In-Reply-To: <CAKafyqpeJi+ZZccawr4EJFEO02a_jZk02XS-xZ_is8D0ZGd=Ew@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Prabhu Chawandi <foss.chaws@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

Hi,

On Fri, Jan 22, 2016 at 8:28 AM, Prabhu Chawandi <foss.chaws@gmail.com> wrote:
> Hi,
>
>   Is it possible to make Linux to create a separate /dev/input/eventX
> node for all the device composited ?
>
> Example: if my device is supporting Mouse, KBD and Consumer
>
> if I want to create three event nodes for each, like /dev/input/event1
> /dev/input/event2 /dev/input/event3.
>
> How can I do if I am using bluetooth Smart HID device ? Please share your input.

We have a quirk for that. HID_QUIRK_MULTI_INPUT is the one you are looking for.
IIRC bluetooth Smart is using uhid, so there might be no facilities to
set this without having to rely on a separate (new) HID driver. Check
fo rhte code of hid-generic and just add a .probe function that sets
the quirk.

You could also check with bluez if they do not have anything to split
the HID devices into three (i.e. make sure bluez does not agregate the
devices by default while it should use several distinct uhid devices).

Cheers,
Benjamin

>
> thanks in advance.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
