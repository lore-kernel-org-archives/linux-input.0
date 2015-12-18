From: Akihiko Odaki <akihiko.odaki.4i@stu.hosei.ac.jp>
Subject: Re: [PATCH 1/2] HID: Use multitouch driver for Type Covers
Date: Fri, 18 Dec 2015 18:12:36 +0900
Message-ID: <5673CE04.90705@stu.hosei.ac.jp>
References: <1450097429-4959-1-git-send-email-akihiko.odaki.4i@stu.hosei.ac.jp>
 <1450099368.3358.5.camel@hadess.net>
 <CAOD0F3aeVMBFOhagNsozmuv58qimpKpRiFzx5YjdoG4RATVegA@mail.gmail.com>
 <5673A785.6000306@stu.hosei.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailgw02.hosei.ac.jp ([133.25.1.22]:40555 "EHLO
	mailgw02.hosei.ac.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753757AbbLRJMp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Dec 2015 04:12:45 -0500
Received: from mail-pf0-f174.google.com (mail-pf0-f174.google.com [209.85.192.174])
	by mailgw02.hosei.ac.jp (Postfix) with ESMTP id 908121B00359
	for <linux-input@vger.kernel.org>; Fri, 18 Dec 2015 18:12:41 +0900 (JST)
Received: by mail-pf0-f174.google.com with SMTP id v86so46148934pfa.2
        for <linux-input@vger.kernel.org>; Fri, 18 Dec 2015 01:12:41 -0800 (PST)
In-Reply-To: <5673A785.6000306@stu.hosei.ac.jp>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Donavan Lance <tusklahoma@gmail.com>, Bastien Nocera <hadess@hadess.net>
Cc: jikos@kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

The "Charm" keys seem to issue short-cut key combinations.
I also found Microsoft's document by searching for the combinations.

https://msdn.microsoft.com/en-us/library/windows/hardware/dn614461(v=vs.85).aspx

So the behavior of hid-multitouch is completely fine.

On 12/18/2015 03:28 PM, Akihiko Odaki wrote:
>> The search, share, connect(?), and settings keys
> I tested the patch again with xev and found that those "charm"
> keys don't respond both on hid-microsoft and hid-multitouch, while
> other keys respond. I'll have a further look.
> 
> Anyway, keys working with hid-microsoft also work with
> hid-multitouch, so It's ready for merging, I think.
> 
> On 12/15/2015 01:39 AM, Donavan Lance wrote:
>> On Mon, Dec 14, 2015 at 8:22 AM, Bastien Nocera 
>> <hadess@hadess.net>
> wrote:
>>> On Mon, 2015-12-14 at 21:50 +0900, Akihiko Odaki wrote:
>>>> Use multitouch driver instead of microsoft one for Microsoft 
>>>> Surface Type Covers.
>>>> 
>>>> By using MT_CLS_EXPORT_ALL_INPUTS, the keyboards function as 
>>>> well as the multitouch pads do.
>>> 
>>> I've discussed this a couple of weeks back with Benjamin 
>>> Tissoires, and this patch would break the special keys (mute, 
>>> brightness up/down, keyboard backlight up/down and
>>> play/pause).
>>> 
>>> The recommended way to fix this was to move multi-touch 
>>> processing into the Microsoft driver, so that it would handle
>>> the trackpad's multi- touch events.
>>> 
>>> You should be able to do this by carefully picking up the 
>>> handling code from hid-multitouch, or do something similar to 
>>> what's done in hid- wacom, which has the same problem as the
>>> Type Cover handling.
>>> 
>>> Can you confirm that this does indeed break those special
>>> keys? If it does, it's a NAK from my side.
>> 
>> For what it's worth the special keys on my keyboard work fine
>> when using this patch. I'm using a Surface Pro 3, Type Cover 3,
>> running GNOME and Fedora 23. The search, share, connect(?), and
>> settings keys are the only ones not mapped to anything out of the
>> box, but they are recognized by xev.
>> 
