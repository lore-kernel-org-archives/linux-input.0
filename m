From: Donavan Lance <tusklahoma@gmail.com>
Subject: Re: [PATCH 1/2] HID: Use multitouch driver for Type Covers
Date: Mon, 14 Dec 2015 11:39:43 -0500
Message-ID: <CAOD0F3aeVMBFOhagNsozmuv58qimpKpRiFzx5YjdoG4RATVegA@mail.gmail.com>
References: <1450097429-4959-1-git-send-email-akihiko.odaki.4i@stu.hosei.ac.jp>
	<1450099368.3358.5.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:36815 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbbLNQjp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Dec 2015 11:39:45 -0500
In-Reply-To: <1450099368.3358.5.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Akihiko Odaki <akihiko.odaki.4i@stu.hosei.ac.jp>, jikos@kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

On Mon, Dec 14, 2015 at 8:22 AM, Bastien Nocera <hadess@hadess.net> wrote:
> On Mon, 2015-12-14 at 21:50 +0900, Akihiko Odaki wrote:
>> Use multitouch driver instead of microsoft one for Microsoft Surface
>> Type Covers.
>>
>> By using MT_CLS_EXPORT_ALL_INPUTS, the keyboards function as well as
>> the multitouch pads do.
>
> I've discussed this a couple of weeks back with Benjamin Tissoires, and
> this patch would break the special keys (mute, brightness up/down,
> keyboard backlight up/down and play/pause).
>
> The recommended way to fix this was to move multi-touch processing into
> the Microsoft driver, so that it would handle the trackpad's multi-
> touch events.
>
> You should be able to do this by carefully picking up the handling code
> from hid-multitouch, or do something similar to what's done in hid-
> wacom, which has the same problem as the Type Cover handling.
>
> Can you confirm that this does indeed break those special keys? If it
> does, it's a NAK from my side.

For what it's worth the special keys on my keyboard work fine when
using this patch. I'm using a Surface Pro 3, Type Cover 3, running
GNOME and Fedora 23. The search, share, connect(?), and settings keys
are the only ones not mapped to anything out of the box, but they are
recognized by xev.
