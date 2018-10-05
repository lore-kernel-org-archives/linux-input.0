From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH] Input: evdev - add a schedule point in evdev_write()
Date: Thu, 4 Oct 2018 21:08:36 -0700
Message-ID: <20181005040836.GU2674@linux.ibm.com>
References: <20181005005359.GA218372@dtor-ws>
Reply-To: paulmck@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181005005359.GA218372@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Oct 04, 2018 at 05:53:59PM -0700, Dmitry Torokhov wrote:
> Large writes to evdev interface may cause rcu stalls. Let's add
> cond_resched() to the loop to avoid this.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Paul E. McKenney <paulmck@linux.ibm.com>

> ---
>  drivers/input/evdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index 370206f987f9..f48369d6f3a0 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -564,6 +564,7 @@ static ssize_t evdev_write(struct file *file, const char __user *buffer,
>  
>  		input_inject_event(&evdev->handle,
>  				   event.type, event.code, event.value);
> +		cond_resched();
>  	}
>  
>   out:
> -- 
> 2.19.0.605.g01d371f741-goog
> 
> 
> -- 
> Dmitry
> 
