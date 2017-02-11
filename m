From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] HID: intel-ish-hid: constify device_type structure
Date: Sat, 11 Feb 2017 01:39:59 -0800
Message-ID: <1486805999.2528.1.camel@linux.intel.com>
References: <1486797037-31415-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:40057 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751009AbdBKJkB (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 11 Feb 2017 04:40:01 -0500
In-Reply-To: <1486797037-31415-1-git-send-email-bhumirks@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>, julia.lawall@lip6.fr, jikos@kernel.org, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 2017-02-11 at 12:40 +0530, Bhumika Goyal wrote:
> Declare device_type structure as const as it is only stored in the
> type field of a device structure. This field is of type const, so add
> const to the declaration of device_type structure.
> 
> File size before: drivers/hid/intel-ish-hid/ishtp/bus.o
>    text	   data	    bss	    dec	    hex	
> filename
>    4260	    336	     16	   4612	   1204
> hid/intel-ish-hid/ishtp/bus.o
> 
> File size after: drivers/hid/intel-ish-hid/ishtp/bus.o
>    text	   data	    bss	    dec	    hex	
> filename
>    4324	    272	     16	   4612	   1204
> hid/intel-ish-hid/ishtp/bus.o
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/hid/intel-ish-hid/ishtp/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c
> b/drivers/hid/intel-ish-hid/ishtp/bus.c
> index f4cbc74..5f382fe 100644
> --- a/drivers/hid/intel-ish-hid/ishtp/bus.c
> +++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
> @@ -358,7 +358,7 @@ static void ishtp_cl_dev_release(struct device
> *dev)
>  	kfree(to_ishtp_cl_device(dev));
>  }
>  
> -static struct device_type ishtp_cl_device_type = {
> +static const struct device_type ishtp_cl_device_type = {
>  	.release	= ishtp_cl_dev_release,
>  };
>  
