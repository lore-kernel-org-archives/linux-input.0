From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND] hyper-v: Fix wakeup from suspend-to-idle
Date: Thu, 15 Nov 2018 11:07:44 -0800
Message-ID: <20181115190744.GA212221@dtor-ws>
References: <20181115180933.396-1-vkuznets@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181115180933.396-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Nov 15, 2018 at 07:09:33PM +0100, Vitaly Kuznetsov wrote:
> It makes little sense but still possible to put Hyper-V guests into
> suspend-to-idle state. To wake them up two wakeup sources were registered
> in the past: hyperv-keyboard and hid-hyperv. However, since
> commit eed4d47efe95 ("ACPI / sleep: Ignore spurious SCI wakeups from
> suspend-to-idle") pm_wakeup_event() from these devices is ignored. Switch
> to pm_wakeup_hard_event() API as these devices are actually the only
> possible way to wakeup Hyper-V guests.
> 
> Fixes: eed4d47efe95 (ACPI / sleep: Ignore spurious SCI wakeups from suspend-to-idle)
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: K. Y. Srinivasan <kys@microsoft.com>
> Acked-by: Jiri Kosina <jkosina@suse.cz>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> - It seems the patch slipped through the cracks, resending.

OK, so since nobody else took it I'll push it through my tree.

Thanks.

-- 
Dmitry
