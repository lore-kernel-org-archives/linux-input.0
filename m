From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch] [media] Input: synaptics-rmi4 - unlock on error
Date: Wed, 16 Nov 2016 17:24:30 -0800
Message-ID: <20161117012430.GD8133@dtor-ws>
References: <20161014171427.GA21917@mwanda>
 <0b9ecb27-505d-71be-35f7-ab262428ec34@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0b9ecb27-505d-71be-35f7-ab262428ec34@cisco.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Hans Verkuil <hansverk@cisco.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Nick Dyer <nick@shmanahar.org>, Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Nov 14, 2016 at 01:24:12PM +0100, Hans Verkuil wrote:
> On 10/14/2016 07:14 PM, Dan Carpenter wrote:
> >We should unlock before returning on this error path.
> >
> >Fixes: 3a762dbd5347 ('[media] Input: synaptics-rmi4 - add support for F54 diagnostics')
> >Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Dmitry, will you pick this up? It probably should to in for 4.9.
> 
> Even though it was prefixed with [media] it wasn't send to linux-media, so it never
> ended up in our patchwork.
> 
> If you don't want to process this patch, then let me know and I'll take it.

I picked it up. Given it is error handling that should not really fail I
think it can wait for next merge.

Thanks.

> 
> Regards,
> 
> 	Hans
> 
> >
> >diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
> >index cf805b9..2e934ae 100644
> >--- a/drivers/input/rmi4/rmi_f54.c
> >+++ b/drivers/input/rmi4/rmi_f54.c
> >@@ -200,7 +200,7 @@ static int rmi_f54_request_report(struct rmi_function *fn, u8 report_type)
> >
> > 	error = rmi_write(rmi_dev, fn->fd.command_base_addr, F54_GET_REPORT);
> > 	if (error < 0)
> >-		return error;
> >+		goto unlock;
> >
> > 	init_completion(&f54->cmd_done);
> >
> >@@ -209,9 +209,10 @@ static int rmi_f54_request_report(struct rmi_function *fn, u8 report_type)
> >
> > 	queue_delayed_work(f54->workqueue, &f54->work, 0);
> >
> >+unlock:
> > 	mutex_unlock(&f54->data_mutex);
> >
> >-	return 0;
> >+	return error;
> > }
> >
> > static size_t rmi_f54_get_report_size(struct f54_data *f54)
> >
> 

-- 
Dmitry
