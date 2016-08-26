From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH -next] HID: intel-ish-hid: use list_move_tail instead of
 list_del/list_add_tail
Date: Fri, 26 Aug 2016 12:04:48 -0700
Message-ID: <1472238288.2694.5.camel@linux.intel.com>
References: <1471793249-23714-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:60301 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750715AbcHZTFe (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 26 Aug 2016 15:05:34 -0400
In-Reply-To: <1471793249-23714-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-input@vger.kernel.org

On Sun, 2016-08-21 at 15:27 +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Using list_move_tail() instead of list_del() + list_add_tail().
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/hid/intel-ish-hid/ipc/ipc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/intel-ish-hid/ipc/ipc.c b/drivers/hid/intel-
> ish-hid/ipc/ipc.c
> index 851029b..e2517c1 100644
> --- a/drivers/hid/intel-ish-hid/ipc/ipc.c
> +++ b/drivers/hid/intel-ish-hid/ipc/ipc.c
> @@ -448,8 +448,7 @@ static int ish_fw_reset_handler(struct
> ishtp_device *dev)
>  	spin_lock_irqsave(&dev->wr_processing_spinlock, flags);
>  	list_for_each_entry_safe(processing, next,
>  			&dev->wr_processing_list_head.link, link) {
> -		list_del(&processing->link);
> -		list_add_tail(&processing->link, &dev-
> >wr_free_list_head.link);
> +		list_move_tail(&processing->link, &dev-
> >wr_free_list_head.link);
>  	}
>  	spin_unlock_irqrestore(&dev->wr_processing_spinlock, flags);
>  
> 
> 
> 
