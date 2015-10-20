From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 7/9] input: keyboard: fix a trivial typo
Date: Tue, 20 Oct 2015 09:41:09 -0700
Message-ID: <20151020164109.GA5061@dtor-ws>
References: <949f6f3c99f87b57666986dc9f2d1c916935e215.1445181079.git.geliangtang@163.com>
 <557286dd38beb4d8d1be28e787ad89611e7cc077.1445181079.git.geliangtang@163.com>
 <5fea4cd474d5fe49688f88d91cdf5e8019844806.1445181079.git.geliangtang@163.com>
 <918fdb002ec3b2a9fc5a5d364c0fbaff2f77c5cc.1445181079.git.geliangtang@163.com>
 <eb89ced1dda5b521dba1ed6095deef09d577e37a.1445181079.git.geliangtang@163.com>
 <88b679770e91ce8e3aa2cd25912c6d589563388c.1445181079.git.geliangtang@163.com>
 <305aab717640ce43bfd609be20f2fff24190f207.1445181079.git.geliangtang@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <305aab717640ce43bfd609be20f2fff24190f207.1445181079.git.geliangtang@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geliang Tang <geliangtang@163.com>
Cc: Jiri Kosina <trivial@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, Oct 18, 2015 at 11:31:13PM +0800, Geliang Tang wrote:
> s/regsiter/register/
> 
> Signed-off-by: Geliang Tang <geliangtang@163.com>

Applied, thank you.

> ---
>  drivers/input/keyboard/nomadik-ske-keypad.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/nomadik-ske-keypad.c b/drivers/input/keyboard/nomadik-ske-keypad.c
> index c7d5b16..8567ee4 100644
> --- a/drivers/input/keyboard/nomadik-ske-keypad.c
> +++ b/drivers/input/keyboard/nomadik-ske-keypad.c
> @@ -54,7 +54,7 @@
>  /**
>   * struct ske_keypad  - data structure used by keypad driver
>   * @irq:	irq no
> - * @reg_base:	ske regsiters base address
> + * @reg_base:	ske registers base address
>   * @input:	pointer to input device object
>   * @board:	keypad platform device
>   * @keymap:	matrix scan code table for keycodes
> -- 
> 2.5.0
> 
> 

-- 
Dmitry
