From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Missing release event for Synaptics touchscreen
Date: Tue, 9 May 2017 10:35:41 +0200
Message-ID: <CAN+gG=FxbBc78Aw+WUxSFBfhTxbgGRJWTftgoRYYR-+1-OMioQ@mail.gmail.com>
References: <708339c2-2b70-81ae-a939-ac122e5fd6f2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:32963 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752137AbdEIIfn (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 9 May 2017 04:35:43 -0400
Received: by mail-wm0-f52.google.com with SMTP id n198so23346809wmg.0
        for <linux-input@vger.kernel.org>; Tue, 09 May 2017 01:35:42 -0700 (PDT)
In-Reply-To: <708339c2-2b70-81ae-a939-ac122e5fd6f2@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arek Burdach <arek.burdach@gmail.com>
Cc: =?UTF-8?Q?St=C3=A9phane_Chatty?= <chatty@enac.fr>, Andrew Duggan <aduggan@synaptics.com>, linux-input <linux-input@vger.kernel.org>

On Sat, May 6, 2017 at 9:28 PM, Arek Burdach <arek.burdach@gmail.com> wrote:
> Hi,
>
> A week ago I've reported a bug:
> https://bugzilla.kernel.org/show_bug.cgi?id=195625 Is there anybody that can
> help me with it?

I can have a look at it.
Please attach the full outputs of hid-recorder and evemu-record in the
bugs, or it'll be difficult for us to debug it.

> I found out that some touchpads (and possible touchscreens?) are handled by
> both hid-multitouch and hid-rmi drivers. Is there a way to verify how the
> touchscreen would work on hid-rmi drivers? I've tested it with kernel
> 4.11.0-rc1 version where was this change:
> 279967a65b320d174a507498aea7d44db3fee7f4 HID: rmi: Handle all Synaptics
> touchpads using hid-rmi
> which was reverted in later kernel's version. On this version, only my
> touchpad was handled by hid-rmi, touchscreen was still handled by
> hid-multitouch. Maybe I should change something in code or in compilation
> configuration to force hid-rmi?

Well, with 279967a65 applied, the system would know if the device can
be handled through hid-rmi or not. If hid-multitouch was still used,
that means that the device was not designed to be used as a rmi device
at all (i.e. hid-rmi will not be able to talk to it).

Cheers,
Benjamin

> Or it is a wrong way to go? I would be grateful for your help.
>
> Regards,
> Arek
