From: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: Re: [PATCH 3/3] Blackfin serial driver: this driver enable SPORTs on Blackfin emulate UART
Date: Mon, 15 Oct 2007 18:04:57 -0400
Message-ID: <8bd0f97a0710151504s4faa480due0d54f30a21a7704@mail.gmail.com>
References: <1192098220-25828-1-git-send-email-bryan.wu@analog.com>
	 <1192098220-25828-4-git-send-email-bryan.wu@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764393AbXJOWFc@vger.kernel.org>
In-Reply-To: <1192098220-25828-4-git-send-email-bryan.wu@analog.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Bryan Wu <bryan.wu@analog.com>
Cc: dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz, linux-joystick@atrey.karlin.mff.cuni.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-input@vger.kernel.org

On 10/11/07, Bryan Wu <bryan.wu@analog.com> wrote:
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> +config SERIAL_BFIN_SPORT
> +       tristate "Blackfin SPORT emulate UART (EXPERIMENTAL)"
> +       depends on BFIN && EXPERIMENTAL
> +       select SERIAL_CORE
> +       help
> +         Enble support SPORT emulate UART on Blackfin series.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called bfin_sport_uart.
> +
> +choice
> +       prompt "Baud rate for Blackfin SPORT UART"
> +       depends on SERIAL_BFIN_SPORT
> +       default SERIAL_SPORT_BAUD_RATE_57600
> +       help
> +         Choose a baud rate for the SPORT UART, other uart settings are
> +         8 bit, 1 stop bit, no parity, no flow control.

this looks wrong to me ... why cant the standard infrastructure for
managing baud rate be used ?
-mike
