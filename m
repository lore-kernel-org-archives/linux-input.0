From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: intel-ish-hid: constify device_type structure
Date: Tue, 14 Feb 2017 15:33:32 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1702141533040.24579@cbobk.fhfr.pm>
References: <1486797037-31415-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43460 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753236AbdBNOdf (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 14 Feb 2017 09:33:35 -0500
In-Reply-To: <1486797037-31415-1-git-send-email-bhumirks@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, srinivas.pandruvada@linux.intel.com, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 11 Feb 2017, Bhumika Goyal wrote:

> Declare device_type structure as const as it is only stored in the
> type field of a device structure. This field is of type const, so add
> const to the declaration of device_type structure.
> 
> File size before: drivers/hid/intel-ish-hid/ishtp/bus.o
>    text	   data	    bss	    dec	    hex	filename
>    4260	    336	     16	   4612	   1204 hid/intel-ish-hid/ishtp/bus.o
> 
> File size after: drivers/hid/intel-ish-hid/ishtp/bus.o
>    text	   data	    bss	    dec	    hex	filename
>    4324	    272	     16	   4612	   1204 hid/intel-ish-hid/ishtp/bus.o
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
>  drivers/hid/intel-ish-hid/ishtp/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c b/drivers/hid/intel-ish-hid/ishtp/bus.c
> index f4cbc74..5f382fe 100644
> --- a/drivers/hid/intel-ish-hid/ishtp/bus.c
> +++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
> @@ -358,7 +358,7 @@ static void ishtp_cl_dev_release(struct device *dev)
>  	kfree(to_ishtp_cl_device(dev));
>  }
>  
> -static struct device_type ishtp_cl_device_type = {
> +static const struct device_type ishtp_cl_device_type = {
>  	.release	= ishtp_cl_dev_release,
>  };

Applied to hid.git#for-4.11/intel-ish, thanks.

-- 
Jiri Kosina
SUSE Labs

