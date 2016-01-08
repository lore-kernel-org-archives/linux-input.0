From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: Re: [PATCH] Input: evdev - add ioctl cmd EVIOCGBUFSIZE to get buffer size
Date: Sat, 9 Jan 2016 02:21:19 +0530
Message-ID: <CADYu309viVxQJVo-HR=17s-gGhXm03t4p_qL5i1=YUwKqh3pbA@mail.gmail.com>
References: <1452266588-3139-1-git-send-email-a.mathur@samsung.com>
	<CANq1E4T0UVLijsFivcANtMjknn6bkq7W5nned_hAvRQD=K94Nw@mail.gmail.com>
	<CADYu30_KWWELgNM4a0Lyd_AoewpmhizuxJxXJSXzoGSF5YFOZg@mail.gmail.com>
	<20160108201346.6a6694e2@lxorguk.ukuu.org.uk>
	<CADYu309gh6QOgGXsaxJO06Xif50mK73u6VaxjwRQYWyeeL5EMg@mail.gmail.com>
	<20160108203340.2b728a41@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:32929 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756190AbcAHUvU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Jan 2016 15:51:20 -0500
In-Reply-To: <20160108203340.2b728a41@lxorguk.ukuu.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: David Herrmann <dh.herrmann@gmail.com>, Aniroop Mathur <a.mathur@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Sat, Jan 9, 2016 at 2:03 AM, One Thousand Gnomes
<gnomes@lxorguk.ukuu.org.uk> wrote:
> On Sat, 9 Jan 2016 01:50:42 +0530
> Aniroop Mathur <aniroop.mathur@gmail.com> wrote:
>
>> On Sat, Jan 9, 2016 at 1:43 AM, One Thousand Gnomes
>> <gnomes@lxorguk.ukuu.org.uk> wrote:
>> >> During system boot up, user space buf size is fixed, it cannot be
>> >> resized later and we cannot choose by hit&trial.
>> >> struct input_event* mBuffer = new input_event[mBuf];
>> >
>> > Who says that won't change ? Imagine a future case where plugging in a
>> > device changes the buffer size ?
>> >
>>
>> Ofcourse buffer size can be changed but it will also change the value of bufsize
>> variable and accordingly user space client should also change its buf size.
>
> If its hot plugged why shouldn't that value change dynamically after
> you've asked ?
>

Please put up your query clearly. what value ? what asked ?


> Alan
