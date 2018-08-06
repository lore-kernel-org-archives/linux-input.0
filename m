From: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject: Re: [PATCH] Input: cros_ec_keyb: Remove check before calling pm_wakeup_event.
Date: Mon, 6 Aug 2018 16:05:46 -0700
Message-ID: <CAEZbON72eVUCNT3ePEZKrB5B6+6YYgO7=X0TY0eBqUb3ws0sLA@mail.gmail.com>
References: <CGME20180803072628eucas1p26abe0cb121b974401759502f8807bb96@eucas1p2.samsung.com>
 <20180605224458.62692-1-ravisadineni@chromium.org> <20180803072628eucas1p26abe0cb121b974401759502f8807bb96~HTx4BGQjl1119311193eucas1p2U@eucas1p2.samsung.com>
 <CAEZbON7qLheHFuU6zwArCz=CG03JvnFjcehBGjE4RqROYrMLhQ@mail.gmail.com>
 <CAKdAkRQG08d_duPiKFi_=xUNO93c0Rcw9kpaYFFJahjJM-NdGw@mail.gmail.com>
 <CAEZbON4O0X8Fo6eAbmPOSiB1_Tw7x+Ox3ROoGfZQn72uQGQLkg@mail.gmail.com>
 <20180806052949eucas1p2483800c02730febd03d4a661a25fa405~INH40XvCx2719627196eucas1p2X@eucas1p2.samsung.com>
 <CAKdAkRSvLq-L3FrODUqxXqDs2FymM9k5dZRxnOpc44rFiHaWAQ@mail.gmail.com> <20180806071543eucas1p233ac5016e1a586594cf8ecd1fe3214b0~IOkV1Zt7j2129321293eucas1p20@eucas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180806071543eucas1p233ac5016e1a586594cf8ecd1fe3214b0~IOkV1Zt7j2129321293eucas1p20@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ravi Chandra Sadineni <ravisadineni@google.com>, Todd Broch <tbroch@google.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Merek,

Thanks for the info. Lemme understand what's going on. Will update the
thread once I have more info.

Thanks,
Ravi
On Mon, Aug 6, 2018 at 12:15 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi Dmitry
>
> On 2018-08-06 08:16, Dmitry Torokhov wrote:
> > On Sun, Aug 5, 2018 at 10:29 PM Marek Szyprowski
> > <m.szyprowski@samsung.com> wrote:
> >> Hi Ravi,
> >>
> >> On 2018-08-03 18:53, Ravi Chandra Sadineni wrote:
> >>> Understood. I am trying to reproduce this issue locally. Wanted to
> >>> know the version of the kernel so I can give a try. Marek, can you
> >>> please confirm the kernel version.
> >>>
> >> Yes, sorry for the missing context, I was in hurry writing the report and
> >> I wanted to send it before leaving the office. I'm testing mainline on Snow
> >> with exynos_defconfig.
> >>
> >> Suspend/resume is partially broken already with mainline, but if you disable
> >> CPUfreq support, it works fine on Linux v4.17.
> >>
> >> I've posted CPUfreq related fixes here if you are interested:
> >> https://patchwork.kernel.org/patch/10554607/
> >> https://patchwork.kernel.org/patch/10554603/
> >>
> >> The issue with cros_ec_keyb patch appears first on Linux v4.18-rc1, which is
> >> the first release with that patch.
> > Marek, this patch should only be in -next, I do not believe I sent it
> > to Linus just yet. If mainline is broken for you it can't be caused by
> > this patch.
>
> Aaahh. My fault then. The suspend/resume issue is cause by commit
> 38ba34a43dbc ("Input: cros_ec_keyb - mark cros_ec_keyb driver as wake
> enabled device."), which has been merged to v4.18-rc1.
>
> It looks that I've downloaded wrong patch from the patchwork to reply it
> with a a bug report. :( I'm really sorry for the noise in the wrong thread.
>
> Ravi: please let me know how can I help you to debug this issue.
>
> >
> >> Linux -next from 20180803, which has a few
> >> more patches for cros_ec_keyb suffers from the same issue.
> > Just to confirm, if you revert only this patch from -next you get
> > suspend/resume back?
> >
> > Thanks.
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
