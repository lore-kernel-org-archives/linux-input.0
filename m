From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [sur40] videobuf2 and/or DMA?
Date: Thu, 11 Dec 2014 09:58:59 +0100
Message-ID: <CANq1E4QXAyGccPExgvZJO74aBwEOHHM8_Ysv8nx8dLmcmVBnCA@mail.gmail.com>
References: <54855856.3070207@butterbrot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:33288 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934168AbaLKI7A (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Dec 2014 03:59:00 -0500
Received: by mail-ig0-f182.google.com with SMTP id hn15so4479273igb.9
        for <linux-input@vger.kernel.org>; Thu, 11 Dec 2014 00:58:59 -0800 (PST)
In-Reply-To: <54855856.3070207@butterbrot.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: linux-input <linux-input@vger.kernel.org>, Oliver Neukum <oneukum@suse.de>, Alan Stern <stern@rowland.harvard.edu>, Hans de Goede <hdegoede@redhat.com>

Hi

On Mon, Dec 8, 2014 at 8:50 AM, Florian Echtler <floe@butterbrot.org> wrote:
> Hello everyone,
>
> I'm preparing to finally add support for the raw sensor video stream to
> my driver for the SUR40 touchscreen. However, after an extensive amount
> of Googling, I'm still not clear on the relationship between DMA
> transfers, the USB core and the videobuf2 framework.
>
> Specifically, I'd like to know:
>
> - Can I always use DMA on the USB side (for bulk transfers), or does
> this in any way require support from the USB device's hardware? (I'm
> guessing no, but a definite answer would be great.)

I thought the USB API hides that from you? Nevertheless, this is a
question for linux-usb, not linux-input. I put some people on CC which
work on both, HID and USB. Maybe they can help you.

> - Regardless of the USB side of things, can I use the videobuf2
> framework without _having_ to use DMA? That way, I could get a basic
> driver running without DMA and switch later when it's convenient and/or
> the speedup is justified.

This is definitely a question for linux-media.

Thanks
David
