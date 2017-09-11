From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 1/6] HID: wacom: generic: Send MSC_SERIAL and ABS_MISC
 when leaving prox
Date: Mon, 11 Sep 2017 16:57:59 -0700
Message-ID: <CAF8JNh+7e=2HWNumAQFY1zyfH7mmJXW8Q=6KSPuSMpovt+cxDA@mail.gmail.com>
References: <20170908004412.2698-1-ping.cheng@wacom.com> <nycvar.YFH.7.76.1709081413360.3285@jbgna.fhfr.qr>
 <CAF8JNhJGOaAPL2pJu5P99QKCMCJJdFK0gKGX8wpMXzyDCoSjKw@mail.gmail.com> <nycvar.YFH.7.76.1709111050000.3285@jbgna.fhfr.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.1709111050000.3285@jbgna.fhfr.qr>
Sender: stable-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input <linux-input@vger.kernel.org>, Jason Gerecke <killertofu@gmail.com>, stable@vger.kernel.org, Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
List-Id: linux-input@vger.kernel.org

On Mon, Sep 11, 2017 at 1:51 AM, Jiri Kosina <jikos@kernel.org> wrote:
> On Fri, 8 Sep 2017, Ping Cheng wrote:
>
>> > so, my plan with this patchset is to push first two patches into 4.14-rc
>> > as bufixes, and queue patches 3-6 for next merge window (4.15). Please let
>> > me know in case you disagree.
>>
>> This set of patches were triggered by Bug 196673
>> (https://bugzilla.kernel.org/show_bug.cgi?id=196673). First two
>> patches fix patch f85c9dc678 ("HID: wacom: generic: Support tool ID
>> and additional tool types"). But, they may not be enough to fix Bug
>> 196673. We are waiting for a confirmation from Hrvoje Zeba.
>>
>> If you can't push all 6 into 4.14-rc, just the first 2 would be fine.
>
> I'd like to merge the minimal necessary set required to fix the
> regression, and queue the palm detection / proximity improvements for
> merge window if they are not necessary.
>
> But if you figure out that all 6 patches are needed to fix the regression,
> I'll of course push the full set.
>
> I'll be waiting for your confirmation. Thanks,

Only the first 2 need to go in 4.14-rc. The other 4 can wait until
4.15 is open, as you suggested.

Thank you Jiri.

Ping
