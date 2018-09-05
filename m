From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/4] HID: multitouch: fix Elan panels with 2 input modes declaration
Date: Wed, 5 Sep 2018 09:01:15 +0200
Message-ID: <CAO-hwJ+MN=BR_ZS4_GpZitqu2WR+kYSJ3MikQrt8qHFheAbqrQ@mail.gmail.com>
References: <20180904133115.5111-1-benjamin.tissoires@redhat.com>
 <20180904133115.5111-2-benjamin.tissoires@redhat.com> <nycvar.YFH.7.76.1809042130260.15880@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.1809042130260.15880@cbobk.fhfr.pm>
Sender: stable-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "3.8+" <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Sep 4, 2018 at 9:31 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Tue, 4 Sep 2018, Benjamin Tissoires wrote:
>
> > When implementing commit 7f81c8db5489 ("HID: multitouch: simplify
> > the settings of the various features"), I wrongly removed a test
> > that made sure we never try to set the second InputMode feature
> > to something else than 0.
> >
> > This broke badly some recent Elan panels that now forget to send the
> > click button in some area of the touchpad.
> >
> > Fixes 7f81c8db5489
>
> Please make sure that the 'Fixes:' tag is always in proper format. There
> are tools depending on that :)

Oops, thanks for fixing it. Lazy me :)

Cheers,
Benjamin

>
> I'll fix that up manually.
>
> Thanks!
>
> --
> Jiri Kosina
> SUSE Labs
>
