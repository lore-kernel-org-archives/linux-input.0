From: David Rheinsberg <david.rheinsberg@gmail.com>
Subject: Re: [PATCH] HID: uhid: actually use the err number from userspace
Date: Wed, 14 Aug 2019 10:30:22 +0200
Message-ID: <CADyDSO7wyG7Zp6nFAL84b1tQ30t5x-5P+0QZBD-dx6VNm=WoeA@mail.gmail.com>
References: <20190812162105.13428-1-benjamin.tissoires@redhat.com>
 <CADyDSO4x49GWdRVkW=cytvMc7rM3NJkJ4-Sj-FjM9Gday7C-iw@mail.gmail.com> <CAO-hwJ+z0szwuQrUxpQhii2z_jwxMX91df0ynK5QbZpMhg79-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJ+z0szwuQrUxpQhii2z_jwxMX91df0ynK5QbZpMhg79-g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hey

> > 2) I think you have to filter some of the error codes. For instance,
> > if you return one of the -ERESTARTSYS codes, this might cause the
> > syscall to restart (if auto-restart is enabled on this context). At
> > the same time, this is not *that* bad. It might even be useful for the
> > userspace driver to trigger an EINTR. At least we should be aware of
> > this. So maybe filters are not necessary.. Mhhh. Comments?
>
> I haven't thought at all of the side effects of letting the user
> return a random error code.
> I have the impression that anything below EHWPOISON (133) is
> relatively safe. So maybe we should just make sure the error code is
> below 134?
>
> The ERESTARTSYS has a few warnings in the include file, so I guess the
> side effects might be too much for what we want to deal with.

How about `err < ERESTARTSYS`? That is, we grant user-space the entire
range [1-511]. This seems to be the range reserved for uapi.

I think the ERESTART* codes would be fine as well, but I also don't
believe there to be any actual use-case for them. Anyway, I am fine
with either range.

Thanks
David
