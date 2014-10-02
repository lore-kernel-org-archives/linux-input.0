From: Andrew de los Reyes <andrew-vger@gizmolabs.org>
Subject: Re: [PATCH 00/13] HID: add support of Logitech touchpads and special devices
Date: Thu, 2 Oct 2014 11:19:21 -0700
Message-ID: <CAG_cf+fYGATBL9Sgvvp7CaScP112fiqiyuR0gBdkS-424S3Kog@mail.gmail.com>
References: <1412097515-17241-1-git-send-email-benjamin.tissoires@redhat.com>
 <alpine.LNX.2.00.1410011016160.26311@pobox.suse.cz> <20141001131008.GB18756@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141001131008.GB18756@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-kernel@vger.kernel.org, Linux Input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

I've tested these patches successfully on a Chromebook Pixel with the
following devices:

- T650 touchpad
- TK820 keyboard/touchpad
- Original WTP touchpad

I also tested a touch mouse and as expected it continued to function
as a plain USB mouse. The TK820 was indeed broken into two devices,
with autorepeat enabled for the keyboard only. The other two devices
behaved as expected with no perceived regressions.

In short, from a functionality perspective I'm happy with these
patches. I will let others discuss code structure.

-andrew

On Wed, Oct 1, 2014 at 6:10 AM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> On Oct 01 2014 or thereabouts, Jiri Kosina wrote:
>> On Tue, 30 Sep 2014, Benjamin Tissoires wrote:
>>
>> > Jiri, This patch series can be split in 2 if you would like:
>> > - patches 1 to 4 can be scheduled easily for 3.18 IMO
>> > - patches 5 to 13 might need some more reviews, so either 3.18 or 3.19
>>
>> Benjamin,
>>
>> thanks for the summary. I'll try to review 1-4 in time for 3.18, but I
>> can't guarantee that.
>>
>
> Thanks
>
>> Do you forsee any issues if the whole lot is queued for 3.19 only?
>
> Nope. It waited since 2011, so it can wait 3 more months :)
>
> Cheers,
> Benjamin
>
