From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 01/03] sh: SuperH KEYSC platform driver
Date: Fri, 29 Feb 2008 13:57:51 -0800
Message-ID: <20080229135751.c94862be.akpm@linux-foundation.org>
References: <20080229104847.22537.66432.sendpatchset@clockwork.opensource.se>
	<20080229104856.22537.77214.sendpatchset@clockwork.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20080229104856.22537.77214.sendpatchset@clockwork.opensource.se>
Sender: linux-sh-owner@vger.kernel.org
Cc: linux-input@vger.kernel.org, magnus.damm@gmail.com, lethal@linux-sh.org, linux-sh@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 29 Feb 2008 19:48:56 +0900
Magnus Damm <magnus.damm@gmail.com> wrote:

> This patch adds a platform driver for the SuperH KEYSC block. The driver
> expects to get mode, timing information and keypad layout from the board
> code as platform data. The board code is resonsible for pin configuration.
> 
> Both sh7343 and sh7722 should be supported, but only the sh7722 processor
> has been tested so far. SH_KEYSC_MODE_3 is yet to be tested.
> 
> ...
>
> +#define res_size(res) ((res)->end - (res)->start + 1)

- buggy macro references its argument more than once
- could be implemented in C
- perhaps should be implemented in <linux/ioport.h>

> +	input->phys = "sh-keysc-keys/input0";

Is the "/" in here safe?  I trust we don't try to create a
sysfs/procfs/whatever file based off this string.
