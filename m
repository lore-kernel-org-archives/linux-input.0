From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Input: evdev - add ioctl cmd EVIOCGBUFSIZE to get
 buffer size
Date: Fri, 8 Jan 2016 20:13:46 +0000
Message-ID: <20160108201346.6a6694e2@lxorguk.ukuu.org.uk>
References: <1452266588-3139-1-git-send-email-a.mathur@samsung.com>
	<CANq1E4T0UVLijsFivcANtMjknn6bkq7W5nned_hAvRQD=K94Nw@mail.gmail.com>
	<CADYu30_KWWELgNM4a0Lyd_AoewpmhizuxJxXJSXzoGSF5YFOZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:60620 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbcAHUOA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Jan 2016 15:14:00 -0500
In-Reply-To: <CADYu30_KWWELgNM4a0Lyd_AoewpmhizuxJxXJSXzoGSF5YFOZg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aniroop Mathur <aniroop.mathur@gmail.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, Aniroop Mathur <a.mathur@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

> During system boot up, user space buf size is fixed, it cannot be
> resized later and we cannot choose by hit&trial.
> struct input_event* mBuffer = new input_event[mBuf];

Who says that won't change ? Imagine a future case where plugging in a
device changes the buffer size ?

Alan
