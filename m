From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v4] input: pxrc: new driver for PhoenixRC Flight
 Controller Adapter
Date: Wed, 17 Jan 2018 11:13:43 -0800
Message-ID: <9607d51a-4382-396c-a4bd-46bbb24ba46e@infradead.org>
References: <20180117190716.22380-1-marcus.folkesson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20180117190716.22380-1-marcus.folkesson@gmail.com>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Marcus Folkesson <marcus.folkesson@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Tomohiro Yoshidomi <sylph23k@gmail.com>, David Herrmann <dh.herrmann@gmail.com>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-input@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 01/17/2018 11:07 AM, Marcus Folkesson wrote:
> This driver let you plug in your RC controller to the adapter and
> use it as input device in various RC simulators.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---

> diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
> index f3c2f6ea8b44..18ab6dafff41 100644
> --- a/drivers/input/joystick/Kconfig
> +++ b/drivers/input/joystick/Kconfig
> @@ -351,4 +351,13 @@ config JOYSTICK_PSXPAD_SPI_FF
>  
>  	  To drive rumble motor a dedicated power supply is required.
>  
> +config JOYSTICK_PXRC
> +	tristate "PhoenixRC Flight Controller Adapter"
> +	depends on USB_ARCH_HAS_HCD
> +	select USB

Drop the (first) depends and change "select USB" to "depends on USB".

Argh, there are lots of input/ drivers that do that.  That's bad/wrong.
A driver should not select (enable) an entire subsystem.  If the user had
the subsystem disabled, it should stay that way.

Dmitry, you can expect some patches...

> +	help
> +	  Say Y here if you want to use the PhoenixRC Flight Controller Adapter.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called pxrc.
>  endif

-- 
~Randy
