From: lirc@bartelmus.de (Christoph Bartelmus)
Subject: Re: [RFC] What are the goals for the architecture of an in-kernel IR  system?
Date: 29 Nov 2009 20:49:00 +0100
Message-ID: <BDodzfumqgB@lirc>
References: <9e4733910911291116r66dda6dap591d1b0f322f9663@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:56081 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298AbZK2TuF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Nov 2009 14:50:05 -0500
In-Reply-To: <9e4733910911291116r66dda6dap591d1b0f322f9663@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jonsmirl@gmail.com
Cc: alan@lxorguk.ukuu.org.uk, awalls@radix.net, dmitry.torokhov@gmail.com, j@jannau.net, jarod@redhat.com, jarod@wilsonet.com, khc@pm.waw.pl, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, maximlevitsky@gmail.com, mchehab@redhat.com, ray-lk@madrabbit.org, stefanr@s5r6.in-berlin.de, superm1@ubuntu.com

Hi,

on 29 Nov 09 at 14:16, Jon Smirl wrote:
> On Sun, Nov 29, 2009 at 2:04 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>>> Jon is asking for an architecture discussion, y'know, with use cases.
[...]
> So we're just back to the status quo of last year which is to do
> nothing except some minor clean up.
>
> We'll be back here again next year repeating this until IR gets
> redesigned into something fairly invisible like keyboard and mouse
> drivers.

Last year everyone complained that LIRC does not support evdev - so I  
added support for evdev.

This year everyone complains that LIRC is not plug'n'play - we'll fix that  
'til next year.

There's progress. ;-)

Christoph
