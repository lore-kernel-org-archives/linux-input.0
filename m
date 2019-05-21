From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: Increase maximum report size allowed by hid_field_extract()
Date: Tue, 21 May 2019 15:58:01 +0200
Message-ID: <CAO-hwJKctsp9=ZJuJB6YRtA+RHuv1NJ+9cWp9hub8oATh1MXCA@mail.gmail.com>
References: <20190308051117.21899-1-kai.heng.feng@canonical.com>
 <CAO-hwJLDuMZuqKiawnkq3YxL6T9SqNGqQ1Q_Vs=kMKmsx6SD0w@mail.gmail.com>
 <08CA35F5-1ADC-4C55-ACF5-04B19CC77A25@canonical.com> <nycvar.YFH.7.76.1905092130010.17054@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.1905092130010.17054@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Ronald_Tschal=C3=A4r?= <ronald@innovation.ch>
List-Id: linux-input@vger.kernel.org

On Thu, May 9, 2019 at 9:30 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Fri, 26 Apr 2019, Kai-Heng Feng wrote:
>
> > >Ronald (Cc-ed) raised quite a good point:
> > >what's the benefit of removing the error message if this function (and
> > >__extract) can only report an unsigned 32 bits value?
> >
> > I didn’t spot this, sorry.
> >
> > >
> > >My take is we should revert 94a9992f7dbdfb28976b upstream and think at
> > >a better solution.
> >
> > I think using a new fix to replace it will be a better approach, as it at
> > least partially solves the issue.
>
> Guys, did this fall in between cracks? Is anyone planning to send a fixup?
>

Kai-Heng, have you been able to work on that?

Cheers,
Benjamin
