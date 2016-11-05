From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] HID: intel-ish-hid: initialize ts_format.reserved
Date: Sat, 05 Nov 2016 10:05:19 -0700
Message-ID: <1478365519.3242.10.camel@linux.intel.com>
References: <alpine.LNX.2.00.1611051613470.29400@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:48122 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753211AbcKERFW (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 5 Nov 2016 13:05:22 -0400
In-Reply-To: <alpine.LNX.2.00.1611051613470.29400@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Sat, 2016-11-05 at 16:15 +0100, Jiri Kosina wrote:
> From: Jiri Kosina <jkosina@suse.cz>
> 
> ts_format.reserved is not used anywhere yet, but the compiler
> generates a 
> warning when the struct's (uninitialized) field is being copied
> around
> 
> drivers/hid/intel-ish-hid/ipc/ipc.c: In function
> ‘write_ipc_from_queue’:
> drivers/hid/intel-ish-hid/ipc/ipc.c:316: warning:
> ‘ts_format.reserved’ may be used uninitialized in this function
> 
> Avoid this by force-initializing the field to zero.
> 
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/hid/intel-ish-hid/ipc/ipc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/intel-ish-hid/ipc/ipc.c b/drivers/hid/intel-
> ish-hid/ipc/ipc.c
> index 0c9ac4d..417cd07 100644
> --- a/drivers/hid/intel-ish-hid/ipc/ipc.c
> +++ b/drivers/hid/intel-ish-hid/ipc/ipc.c
> @@ -310,6 +310,7 @@ static int write_ipc_from_queue(struct
> ishtp_device *dev)
>                                                 ((uint32_t)tv_utc.tv_
> usec);
>                 ts_format.ts1_source = HOST_SYSTEM_TIME_USEC;
>                 ts_format.ts2_source = HOST_UTC_TIME_USEC;
> +               ts_format.reserved = 0;
>  
>                 time_update.primary_host_time = usec_system;
>                 time_update.secondary_host_time = usec_utc;
> -- 
> 1.9.2
> 
