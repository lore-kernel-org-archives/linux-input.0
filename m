From: Roderick Colenbrander <roderick@gaikai.com>
Subject: Re: Method to power off HID device from driver?
Date: Thu, 19 Jan 2017 10:07:07 -0800
Message-ID: <CANndSKmuZc72hPVbC3o-CL_wGwo+-Y63y_eLSEhsgwjaMU=pSA@mail.gmail.com>
References: <CANndSKn1JE0Fnxgn9rpUyR1fUv7GM_Y4xwpfevSUiOYnVSYYig@mail.gmail.com>
 <CANndSK=-V0DXWh=XCr=GUAyWvQ0ZKrRfDdkvhFMbVWTj57+uiQ@mail.gmail.com>
 <D5A9B8BF-4720-4BB4-826E-CCA150D2976F@gmail.com> <1481168348.2286.11.camel@hadess.net>
 <CANndSKkeMtLp6S2MRXFHTrdyUnVQ7HqwyKB2F-pqbgJFPh8A9w@mail.gmail.com>
 <alpine.LSU.2.20.1701191436220.25515@cbobk.fhfr.pm> <1484833373.21721.8.camel@hadess.net>
 <CANndSKkp+wYjp4DpWX5VK7MLWEn60tgcc5QX=r87gPQJKvkoPg@mail.gmail.com> <1484843168.21721.9.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:36827 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753606AbdASSIH (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 19 Jan 2017 13:08:07 -0500
Received: by mail-oi0-f41.google.com with SMTP id u143so29319212oif.3
        for <linux-input@vger.kernel.org>; Thu, 19 Jan 2017 10:07:08 -0800 (PST)
In-Reply-To: <1484843168.21721.9.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Cameron Gutman <aicommander@gmail.com>

On Thu, Jan 19, 2017 at 8:26 AM, Bastien Nocera <hadess@hadess.net> wrote:
> On Thu, 2017-01-19 at 08:18 -0800, Roderick Colenbrander wrote:
>> In my case it are Hid packets to trigger a disconnect.
>
> "HID packets" isn't a hardware transport.

My reply was a little too quick. The devices we like this capability
for are Bluetooth and USB based, so for Bluetooth we care about uhid /
bt-hidp and for USB usb-hid.
