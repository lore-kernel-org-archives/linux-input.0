From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v3 0/8] HID: MS and Logitech high-resolution scroll wheel support
Date: Fri, 7 Dec 2018 17:18:16 +0100
Message-ID: <CAO-hwJLO8o-nZ4H_it5q1fm4YQQBmoGvF2vSmBft3WiGdDx+JA@mail.gmail.com>
References: <20181205004228.10714-1-peter.hutterer@who-t.net> <CA+jURcugFhSt9GGRZELQUCnupOf2Ns96Ao5ZruWfVtq=z_7ytw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+jURcugFhSt9GGRZELQUCnupOf2Ns96Ao5ZruWfVtq=z_7ytw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hcutts@chromium.org
Cc: Peter Hutterer <peter.hutterer@who-t.net>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Nestor Lopez Casado <nlopezcasad@logitech.com>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Dec 5, 2018 at 10:57 PM Harry Cutts <hcutts@chromium.org> wrote:
>
> On Tue, 4 Dec 2018 at 16:42, Peter Hutterer <peter.hutterer@who-t.net> wrote:
> >
> > A full explanation of why and what is in the v1, v2 patch thread here:
> > https://lkml.org/lkml/2018/11/22/625
> >
> > v3 adds a better commit messages, m560 REL_HWHEEL_HI_RES support and a patch
> > moved in the ordering. This is a full patch sequence because Benjamin's
> > magic scripts struggle with singular updates ;)
>
> I've retested with the same Logitech mice as before, except for the MX
> Anywhere 2S, which is currently not available to me. So, for
> reference, that's the MX Master 2S, Performance MX, M560, Anywhere MX,
> and the M325 (to check low-resolution scrolling).
>
> Verified-by: Harry Cutts <hcutts@chromium.org>

Thanks everybody, especially Peter for respinning and re-writing the
series, and writing the tests in hid-tools.

I was a little bit afraid when I checked `libinput debug-gui` as the
low res cursor was not moving if I were to scroll back and forth of
just one notch. However, checking debug-events of a non high-res aware
libinput showed that the low res wheel events were correctly emitted.
So I guess this is a debug-gui issue.

I have now queued this for 4.21. I do hope this will be smoother this time.

Cheers,
Benjamin
