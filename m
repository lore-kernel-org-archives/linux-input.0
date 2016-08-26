From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH -next] HID: intel_ish-hid: Remove duplicated include
 from bus.c
Date: Fri, 26 Aug 2016 11:39:35 -0700
Message-ID: <1472236775.9054.0.camel@linux.intel.com>
References: <1471793495-24402-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:3949 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752118AbcHZSoZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 26 Aug 2016 14:44:25 -0400
In-Reply-To: <1471793495-24402-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org

On Sun, 2016-08-21 at 15:31 +0000, Wei Yongjun wrote:
> Remove duplicated include.
> 
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/hid/intel-ish-hid/ishtp/bus.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c
> b/drivers/hid/intel-ish-hid/ishtp/bus.c
> index 0183eac..c0b4583 100644
> --- a/drivers/hid/intel-ish-hid/ishtp/bus.c
> +++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
> @@ -16,7 +16,6 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> -#include <linux/kernel.h>
>  #include <linux/device.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
> 
> 
> 
