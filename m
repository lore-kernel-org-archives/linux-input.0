From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Method to power off HID device from driver?
Date: Tue, 24 Jan 2017 10:47:33 +0100
Message-ID: <1485251253.5845.15.camel@hadess.net>
References: <CANndSKn1JE0Fnxgn9rpUyR1fUv7GM_Y4xwpfevSUiOYnVSYYig@mail.gmail.com>
         <CANndSK=-V0DXWh=XCr=GUAyWvQ0ZKrRfDdkvhFMbVWTj57+uiQ@mail.gmail.com>
         <D5A9B8BF-4720-4BB4-826E-CCA150D2976F@gmail.com>
         <1481168348.2286.11.camel@hadess.net>
         <CANndSKkeMtLp6S2MRXFHTrdyUnVQ7HqwyKB2F-pqbgJFPh8A9w@mail.gmail.com>
         <alpine.LSU.2.20.1701191436220.25515@cbobk.fhfr.pm>
         <1484833373.21721.8.camel@hadess.net>
         <CANndSKkp+wYjp4DpWX5VK7MLWEn60tgcc5QX=r87gPQJKvkoPg@mail.gmail.com>
         <1484843168.21721.9.camel@hadess.net>
         <CANndSKmuZc72hPVbC3o-CL_wGwo+-Y63y_eLSEhsgwjaMU=pSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:55695 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750728AbdAXJrk (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 24 Jan 2017 04:47:40 -0500
In-Reply-To: <CANndSKmuZc72hPVbC3o-CL_wGwo+-Y63y_eLSEhsgwjaMU=pSA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <roderick@gaikai.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Cameron Gutman <aicommander@gmail.com>

On Thu, 2017-01-19 at 10:07 -0800, Roderick Colenbrander wrote:
> On Thu, Jan 19, 2017 at 8:26 AM, Bastien Nocera <hadess@hadess.net>
> wrote:
> > On Thu, 2017-01-19 at 08:18 -0800, Roderick Colenbrander wrote:
> > > In my case it are Hid packets to trigger a disconnect.
> > 
> > "HID packets" isn't a hardware transport.
> 
> My reply was a little too quick. The devices we like this capability
> for are Bluetooth and USB based, so for Bluetooth we care about uhid
> /
> bt-hidp and for USB usb-hid.

What's the use case for USB based devices? Is this to "switch off" pads
like on XBox and Playstation consoles? I'm pretty sure the devices are
still on. Do you expect an unplug/replug to be necessary for USB
devices?
