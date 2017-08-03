From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 0/4] constify hid attribute_group structures.
Date: Thu, 3 Aug 2017 13:41:33 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1708031340440.30597@cbobk.fhfr.pm>
References: <1501759603-18121-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501759603-18121-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 3 Aug 2017, Arvind Yadav wrote:

> attribute_group are not supposed to change at runtime. All functions
> working with attribute_group provided by <linux/sysfs.h> work with
> const attribute_group. So mark the non-const structs as const.
> 
> Arvind Yadav (5):
>   [PATCH 1/4] HID: multitouch: constify attribute_group structures.
>   [PATCH 2/4] HID: sensor: constify attribute_group structures.
>   [PATCH 3/4] HID: logitech-hidpp: constify attribute_group structures.
>   [PATCH 4/4] HID: ntrig: constify attribute_group structures.
> 
>  drivers/hid/hid-logitech-hidpp.c |  2 +-
>  drivers/hid/hid-multitouch.c     |  2 +-
>  drivers/hid/hid-ntrig.c          |  2 +-
>  drivers/hid/hid-sensor-custom.c  |  2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

I've applied this to for-4.14/constify-attribute_group branch, but please 
fix your workflow for any furture submissions -- the series wasn't 
properly threaded, only patch 1/4 got threaded to 0/4 mail, others were 
missing References/In-reply-to header completely.

Thanks,

-- 
Jiri Kosina
SUSE Labs
