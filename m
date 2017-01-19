From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Method to power off HID device from driver?
Date: Thu, 19 Jan 2017 14:42:53 +0100
Message-ID: <1484833373.21721.8.camel@hadess.net>
References: <CANndSKn1JE0Fnxgn9rpUyR1fUv7GM_Y4xwpfevSUiOYnVSYYig@mail.gmail.com>
         <CANndSK=-V0DXWh=XCr=GUAyWvQ0ZKrRfDdkvhFMbVWTj57+uiQ@mail.gmail.com>
         <D5A9B8BF-4720-4BB4-826E-CCA150D2976F@gmail.com>
         <1481168348.2286.11.camel@hadess.net>
         <CANndSKkeMtLp6S2MRXFHTrdyUnVQ7HqwyKB2F-pqbgJFPh8A9w@mail.gmail.com>
         <alpine.LSU.2.20.1701191436220.25515@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:34377 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751902AbdASNsJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 19 Jan 2017 08:48:09 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by slow1-d.mail.gandi.net (Postfix) with ESMTP id 1A58B4B7266
        for <linux-input@vger.kernel.org>; Thu, 19 Jan 2017 14:44:19 +0100 (CET)
In-Reply-To: <alpine.LSU.2.20.1701191436220.25515@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Roderick Colenbrander <roderick@gaikai.com>
Cc: Cameron Gutman <aicommander@gmail.com>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Thu, 2017-01-19 at 14:37 +0100, Jiri Kosina wrote:
> On Mon, 9 Jan 2017, Roderick Colenbrander wrote:
> 
> > From the sounds of it various others are interested in the ability
> > to
> > trigger a device disconnect as well. Since I don't think any of us
> > have a good enough understanding of the HID / input frameworks, I'm
> > adding Benjamin and Jiri. Maybe they have some good ideas on how to
> > tackle this.
> 
> Well, this really depends on the low-level (transport, as we call it
> in 
> HID) driver.
> 
> USB, for example, has it's own runtime power management, and the
> devices 
> auto-suspend and auto-resume themselves almost automatically without
> too 
> many specific generic code requirements.
> 
> What is the hardware transport we're talking about here?

>From my side, it's Bluetooth.
