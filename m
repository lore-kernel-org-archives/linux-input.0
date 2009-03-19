From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Question about usage of RCU in the input layer
Date: Thu, 19 Mar 2009 00:23:56 -0700
Message-ID: <200903190023.56929.dmitry.torokhov@gmail.com>
References: <20090318215812.15496a86@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:45898 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232AbZCSHYD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Mar 2009 03:24:03 -0400
In-Reply-To: <20090318215812.15496a86@infradead.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-input@vger.kernel.org, dipankar@in.ibm.com, linux-kernel@vger.kernel.org

Hi Arjan,

On Wednesday 18 March 2009 21:58:12 Arjan van de Ven wrote:
> Hi,
>
> the input layer does a "synchronize_rcu()" after a list_add_tail_rcu(),
> which is costing me 1 second of boot time.....
> And based on my understanding of the RCU concept, you only need to
> synchronize on delete, not on addition... so I think the synchronize is
> entirely redundant here...


It is there to guarantee that once we registered the handle all
subsequent input events will be delivered through it.
 
>
> Can I have my second of boot time back please ?
>

Not like this I'm afraid but I will see what I can do.

>
>
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index 1730d73..d69ec56 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -1544,7 +1544,6 @@ int input_register_handle(struct input_handle
> *handle) return error;
>  	list_add_tail_rcu(&handle->d_node, &dev->h_list);
>  	mutex_unlock(&dev->mutex);
> -	synchronize_rcu();
>
>  	/*
>  	 * Since we are supposed to be called from ->connect()

-- 
Dmitry
