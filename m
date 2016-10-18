From: Roderick Colenbrander <roderick@gaikai.com>
Subject: Re: [PATCH 5/5] HID: sony: Handle multiple touch events input record
Date: Tue, 18 Oct 2016 16:27:42 -0700
Message-ID: <CANndSK=2vZKS3nmzt88j4ugR1YxijwRH_OvEGjWtLzzyyKd9JA@mail.gmail.com>
References: <1475636338-3779-1-git-send-email-roderick@gaikai.com>
 <1475636338-3779-6-git-send-email-roderick@gaikai.com> <20161005083548.GC19261@mail.corp.redhat.com>
 <03619b65564e2a66b392b048b1bdc519.squirrel@mungewell.org> <CANndSK=p2r-P_mDZFEhKjUB1R9f9_vxrav9Aekdez87HYQCQ9A@mail.gmail.com>
 <20161007160219.GF30411@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f176.google.com ([209.85.217.176]:36300 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755504AbcJRX1p (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 18 Oct 2016 19:27:45 -0400
Received: by mail-ua0-f176.google.com with SMTP id m11so423516uab.3
        for <linux-input@vger.kernel.org>; Tue, 18 Oct 2016 16:27:44 -0700 (PDT)
In-Reply-To: <20161007160219.GF30411@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Simon Wood <simon@mungewell.org>, linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

>
> > Correct, the DS4 sends a touch history. The last element is the
> > latest. An input report can contain multiple touch samples, because
> > the device internally samples at a rate which is higher than at which
> > it generates HID reports. On USB you can easily see multiple touch
> > events and it is even easier on Bluetooth (especially if it is set to
> > a low frequency). The extra history is important for gestures.
>
> OK, so if it's important, you need to actually send it by adding
> input_mt_sync_frame() and input_sync() calls. Otherwise, the values will
> just get mangled by the kernel in evdev and everything happens as if you
> just sent the last pair in the history.
>
> The first 4 patches are IMO mergeable, but this one will need a little
> bit more polish to actually forward the events.
>
> Cheers,
> Benjamin
>
> >
> > Thanks,
> > Roderick

Hi Ben,

A kind of follow-up to this patch feedback which made it into the
final patch. The recommendation was to use input_mt_sync_frame, which
was a good recommendation. There is one oversight, which I'm not sure
how we need to handle. Basically input_mt_sync_frame triggers pointer
emulation, which is a problem for the Dualshock 4 since it already
provides an ABS_X / ABS_Y, so the pointer emulation affects the analog
stick values.

The hid-sony driver registers the touchpad through input_mt_init_slots
with the flags parameter '0', which was intended not to request such
emulation I think. I'm not too familiar with the other input code, but
should input_mt_sync_frame gate pointer emulation based on
INPUT_MT_POINTER / INPUT_MT_DIRECT flags or something like that?

Thanks,
Roderick
