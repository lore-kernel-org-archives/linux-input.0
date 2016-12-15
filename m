From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] HID: intel-ish-hid: Remove unneeded linux/miscdevice.h
 include
Date: Thu, 15 Dec 2016 08:20:38 -0800
Message-ID: <1481818838.1934.2.camel@linux.intel.com>
References: <20161215152711.9069-1-clabbe.montjoie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:1703 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936000AbcLOQUr (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 15 Dec 2016 11:20:47 -0500
In-Reply-To: <20161215152711.9069-1-clabbe.montjoie@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Corentin Labbe <clabbe.montjoie@gmail.com>, jikos@kernel.org, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

On Thu, 2016-12-15 at 16:27 +0100, Corentin Labbe wrote:
> hid/intel-ish-hid does not use any miscdevice so this patch remove
> this unnecessary inclusion.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/hid/intel-ish-hid/ipc/pci-ish.c | 1 -
>  drivers/hid/intel-ish-hid/ishtp/hbm.c   | 1 -
>  drivers/hid/intel-ish-hid/ishtp/init.c  | 1 -
>  3 files changed, 3 deletions(-)
> 
> diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> index 20d647d..d20da39 100644
> --- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> +++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> @@ -24,7 +24,6 @@
>  #include <linux/sched.h>
>  #include <linux/interrupt.h>
>  #include <linux/workqueue.h>
> -#include <linux/miscdevice.h>
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/intel_ish.h>
>  #include "ishtp-dev.h"
> diff --git a/drivers/hid/intel-ish-hid/ishtp/hbm.c
> b/drivers/hid/intel-ish-hid/ishtp/hbm.c
> index 59460b6..b721360 100644
> --- a/drivers/hid/intel-ish-hid/ishtp/hbm.c
> +++ b/drivers/hid/intel-ish-hid/ishtp/hbm.c
> @@ -19,7 +19,6 @@
>  #include <linux/sched.h>
>  #include <linux/wait.h>
>  #include <linux/spinlock.h>
> -#include <linux/miscdevice.h>
>  #include "ishtp-dev.h"
>  #include "hbm.h"
>  #include "client.h"
> diff --git a/drivers/hid/intel-ish-hid/ishtp/init.c
> b/drivers/hid/intel-ish-hid/ishtp/init.c
> index ac36441..d27e035 100644
> --- a/drivers/hid/intel-ish-hid/ishtp/init.c
> +++ b/drivers/hid/intel-ish-hid/ishtp/init.c
> @@ -16,7 +16,6 @@
>  #include <linux/export.h>
>  #include <linux/slab.h>
>  #include <linux/sched.h>
> -#include <linux/miscdevice.h>
>  #include "ishtp-dev.h"
>  #include "hbm.h"
>  #include "client.h"
