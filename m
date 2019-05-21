From: Kai Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] HID: Increase maximum report size allowed by
 hid_field_extract()
Date: Wed, 22 May 2019 00:24:24 +0800
Message-ID: <1B225693-9307-46E2-B468-1529B1FF03CD@canonical.com>
References: <20190308051117.21899-1-kai.heng.feng@canonical.com>
 <CAO-hwJLDuMZuqKiawnkq3YxL6T9SqNGqQ1Q_Vs=kMKmsx6SD0w@mail.gmail.com>
 <08CA35F5-1ADC-4C55-ACF5-04B19CC77A25@canonical.com>
 <nycvar.YFH.7.76.1905092130010.17054@cbobk.fhfr.pm>
 <CAO-hwJKctsp9=ZJuJB6YRtA+RHuv1NJ+9cWp9hub8oATh1MXCA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJKctsp9=ZJuJB6YRtA+RHuv1NJ+9cWp9hub8oATh1MXCA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, =?utf-8?Q?Ronald_Tschal=C3=A4r?= <ronald@innovation.ch>
List-Id: linux-input@vger.kernel.org



> On May 21, 2019, at 9:58 PM, Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
> 
> On Thu, May 9, 2019 at 9:30 PM Jiri Kosina <jikos@kernel.org> wrote:
>> 
>> On Fri, 26 Apr 2019, Kai-Heng Feng wrote:
>> 
>>>> Ronald (Cc-ed) raised quite a good point:
>>>> what's the benefit of removing the error message if this function (and
>>>> __extract) can only report an unsigned 32 bits value?
>>> 
>>> I didn’t spot this, sorry.
>>> 
>>>> 
>>>> My take is we should revert 94a9992f7dbdfb28976b upstream and think at
>>>> a better solution.
>>> 
>>> I think using a new fix to replace it will be a better approach, as it at
>>> least partially solves the issue.
>> 
>> Guys, did this fall in between cracks? Is anyone planning to send a fixup?
>> 
> 
> Kai-Heng, have you been able to work on that?

Sorry, I haven’t been able to work on this.

Please revert the commit and possibly use *_once() macro to reduce the noise.

Kai-Heng

> 
> Cheers,
> Benjamin
