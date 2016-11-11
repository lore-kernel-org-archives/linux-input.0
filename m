From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] HID: intel_ish-hid: use list_move_tail in
 ishtp_cl_read_start
Date: Fri, 11 Nov 2016 14:51:20 -0800
Message-ID: <1478904680.20074.8.camel@linux.intel.com>
References: <a23f3507ba7bad3d94ca8683d9021f1f565ec6aa.1478858593.git.geliangtang@gmail.com>
         <3bdae868a5ebd999c5610f5b19e6a085c51db059.1478858760.git.geliangtang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:64695 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934727AbcKKWvW (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 11 Nov 2016 17:51:22 -0500
In-Reply-To: <3bdae868a5ebd999c5610f5b19e6a085c51db059.1478858760.git.geliangtang@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Geliang Tang <geliangtang@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2016-11-11 at 20:26 +0800, Geliang Tang wrote:
> Use list_move() instead of list_del() + list_add_tail() to simplify
> the code.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
>  drivers/hid/intel-ish-hid/ishtp/client.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/hid/intel-ish-hid/ishtp/client.c
> b/drivers/hid/intel-ish-hid/ishtp/client.c
> index aad6132..0979e04 100644
> --- a/drivers/hid/intel-ish-hid/ishtp/client.c
> +++ b/drivers/hid/intel-ish-hid/ishtp/client.c
> @@ -497,12 +497,8 @@ int ishtp_cl_read_start(struct ishtp_cl *cl)
>  out:
>  	/* if ishtp_hbm_cl_flow_control_req failed, return rb to
> free list */
>  	if (rets && rb) {
> -		spin_lock_irqsave(&dev->read_list_spinlock,
> dev_flags);
> -		list_del(&rb->list);
> -		spin_unlock_irqrestore(&dev->read_list_spinlock,
> dev_flags);
> -
>  		spin_lock_irqsave(&cl->free_list_spinlock, flags);
> -		list_add_tail(&rb->list, &cl->free_rb_list.list);
> +		list_move_tail(&rb->list, &cl->free_rb_list.list);
Logically the result is not same. They were protected under two
spinlocks, now they are not.

Thanks,
Srinivas

>  		spin_unlock_irqrestore(&cl->free_list_spinlock,
> flags);
>  	}
>  	return rets;
