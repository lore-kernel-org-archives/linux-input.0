From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] input: evdev: use multi-reader buffer to save space
Date: Fri, 28 May 2010 11:10:47 -0700
Message-ID: <20100528181047.GB2905@core.coreip.homeip.net>
References: <1275059434-2110-1-git-send-email-rydberg@euromail.se>
 <1275059434-2110-2-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:36415 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602Ab0E1SK4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 May 2010 14:10:56 -0400
Received: by pvg11 with SMTP id 11so517231pvg.19
        for <linux-input@vger.kernel.org>; Fri, 28 May 2010 11:10:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1275059434-2110-2-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Mika Kuoppala <mika.kuoppala@nokia.com>, Benjamin Tissoires <tissoire@cena.fr>, Rafi Rubin <rafi@seas.upenn.edu>

Hi Henrik,

On Fri, May 28, 2010 at 05:10:32PM +0200, Henrik Rydberg wrote:
> In preparation of larger buffer needs, convert the current per-client
> circular buffer to a single buffer with multiple clients. Since there
> is only one writer but potentially many readers, use the somewhat
> discouraged rwlock_t pattern.

rwlock is completely unsuitable here:

1. You must absiolutely not starve writers since they are quite likely
are interrupt handlers. If anything they should get priority.

2. The amount of time the thing is locked is very miniscule, I'd say
that regular spinlocks will still give better performance.

Also, use of atomic is funky, I do not think it does whta you think it
would... Could you explain more why you are using it?

Thanks.

> 
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
>  drivers/input/evdev.c |   60 +++++++++++++++++++++++++-----------------------
>  1 files changed, 31 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index 2ee6c7a..8edea95 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -33,13 +33,14 @@ struct evdev {
>  	spinlock_t client_lock; /* protects client_list */
>  	struct mutex mutex;
>  	struct device dev;
> +	int head;
> +	struct input_event buffer[EVDEV_BUFFER_SIZE];
> +	rwlock_t buffer_lock; /* protects access to buffer only */
>  };
>  
>  struct evdev_client {
> -	struct input_event buffer[EVDEV_BUFFER_SIZE];
> -	int head;
> +	atomic_t head;
>  	int tail;
> -	spinlock_t buffer_lock; /* protects access to buffer, head and tail */
>  	struct fasync_struct *fasync;
>  	struct evdev *evdev;
>  	struct list_head node;
> @@ -48,18 +49,11 @@ struct evdev_client {
>  static struct evdev *evdev_table[EVDEV_MINORS];
>  static DEFINE_MUTEX(evdev_table_mutex);
>  
> -static void evdev_pass_event(struct evdev_client *client,
> -			     struct input_event *event)
> +static inline void evdev_sync_event(struct evdev_client *client,
> +				    int head, int type)
>  {
> -	/*
> -	 * Interrupts are disabled, just acquire the lock
> -	 */
> -	spin_lock(&client->buffer_lock);
> -	client->buffer[client->head++] = *event;
> -	client->head &= EVDEV_BUFFER_SIZE - 1;
> -	spin_unlock(&client->buffer_lock);
> -
> -	if (event->type == EV_SYN)
> +	atomic_set(&client->head, head);
> +	if (type == EV_SYN)
>  		kill_fasync(&client->fasync, SIGIO, POLL_IN);
>  }
>  
> @@ -78,14 +72,22 @@ static void evdev_event(struct input_handle *handle,
>  	event.code = code;
>  	event.value = value;
>  
> +	/* Interrupts are disabled */
> +	write_lock(&evdev->buffer_lock);
> +	evdev->buffer[evdev->head] = event;
> +	write_unlock(&evdev->buffer_lock);
> +
> +	evdev->head++;
> +	evdev->head &= EVDEV_BUFFER_SIZE - 1;
> +
>  	rcu_read_lock();
>  
>  	client = rcu_dereference(evdev->grab);
>  	if (client)
> -		evdev_pass_event(client, &event);
> +		evdev_sync_event(client, evdev->head, type);
>  	else
>  		list_for_each_entry_rcu(client, &evdev->client_list, node)
> -			evdev_pass_event(client, &event);
> +			evdev_sync_event(client, evdev->head, type);
>  
>  	rcu_read_unlock();
>  
> @@ -269,7 +271,6 @@ static int evdev_open(struct inode *inode, struct file *file)
>  		goto err_put_evdev;
>  	}
>  
> -	spin_lock_init(&client->buffer_lock);
>  	client->evdev = evdev;
>  	evdev_attach_client(evdev, client);
>  
> @@ -324,21 +325,20 @@ static ssize_t evdev_write(struct file *file, const char __user *buffer,
>  	return retval;
>  }
>  
> -static int evdev_fetch_next_event(struct evdev_client *client,
> +static int evdev_fetch_next_event(struct evdev *evdev,
> +				  struct evdev_client *client,
>  				  struct input_event *event)
>  {
> -	int have_event;
> +	int have_event = atomic_read(&client->head) != client->tail;
>  
> -	spin_lock_irq(&client->buffer_lock);
> -
> -	have_event = client->head != client->tail;
>  	if (have_event) {
> -		*event = client->buffer[client->tail++];
> +		read_lock_irq(&evdev->buffer_lock);
> +		*event = evdev->buffer[client->tail];
> +		read_unlock_irq(&evdev->buffer_lock);
> +		client->tail++;
>  		client->tail &= EVDEV_BUFFER_SIZE - 1;
>  	}
>  
> -	spin_unlock_irq(&client->buffer_lock);
> -
>  	return have_event;
>  }
>  
> @@ -353,12 +353,12 @@ static ssize_t evdev_read(struct file *file, char __user *buffer,
>  	if (count < input_event_size())
>  		return -EINVAL;
>  
> -	if (client->head == client->tail && evdev->exist &&
> +	if (atomic_read(&client->head) == client->tail && evdev->exist &&
>  	    (file->f_flags & O_NONBLOCK))
>  		return -EAGAIN;
>  
>  	retval = wait_event_interruptible(evdev->wait,
> -		client->head != client->tail || !evdev->exist);
> +		atomic_read(&client->head) != client->tail || !evdev->exist);
>  	if (retval)
>  		return retval;
>  
> @@ -366,7 +366,7 @@ static ssize_t evdev_read(struct file *file, char __user *buffer,
>  		return -ENODEV;
>  
>  	while (retval + input_event_size() <= count &&
> -	       evdev_fetch_next_event(client, &event)) {
> +	       evdev_fetch_next_event(evdev, client, &event)) {
>  
>  		if (input_event_to_user(buffer + retval, &event))
>  			return -EFAULT;
> @@ -384,7 +384,8 @@ static unsigned int evdev_poll(struct file *file, poll_table *wait)
>  	struct evdev *evdev = client->evdev;
>  
>  	poll_wait(file, &evdev->wait, wait);
> -	return ((client->head == client->tail) ? 0 : (POLLIN | POLLRDNORM)) |
> +	return ((atomic_read(&client->head) == client->tail) ?
> +		0 : (POLLIN | POLLRDNORM)) |
>  		(evdev->exist ? 0 : (POLLHUP | POLLERR));
>  }
>  
> @@ -815,6 +816,7 @@ static int evdev_connect(struct input_handler *handler, struct input_dev *dev,
>  	spin_lock_init(&evdev->client_lock);
>  	mutex_init(&evdev->mutex);
>  	init_waitqueue_head(&evdev->wait);
> +	rwlock_init(&evdev->buffer_lock);
>  
>  	dev_set_name(&evdev->dev, "event%d", minor);
>  	evdev->exist = 1;

-- 
Dmitry
