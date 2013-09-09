From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: HID input dealing with multiple collections?
Date: Mon, 9 Sep 2013 15:12:34 +0200
Message-ID: <CAN+gG=ELptZsD37P9XMAgbLCFt-yZVbgmbGrk+mLvT6G2raKLQ@mail.gmail.com>
References: <522DC594.2000305@brettnet.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:41770 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178Ab3IINMf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Sep 2013 09:12:35 -0400
Received: by mail-la0-f44.google.com with SMTP id eo20so4884612lab.17
        for <linux-input@vger.kernel.org>; Mon, 09 Sep 2013 06:12:34 -0700 (PDT)
In-Reply-To: <522DC594.2000305@brettnet.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Breton M. Saunders" <bms20@brettnet.eu>
Cc: linux-input <linux-input@vger.kernel.org>

Hi,

On Mon, Sep 9, 2013 at 2:56 PM, Breton M. Saunders <bms20@brettnet.eu> wrote:
> Hello,
>
>   I've written a USB device which supports multiple input devices:
>     * A touch surface digitizer (following Microsoft's specification)
>     * A pen surface digitizer
>     * A mouse emulator
>
>   In windows each of these interfaces are exposed as a separate top level
> collection, e.g.:
>   Usage_Page(Generic Desktop)
>   Usage(Mouse)
>   Collection(Application)
>        ...
>   End_Collection
>   Usage_Page(Digitzer)
>   Usage(Touch_Screen)
>   Collection(Application)
>      ...
>   End_Collection
>   Usage(Digitizer)
>   Usage(Pen)
>   Collection(Application)
>      ...
>   End_Collection
>
>   Now this descriptor works well in Windows; all reporting channels are
> exposed correctly as hid devices and mouse/multitouch/pen input all works
> correctly as expected.  In linux, however, this is not the case.  What I see
> is that if I drop out the touch/pen functionality then the mouse support
> works correctly.  Likewise, if I drop any pair of other top level
> collections such that I have exactly one top level collection the system
> works correctly.
>
>   Am I missing something here - as in: Have I made an error in my usage of
> top level collections, or is linux-input's hid support incapable of dealing
> with multiple top level collections?

If it works under Windows, there are huge chances that your report
descriptor is good.

However, under Linux, we use the report IDs to split (if required) the
different inputs.
The good thing for you is that if I understand correctly, the device
you are talking about should be handled through hid-multitouch. Since
kernel v3.10, we have introduced the support of devices showing both a
digitizer and a pen (they will show up as two input devices).

I would encourage you to test a 3.10 kernel, and/or send me some
traces of your devices by using hid-replay[1]. This way I will be able
to test your device on my laptop, and eventually figure out any
problem.

Cheers,
Benjamin

[1] http://bentiss.github.io/hid-replay-docs/
