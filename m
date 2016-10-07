From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 5/5] HID: sony: Handle multiple touch events input record
Date: Fri, 7 Oct 2016 18:02:19 +0200
Message-ID: <20161007160219.GF30411@mail.corp.redhat.com>
References: <1475636338-3779-1-git-send-email-roderick@gaikai.com>
 <1475636338-3779-6-git-send-email-roderick@gaikai.com>
 <20161005083548.GC19261@mail.corp.redhat.com>
 <03619b65564e2a66b392b048b1bdc519.squirrel@mungewell.org>
 <CANndSK=p2r-P_mDZFEhKjUB1R9f9_vxrav9Aekdez87HYQCQ9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43250 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938757AbcJGQCY (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 7 Oct 2016 12:02:24 -0400
Content-Disposition: inline
In-Reply-To: <CANndSK=p2r-P_mDZFEhKjUB1R9f9_vxrav9Aekdez87HYQCQ9A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <roderick@gaikai.com>
Cc: Simon Wood <simon@mungewell.org>, linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Oct 05 2016 or thereabouts, Roderick Colenbrander wrote:
> On Wed, Oct 5, 2016 at 8:29 AM, Simon Wood <simon@mungewell.org> wrote:
> > On Wed, October 5, 2016 2:35 am, Benjamin Tissoires wrote:
> >> On Oct 04 2016 or thereabouts, Roderick Colenbrander wrote:
> >
> >>> +            /*
> >>> +             * The first 7 bits of the first byte is a counter and bit 8 is
> >>> +             * a touch indicator that is 0 when pressed and 1 when not
> >>> +             * pressed.
> >>> +             * The next 3 bytes are two 12 bit touch coordinates, X and Y.
> >>> +             * The data for the second touch is in the same format and
> >>> +             * immediately follows the data for the first.
> >>> +             */
> >>> +            for (n = 0; n < 2; n++) {
> >>> +                    u16 x, y;
> >>> +                    bool active;
> >>> +
> >>> +                    x = rd[offset+1] | ((rd[offset+2] & 0xF) << 8);
> >>> +                    y = ((rd[offset+2] & 0xF0) >> 4) | (rd[offset+3] << 4);
> >>> +
> >>> +                    active = !(rd[offset] >> 7);
> >>> +                    input_mt_slot(input_dev, n);
> >>>
> >>
> >> Just to be sure, the device reports 2 touches only, and the
> >> "num_touch_data" chunks are just the history of these 2 touches, the
> >> last chunk being the last known touches?
> >
> > FYI - Community knowledge/understanding...
> > http://www.psdevwiki.com/ps4/DS4-BT#HID_INPUT_reports
> >
> > Simon
> >
> 
> Hi Ben and Simon,
> 
> Correct, the DS4 sends a touch history. The last element is the
> latest. An input report can contain multiple touch samples, because
> the device internally samples at a rate which is higher than at which
> it generates HID reports. On USB you can easily see multiple touch
> events and it is even easier on Bluetooth (especially if it is set to
> a low frequency). The extra history is important for gestures.

OK, so if it's important, you need to actually send it by adding
input_mt_sync_frame() and input_sync() calls. Otherwise, the values will
just get mangled by the kernel in evdev and everything happens as if you
just sent the last pair in the history.

The first 4 patches are IMO mergeable, but this one will need a little
bit more polish to actually forward the events.

Cheers,
Benjamin

> 
> Thanks,
> Roderick
