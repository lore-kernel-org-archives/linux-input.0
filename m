From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: synaptics_i2c - remove redundant spinlock
Date: Sat, 16 Feb 2019 21:29:59 -0800
Message-ID: <20190217052959.GB107793@dtor-ws>
References: <20190212013442.26030-1-TheSven73@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190212013442.26030-1-TheSven73@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thesven73@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Sven,

On Mon, Feb 11, 2019 at 08:34:42PM -0500, thesven73@gmail.com wrote:
> @@ -372,13 +371,7 @@ static bool synaptics_i2c_get_input(struct synaptics_i2c *touch)
>  static void synaptics_i2c_reschedule_work(struct synaptics_i2c *touch,
>  					  unsigned long delay)
>  {
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&touch->lock, flags);
> -
>  	mod_delayed_work(system_wq, &touch->dwork, delay);
> -
> -	spin_unlock_irqrestore(&touch->lock, flags);
>  }

This makes synaptics_i2c_reschedule_work() a useless wrapper for
mod_delayed_work(). Can we get rid of it?

Thanks.

-- 
Dmitry
