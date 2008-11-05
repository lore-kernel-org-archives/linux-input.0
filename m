From: Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: cleanup of hiddev
Date: Wed, 05 Nov 2008 13:03:47 +0100
Message-ID: <49118BA3.90004@suse.cz>
References: <200811051252.40133.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200811051252.40133.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Kosina <jikos-wDf7oJUeT2I@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 11/05/2008 12:52 PM, Oliver Neukum wrote:
> @@ -334,35 +354,45 @@ static ssize_t hiddev_read(struct file * file, char __user * buffer, size_t coun
>  					break;
>  				}
>  
> +				/* let O_NONBLOCK tasks run */
> +				mutex_unlock(&list->thread_lock);
>  				schedule();
> +				if (mutex_lock_interruptible(&list->thread_lock))
> +					return -ERESTARTSYS;

This should be EINTR, since the code potentially moved with tail and no rollback
is performed.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
