From: Nick Dyer <nick@shmanahar.org>
Subject: Re: [PATCH -next] [media] Input: fix missing unlock on error in
 rmi_f54_request_report()
Date: Thu, 15 Sep 2016 21:24:01 +0100
Message-ID: <20160915202401.GC18925@lava.h.shmanahar.org>
References: <1473776690-3748-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avasout06.plus.net ([212.159.14.18]:50849 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754512AbcIOUYH (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 15 Sep 2016 16:24:07 -0400
Content-Disposition: inline
In-Reply-To: <1473776690-3748-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hans.verkuil@cisco.com>, Wei Yongjun <weiyongjun1@huawei.com>, linux-input@vger.kernel.org

On Tue, Sep 13, 2016 at 02:24:50PM +0000, Wei Yongjun wrote:
> Add the missing unlock before return from function
> rmi_f54_request_report() in the error handling case.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Nick Dyer <nick@shmanahar.org>

> ---
>  drivers/input/rmi4/rmi_f54.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
> index bd86d3d..99a8836 100644
> --- a/drivers/input/rmi4/rmi_f54.c
> +++ b/drivers/input/rmi4/rmi_f54.c
> @@ -198,8 +198,10 @@ static int rmi_f54_request_report(struct rmi_function *fn, u8 report_type)
>  	mutex_lock(&f54->data_mutex);
>  
>  	error = rmi_write(rmi_dev, fn->fd.command_base_addr, F54_GET_REPORT);
> -	if (error < 0)
> +	if (error < 0) {
> +		mutex_unlock(&f54->data_mutex);
>  		return error;
> +	}
>  
>  	init_completion(&f54->cmd_done);
> 
