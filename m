From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] gpio_mouse driver
Date: Tue, 29 May 2007 11:36:38 -0400
Message-ID: <d120d5000705290836o49bc207bqb3d9dfebc34ac752@mail.gmail.com>
References: <1180444046354-git-send-email-hcegtvedt@norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1180444046354-git-send-email-hcegtvedt@norway.atmel.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Hans-Christian Egtvedt <hcegtvedt@norway.atmel.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, Hans-Christian Egtvedt <hcegtvedt@atmel.com>
List-Id: linux-input@vger.kernel.org

Hi,

On 5/29/07, Hans-Christian Egtvedt <hcegtvedt@norway.atmel.com> wrote:
> This patch adds support for simulating a mouse using GPIO lines.
>
> The driver needs a platform_data struct to be defined and registered with the
> appropriate platform_device.
>
> The driver has been tested on AT32AP7000 microprocessor using the ATSTK1000
> development board.
>

It looks sane although I would recommend switching to input-polldev
when implementing a polled input device.

> +
> +       input->name = pdev->name;
> +       input->cdev.dev = &pdev->dev;

Please use input->dev.parent = &pdev->dev. Input devices are being
moved from class_device to struct device.

> +       input->private = pdata;
> +
> +       /*
> +        * Revisit: is bustype, vendor, product and version needed to
> +        * input->id? And if they should be present, what values should they
> +        * have?
> +        */

BUS_HOST seems to be most suitable here. The rest may stay 0.

> +
> +       /* private */
> +       struct timer_list timer;
> +};

I don't think it is a good idea to have timer structure in platform
data which should really be constant. Timer shoudl be part of the
stucture created when driver binds to a device. I can see you may not
want to introduce extra complexity in the driver; however if you use
input-polldev it will handle timer for you.

-- 
Dmitry
