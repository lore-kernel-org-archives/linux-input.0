From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: core: allow concurrent registration of drivers
Date: Mon, 25 Jun 2018 15:30:12 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1806251529480.6203@cbobk.fhfr.pm>
References: <20180531114929.30545-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180531114929.30545-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Mario.Limonciello@dell.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 31 May 2018, Benjamin Tissoires wrote:

> Detected on the Dell XPS 9365.
> The laptop has 2 devices that benefit from the hid-generic auto-unbinding.
> When those 2 devices are presented to the userspace, udev loads both
> wacom and hid-multitouch. When this happens, the code in
> __hid_bus_reprobe_drivers() is called concurrently and the second device
> gets reprobed twice.
> An other bug in the power_supply subsystem prevent to remove the wacom
> driver if it just finished its initialization, which basically kills
> the wacom node.
> 
> Fixes c17a7476e4c4 ("HID: core: rewrite the hid-generic automatic unbind")
> 
> Cc: stable@vger.kernel.org # v4.17
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Now staged in for-4.18/upstream-fixes_v2, with the plan to send it to 
Linus this week.

Thanks,

-- 
Jiri Kosina
SUSE Labs
