From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: evdev - add ioctl cmd EVIOCGBUFSIZE to get buffer size
Date: Fri, 8 Jan 2016 13:02:22 -0800
Message-ID: <CAKdAkRQ6SPt2oBJPv6h-gPVsEGZWRcBfp7J-TZpzWnO-nEOXKw@mail.gmail.com>
References: <1452266588-3139-1-git-send-email-a.mathur@samsung.com>
	<CANq1E4T0UVLijsFivcANtMjknn6bkq7W5nned_hAvRQD=K94Nw@mail.gmail.com>
	<CADYu30_KWWELgNM4a0Lyd_AoewpmhizuxJxXJSXzoGSF5YFOZg@mail.gmail.com>
	<20160108201346.6a6694e2@lxorguk.ukuu.org.uk>
	<CADYu309gh6QOgGXsaxJO06Xif50mK73u6VaxjwRQYWyeeL5EMg@mail.gmail.com>
	<20160108203340.2b728a41@lxorguk.ukuu.org.uk>
	<CADYu309viVxQJVo-HR=17s-gGhXm03t4p_qL5i1=YUwKqh3pbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:35346 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756223AbcAHVCX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Jan 2016 16:02:23 -0500
In-Reply-To: <CADYu309viVxQJVo-HR=17s-gGhXm03t4p_qL5i1=YUwKqh3pbA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aniroop Mathur <aniroop.mathur@gmail.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, David Herrmann <dh.herrmann@gmail.com>, Aniroop Mathur <a.mathur@samsung.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Fri, Jan 8, 2016 at 12:51 PM, Aniroop Mathur
<aniroop.mathur@gmail.com> wrote:
> On Sat, Jan 9, 2016 at 2:03 AM, One Thousand Gnomes
> <gnomes@lxorguk.ukuu.org.uk> wrote:
>> On Sat, 9 Jan 2016 01:50:42 +0530
>> Aniroop Mathur <aniroop.mathur@gmail.com> wrote:
>>
>>> On Sat, Jan 9, 2016 at 1:43 AM, One Thousand Gnomes
>>> <gnomes@lxorguk.ukuu.org.uk> wrote:
>>> >> During system boot up, user space buf size is fixed, it cannot be
>>> >> resized later and we cannot choose by hit&trial.
>>> >> struct input_event* mBuffer = new input_event[mBuf];
>>> >
>>> > Who says that won't change ? Imagine a future case where plugging in a
>>> > device changes the buffer size ?
>>> >
>>>
>>> Ofcourse buffer size can be changed but it will also change the value of bufsize
>>> variable and accordingly user space client should also change its buf size.
>>
>> If its hot plugged why shouldn't that value change dynamically after
>> you've asked ?
>>
>
> Please put up your query clearly. what value ? what asked ?

There is nothing that would stop us (kernel) to decide to resize the
buffer after you issued your new EVIOCGBUFSIZE. For example one can
decide to implement a feature that will double the size of evdev's
client buffer if there happened too many overruns i a given time
period.

In any case the userpsace consumers already have to inspect input
device in question (number of axes and what they are; number of
keys/buttons, number of slots, etc) so that they can handle devices
properly and it should have enough information to intelligently size
of the receiving buffers. There is no need for a new kernel ioctl.

Thanks.

-- 
Dmitry
