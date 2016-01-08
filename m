From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Input: evdev - add ioctl cmd EVIOCGBUFSIZE to get
 buffer size
Date: Fri, 8 Jan 2016 20:33:40 +0000
Message-ID: <20160108203340.2b728a41@lxorguk.ukuu.org.uk>
References: <1452266588-3139-1-git-send-email-a.mathur@samsung.com>
	<CANq1E4T0UVLijsFivcANtMjknn6bkq7W5nned_hAvRQD=K94Nw@mail.gmail.com>
	<CADYu30_KWWELgNM4a0Lyd_AoewpmhizuxJxXJSXzoGSF5YFOZg@mail.gmail.com>
	<20160108201346.6a6694e2@lxorguk.ukuu.org.uk>
	<CADYu309gh6QOgGXsaxJO06Xif50mK73u6VaxjwRQYWyeeL5EMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:60694 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755752AbcAHUdy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Jan 2016 15:33:54 -0500
In-Reply-To: <CADYu309gh6QOgGXsaxJO06Xif50mK73u6VaxjwRQYWyeeL5EMg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aniroop Mathur <aniroop.mathur@gmail.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, Aniroop Mathur <a.mathur@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Sat, 9 Jan 2016 01:50:42 +0530
Aniroop Mathur <aniroop.mathur@gmail.com> wrote:

> On Sat, Jan 9, 2016 at 1:43 AM, One Thousand Gnomes
> <gnomes@lxorguk.ukuu.org.uk> wrote:
> >> During system boot up, user space buf size is fixed, it cannot be
> >> resized later and we cannot choose by hit&trial.
> >> struct input_event* mBuffer = new input_event[mBuf];
> >
> > Who says that won't change ? Imagine a future case where plugging in a
> > device changes the buffer size ?
> >
> 
> Ofcourse buffer size can be changed but it will also change the value of bufsize
> variable and accordingly user space client should also change its buf size.

If its hot plugged why shouldn't that value change dynamically after
you've asked ?

Alan
