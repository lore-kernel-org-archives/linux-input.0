From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Input: serio - do not mark kseriod freezable anymore
Date: Mon, 21 Dec 2009 21:23:52 +0100
Message-ID: <200912212123.52349.rjw@sisk.pl>
References: <20091221073338.GA3234@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:42862 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752793AbZLUUXW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Dec 2009 15:23:22 -0500
In-Reply-To: <20091221073338.GA3234@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>

On Monday 21 December 2009, Dmitry Torokhov wrote:
> We used to make kseriod freezable to prevent unnecessary attempts at
> resuming keyboard and mouse before taking hibernation image when suspend
> and hibernation were sharing PM operations. Now that they are separated
> and we don't risk resuming during 'thaw' we don't need to freeze kseriod
> anymore. This will allow us to start resetting mouse and keyboard a bit
> earlier, before rest of the userspace comes back up.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

> ---
> 
>  drivers/input/serio/serio.c |   11 ++---------
>  1 files changed, 2 insertions(+), 9 deletions(-)
> 
> 
> diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
> index 0236f0d..e0f3018 100644
> --- a/drivers/input/serio/serio.c
> +++ b/drivers/input/serio/serio.c
> @@ -284,13 +284,7 @@ static void serio_handle_event(void)
>  
>  	mutex_lock(&serio_mutex);
>  
> -	/*
> -	 * Note that we handle only one event here to give swsusp
> -	 * a chance to freeze kseriod thread. Serio events should
> -	 * be pretty rare so we are not concerned about taking
> -	 * performance hit.
> -	 */
> -	if ((event = serio_get_event())) {
> +	while ((event = serio_get_event())) {
>  
>  		switch (event->type) {
>  			case SERIO_REGISTER_PORT:
> @@ -380,10 +374,9 @@ static struct serio *serio_get_pending_child(struct serio *parent)
>  
>  static int serio_thread(void *nothing)
>  {
> -	set_freezable();
>  	do {
>  		serio_handle_event();
> -		wait_event_freezable(serio_wait,
> +		wait_event_interruptible(serio_wait,
>  			kthread_should_stop() || !list_empty(&serio_event_list));
>  	} while (!kthread_should_stop());
>  
> 
> 

