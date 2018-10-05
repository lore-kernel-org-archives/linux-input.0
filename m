From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH] Input: uinput - add a schedule point in
 uinput_inject_events()
Date: Thu, 4 Oct 2018 21:09:00 -0700
Message-ID: <20181005040900.GV2674@linux.ibm.com>
References: <20181005005432.GA218507@dtor-ws>
Reply-To: paulmck@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181005005432.GA218507@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Oct 04, 2018 at 05:54:32PM -0700, Dmitry Torokhov wrote:
> Large writes to uinput interface may cause rcu stalls. Let's add
> cond_resched() to the loop to avoid this.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Paul E. McKenney <paulmck@linux.ibm.com>

> ---
>  drivers/input/misc/uinput.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
> index eb14ddf69346..8ec483e8688b 100644
> --- a/drivers/input/misc/uinput.c
> +++ b/drivers/input/misc/uinput.c
> @@ -598,6 +598,7 @@ static ssize_t uinput_inject_events(struct uinput_device *udev,
>  
>  		input_event(udev->dev, ev.type, ev.code, ev.value);
>  		bytes += input_event_size();
> +		cond_resched();
>  	}
>  
>  	return bytes;
> -- 
> 2.19.0.605.g01d371f741-goog
> 
> 
> -- 
> Dmitry
> 
