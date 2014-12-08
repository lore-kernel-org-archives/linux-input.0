From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Bug report - Input device stopped working ater 3.17 (and isn't
 working with the latest kernel)
Date: Mon, 8 Dec 2014 15:22:30 -0500
Message-ID: <CAN+gG=HtmCFfHaFq8ekjsoEE3EX_CN5yUK9tFNwofi2SCzT-=w@mail.gmail.com>
References: <20141208210942.l7sfuqbb2g48gw0g@webmail.fib.upc.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:53378 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754150AbaLHUWd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Dec 2014 15:22:33 -0500
Received: by mail-qc0-f170.google.com with SMTP id x3so4138456qcv.29
        for <linux-input@vger.kernel.org>; Mon, 08 Dec 2014 12:22:30 -0800 (PST)
In-Reply-To: <20141208210942.l7sfuqbb2g48gw0g@webmail.fib.upc.es>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: josep.sanchez.ferreres@est.fib.upc.edu
Cc: linux-input <linux-input@vger.kernel.org>

On Mon, Dec 8, 2014 at 3:09 PM,  <josep.sanchez.ferreres@est.fib.upc.edu> wrote:
> Thank you very much.
>
> I am collecting the requested data and I'll try to have it ASAP.
>
> Just to make sure, I'm making two log files with hid-replay, one for 3.16
> and the other for 3.18 (should I do 3.17 as well?).

3.16 and 3.18 only should be enough.

>
> For each file I'll record all this cases (each one is a consecutive stream
> of data, I'll separate between cases).
>
> For the touchpad (finger)
>
> - Some circular movements (like moving the mouse cursor)
> - Random taps on the screen
> - Double click (to drag and drop)
> - Pinch zoom gesture
> - Two finger swipes in all directions
> - Three finger swipes in all directions
>
> For the pen (stylus)
>
> - Some circular movements
> - Random clicks on the screen
> - Click and drag and drop
> - Stylus physical button
>
> For the keys
>
> - Test both buttons
>
> Should that be enough? Is it too much?

It should be enough. We must have some extra gestures in the pile, but
that will be interesting enough to see if the hardware provides such
gestures as keyboard shortcuts or if it just forwards all the raw
events directly.
So, thanks for recording all of these.

Cheers,
Benjamin

>
> Thanks!
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
