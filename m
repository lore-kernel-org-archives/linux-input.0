From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] add sur40 driver for Samsung SUR40 (aka MS Surface
 2.0/Pixelsense)
Date: Tue, 22 Oct 2013 08:47:04 -0700
Message-ID: <20131022154703.GB13473@core.coreip.homeip.net>
References: <1382287751-21515-1-git-send-email-floe@butterbrot.org>
 <20131021162006.GB4575@core.coreip.homeip.net>
 <5266164C.3060509@butterbrot.org>
 <CANq1E4R88OooYjFz0d46uJZgvD=a_qzVVxV74wQzWfaUB7WBEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:57112 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753018Ab3JVPrH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Oct 2013 11:47:07 -0400
Received: by mail-pa0-f42.google.com with SMTP id kx10so10067545pab.1
        for <linux-input@vger.kernel.org>; Tue, 22 Oct 2013 08:47:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANq1E4R88OooYjFz0d46uJZgvD=a_qzVVxV74wQzWfaUB7WBEg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Florian Echtler <floe@butterbrot.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Henrik Rydberg <rydberg@euromail.se>

On Tue, Oct 22, 2013 at 05:22:08PM +0200, David Herrmann wrote:
> Hi
> 
> On Tue, Oct 22, 2013 at 8:08 AM, Florian Echtler <floe@butterbrot.org> wrote:
> > Hello Dmitry,
> >
> > thanks for your quick feedback, a few questions below:
> >
> > On 21.10.2013 18:20, Dmitry Torokhov wrote:
> >> On Sun, Oct 20, 2013 at 06:49:11PM +0200, Florian Echtler wrote:
> >>> +/* read 512 bytes from endpoint 0x86 -> get header + blobs */
> >>> +struct sur40_header {
> >>> +
> >>> +    uint16_t type;       /* always 0x0001 */
> >>> +    uint16_t count;      /* count of blobs (if 0: continue prev. packet) */
> >>> +
> >>> +    uint32_t packet_id;
> >>> +
> >>> +    uint32_t timestamp;  /* milliseconds (inc. by 16 or 17 each frame) */
> >>> +    uint32_t unknown;    /* "epoch?" always 02/03 00 00 00 */
> >>
> >> Proper internal kernel types are u8, u16, u32. For user-facing APIs
> >> __u8, __u16, and __u32 should be used. Also, since this is data coming
> >> directly off the wire, you should be using __le16, __le32, etc, and then
> >> do __leXX_to_cpu() conversion before using it in calculations.
> > OK, I'll switch to u32 throughout (also for the float, I'll explain in a
> > commment). However, I haven't found a single other touchscreen driver
> > which uses __le32, even though they all probably process raw wire data -
> > can you suggest an example?
> 
> These are probably all broken or the hardware guarantees
> cpu-byte-order. Anyway, what you should do is use __le16/32 for your
> types which represent data from the device. Then call le16_to_cpu() on
> these values to convert it to host byte-order. Something like this:
> 
> struct sur40_raw_header {
>   __le16 type;
>   __le32 unused;
>   __le8 count;

Not the last one please ;)

Thanks.

-- 
Dmitry
