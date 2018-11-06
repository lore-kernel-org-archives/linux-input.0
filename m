From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH] hyper-v: Fix wakeup from suspend-to-idle
Date: Tue, 06 Nov 2018 18:07:05 +0100
Message-ID: <87ftweuocm.fsf@vitty.brq.redhat.com>
References: <20180912161101.2634-1-vkuznets@redhat.com> <nycvar.YFH.7.76.1809241123040.15880@cbobk.fhfr.pm> <CAJZ5v0g10fyZZhvLTz_qSADWQCO==fg=zcFQHD7QLZYwVDOsgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0g10fyZZhvLTz_qSADWQCO==fg=zcFQHD7QLZYwVDOsgA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Jiri Kosina <jikos@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

"Rafael J. Wysocki" <rafael@kernel.org> writes:

> On Mon, Sep 24, 2018 at 11:24 AM Jiri Kosina <jikos@kernel.org> wrote:
>>
>> On Wed, 12 Sep 2018, Vitaly Kuznetsov wrote:
>>
>> > It makes little sense but still possible to put Hyper-V guests into
>> > suspend-to-idle state. To wake them up two wakeup sources were registered
>> > in the past: hyperv-keyboard and hid-hyperv. However, since
>> > commit eed4d47efe95 ("ACPI / sleep: Ignore spurious SCI wakeups from
>> > suspend-to-idle") pm_wakeup_event() from these devices is ignored. Switch
>> > to pm_wakeup_hard_event() API as these devices are actually the only
>> > possible way to wakeup Hyper-V guests.
>> >
>> > Fixes: eed4d47efe95 (ACPI / sleep: Ignore spurious SCI wakeups from suspend-to-idle)
>> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> > ---
>> >  drivers/hid/hid-hyperv.c              | 2 +-
>>
>>         Acked-by: Jiri Kosina <jkosina@suse.cz>
>>
>> for the above. I guess this'd better go through ACPI tree?
>
> No problem with that if you prefer.
>

It seems this patch got lost somewhere :-( 

-- 
Vitaly
