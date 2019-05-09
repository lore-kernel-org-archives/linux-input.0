From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: Increase maximum report size allowed by
 hid_field_extract()
Date: Thu, 9 May 2019 21:30:28 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1905092130010.17054@cbobk.fhfr.pm>
References: <20190308051117.21899-1-kai.heng.feng@canonical.com> <CAO-hwJLDuMZuqKiawnkq3YxL6T9SqNGqQ1Q_Vs=kMKmsx6SD0w@mail.gmail.com> <08CA35F5-1ADC-4C55-ACF5-04B19CC77A25@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <08CA35F5-1ADC-4C55-ACF5-04B19CC77A25@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, =?ISO-8859-15?Q?Ronald_Tschal=E4r?= <ronald@innovation.ch>
List-Id: linux-input@vger.kernel.org

On Fri, 26 Apr 2019, Kai-Heng Feng wrote:

> >Ronald (Cc-ed) raised quite a good point:
> >what's the benefit of removing the error message if this function (and
> >__extract) can only report an unsigned 32 bits value?
> 
> I didn’t spot this, sorry.
> 
> >
> >My take is we should revert 94a9992f7dbdfb28976b upstream and think at
> >a better solution.
> 
> I think using a new fix to replace it will be a better approach, as it at
> least partially solves the issue.

Guys, did this fall in between cracks? Is anyone planning to send a fixup?

Thanks,

-- 
Jiri Kosina
SUSE Labs
