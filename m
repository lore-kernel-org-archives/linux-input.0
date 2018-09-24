From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] hyper-v: Fix wakeup from suspend-to-idle
Date: Mon, 24 Sep 2018 11:24:12 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1809241123040.15880@cbobk.fhfr.pm>
References: <20180912161101.2634-1-vkuznets@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180912161101.2634-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 12 Sep 2018, Vitaly Kuznetsov wrote:

> It makes little sense but still possible to put Hyper-V guests into
> suspend-to-idle state. To wake them up two wakeup sources were registered
> in the past: hyperv-keyboard and hid-hyperv. However, since
> commit eed4d47efe95 ("ACPI / sleep: Ignore spurious SCI wakeups from
> suspend-to-idle") pm_wakeup_event() from these devices is ignored. Switch
> to pm_wakeup_hard_event() API as these devices are actually the only
> possible way to wakeup Hyper-V guests.
> 
> Fixes: eed4d47efe95 (ACPI / sleep: Ignore spurious SCI wakeups from suspend-to-idle)
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  drivers/hid/hid-hyperv.c              | 2 +-

	Acked-by: Jiri Kosina <jkosina@suse.cz>

for the above. I guess this'd better go through ACPI tree?

Thanks,

-- 
Jiri Kosina
SUSE Labs
