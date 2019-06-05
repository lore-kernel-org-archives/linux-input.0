From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 0/4] few reverts and fixes for 5.2
Date: Wed, 5 Jun 2019 15:07:50 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1906051507060.27227@cbobk.fhfr.pm>
References: <20190605124408.8637-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190605124408.8637-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Dave Hansen <dave.hansen@intel.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 5 Jun 2019, Benjamin Tissoires wrote:

> This has been already publicly discussed here, so I am just posting
> for completeness.
> 
> patch 1:
> request to revert it:
> https://patchwork.kernel.org/patch/10844177/#22651385
> 
> patch 2&3:
> related thread:
> https://lkml.org/lkml/2019/5/28/778
> 
> patch 4:
> bug link: https://bugzilla.kernel.org/show_bug.cgi?id=203619
> and related thread: https://lkml.org/lkml/2019/5/28/778
> 
> Cheers,
> Benjamin
> 
> Benjamin Tissoires (3):
>   Revert "HID: Increase maximum report size allowed by
>     hid_field_extract()"
>   Revert "HID: core: Do not call request_module() in async context"
>   Revert "HID: core: Call request_module before doing device_add"
> 
> Hans de Goede (1):
>   HID: logitech-dj: Fix 064d:c52f receiver support

For the set:

Acked-by: Jiri Kosina <jkosina@suse.cz>

Thanks,

-- 
Jiri Kosina
SUSE Labs
