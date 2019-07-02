From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v5] HID: sb0540: add support for Creative SB0540 IR receivers
Date: Tue, 2 Jul 2019 10:44:23 +0200
Message-ID: <CAO-hwJLmewFMcFpn4X1RhjgpuYCRnDJgL5Vu5kduy8a0LUgQjA@mail.gmail.com>
References: <20190701102010.6611-1-hadess@hadess.net> <CAO-hwJ+hHKqZeOfpnWkU57RwzD4m6U9afG7iMND=OGZodzS1GQ@mail.gmail.com>
 <9171d69f51a6a197e0d554326fcedc39bfb3fbbc.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9171d69f51a6a197e0d554326fcedc39bfb3fbbc.camel@hadess.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Bastien Nocera <bnocera@redhat.com>
List-Id: linux-input@vger.kernel.org

On Tue, Jul 2, 2019 at 10:39 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Tue, 2019-07-02 at 10:29 +0200, Benjamin Tissoires wrote:
> > drivers/hid/hid-creative-sb0540.c: In function
> > 'creative_sb0540_raw_event':
> > drivers/hid/hid-creative-sb0540.c:157:3: error: label 'out' used but
> > not defined
> >   157 |   goto out;
> >       |   ^~~~
> >
> > It would have been nice to at least try to compile it in a tree.
> > You don't need to compile the whole tree: just clone it, apply your
> > patch and then `make -j4 M=drivers/hid`
>
> v4 _did_ build. Don't be surprised if after 4 versions on top of the
> ones you did when the driver was out of tree, I get review fatigue, go
> for expediency and some mistakes slip through.

Right, sorry.

>
> Fixed in v6.
>

Thanks!

Cheers,
Benjamin
