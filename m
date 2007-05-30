From: Hans-Christian Egtvedt <hcegtvedt@norway.atmel.com>
Subject: Re: [PATCH 1/1] gpio_mouse driver
Date: Wed, 30 May 2007 10:00:33 +0200
Message-ID: <1180512033.32245.63.camel@localhost.localdomain>
References: <1180444046354-git-send-email-hcegtvedt@norway.atmel.com>
	 <d120d5000705290836o49bc207bqb3d9dfebc34ac752@mail.gmail.com>
	 <1180506198.32245.59.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1180506198.32245.59.camel@localhost.localdomain>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Wed, 2007-05-30 at 08:23 +0200, Hans-Christian Egtvedt wrote:
> On Tue, 2007-05-29 at 11:36 -0400, Dmitry Torokhov wrote:

<cut other fixes and comments>

> > I don't think it is a good idea to have timer structure in platform
> > data which should really be constant. Timer shoudl be part of the
> > stucture created when driver binds to a device. I can see you may not
> > want to introduce extra complexity in the driver; however if you use
> > input-polldev it will handle timer for you.
> 
> I was a bit unsure about this before submitting. I have moved the
> timer_list into a struct in the driver and added the usual
> kmalloc/kfree.

Oops, this introduced a bug when calling add_timer, since kmalloc does
not zero the memory.

The fix is:

> +	input->open = gpio_mouse_open;
> +	input->close = gpio_mouse_close;
> +
> +	gmouse->gpio = pdata;
> +	gmouse->input = input;
> +
> +	/* Init the scan timer. TODO: rewrite to use input-polldev in the future */

Add a timer_init(&gmouse->timer); here.

> +	gmouse->timer.function = gpio_mouse_scan;
> +	gmouse->timer.base = &boot_tvec_bases;

Remove this line ^^^

> +
> +	ret = input_register_device(input);

-- 
Mvh
Hans-Christian Egtvedt
