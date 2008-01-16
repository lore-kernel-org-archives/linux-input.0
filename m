From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH] I8042: SNI RM support
Date: Wed, 16 Jan 2008 00:22:42 -0500
Message-ID: <200801160022.43487.dtor@insightbb.com>
References: <20080112233904.4E149C2F36@solo.franken.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20080112233904.4E149C2F36@solo.franken.de>
Content-Disposition: inline
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-input@vger.kernel.org, linux-mips@linux-mips.org
List-Id: linux-input@vger.kernel.org

Hi Thomas,

On Saturday 12 January 2008 18:39, Thomas Bogendoerfer wrote:
> +
> +/*
> + * IRQs.
> + */
> +static int i8042_kbd_irq = -1;
> +static int i8042_aux_irq = -1;

Why initialize with -1 and not leave at 0? Or even initialize with 1/12
and override with 33/44 in i8042_platform_init()?

-- 
Dmitry
