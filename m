From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v6] HID: sb0540: add support for Creative SB0540 IR receivers
Date: Tue, 3 Sep 2019 17:13:49 +0200
Message-ID: <CAO-hwJLGfvNMgV9eU8xAur+a1NbvtV62gD2XVY6WXdOKrx0JUQ@mail.gmail.com>
References: <20190702083931.7392-1-hadess@hadess.net> <2505a7c3e29afb5a140ed47e54ea9c72d0192367.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2505a7c3e29afb5a140ed47e54ea9c72d0192367.camel@hadess.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Bastien Nocera <bnocera@redhat.com>
List-Id: linux-input@vger.kernel.org

On Tue, Sep 3, 2019 at 4:15 PM Bastien Nocera <hadess@hadess.net> wrote:
>
> Hey,
>
> On Tue, 2019-07-02 at 10:39 +0200, Bastien Nocera wrote:
> > From: Bastien Nocera <bnocera@redhat.com>
> >
> > Add a new hid driver for the Creative SB0540 IR receiver. This
> > receiver
> > is usually coupled with an RM-1500 or an RM-1800 remote control.
> >
> > The scrollwheels on the RM-1800 remote are not bound, as they are
> > labelled for specific audio controls that don't usually exist on most
> > systems. They can be remapped using standard Linux keyboard
> > remapping tools.
>
> I'm back from travelling, so ready to update/respin this patch if
> needed.
>

Nope, looks good now.

Applied to for-5.4/sb0540

Sorry for the delay, a mess in my mailbox hid the v6.

Cheers,
Benjamin
