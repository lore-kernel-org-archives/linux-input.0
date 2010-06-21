From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/2] drivers/hid: Eliminate a double lock
Date: Mon, 21 Jun 2010 12:03:11 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1006211202550.13809@pobox.suse.cz>
References: <Pine.LNX.4.64.1006201324170.4366@ask.diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55747 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932101Ab0FUKDM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jun 2010 06:03:12 -0400
In-Reply-To: <Pine.LNX.4.64.1006201324170.4366@ask.diku.dk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Julia Lawall <julia@diku.dk>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Sun, 20 Jun 2010, Julia Lawall wrote:

> From: Julia Lawall <julia@diku.dk>
> 
> The path around the loop ends with the lock held, so the call to mutex_lock
> is moved before the beginning of the loop.
> 
> A simplified version of the semantic match that finds this problem is as
> follows: (http://coccinelle.lip6.fr/)
[ ... ]
> diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
> index c940267..850d02a 100644
> --- a/drivers/hid/hid-debug.c
> +++ b/drivers/hid/hid-debug.c
> @@ -949,8 +949,8 @@ static ssize_t hid_debug_events_read(struct file *file, char __user *buffer,
>  	int ret = 0, len;
>  	DECLARE_WAITQUEUE(wait, current);
>  
> +	mutex_lock(&list->read_mutex);
>  	while (ret == 0) {
> -		mutex_lock(&list->read_mutex);
>  		if (list->head == list->tail) {
>  			add_wait_queue(&list->hdev->debug_wait, &wait);
>  			set_current_state(TASK_INTERRUPTIBLE);

Applied, thanks Julia.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
