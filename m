From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: ads7846: Switch to managed version of kzalloc and
 cleanups
Date: Mon, 28 Jul 2014 09:49:35 -0700
Message-ID: <20140728164935.GA8982@core.coreip.homeip.net>
References: <1406537216-25936-1-git-send-email-pramod.gurav@smartplayin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1406537216-25936-1-git-send-email-pramod.gurav@smartplayin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: pramod.gurav.etc@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Pramod Gurav <pramod.gurav@smartplayin.com>, Guenter Roeck <linux@roeck-us.net>, Paul Gortmaker <paul.gortmaker@windriver.com>, Mark Brown <broonie@linaro.org>, Fabio Estevam <fabio.estevam@freescale.com>
List-Id: linux-input@vger.kernel.org

Hi Pramod,

On Mon, Jul 28, 2014 at 02:16:55PM +0530, pramod.gurav.etc@gmail.com wrote:
> From: Pramod Gurav <pramod.gurav@smartplayin.com>
> 
> This switches memory allocations from kzalloc to devm_kzalloc.
> This also changes the way return checks were done on failure cases
> of three allocations. The checks were clubbed together and hence
> must be done seperately to avoid calling kfree on unallocated memory.
> 
> Moreover in case of input_allocate_device failure, we were calling
> input_free_device which is not needed.

But not hurting either - like kfree() and many other "cleanup" functions
in kernel they are happily accept NULL input (so that cleanup code is
less branchy).
> 
> input device must be released(input_free_device) when ads7846_probe_dt
> fails hence adds a fix there as well.

That is the real bug, could you send me a patch that fixes just that (by
jumping to err_free_mem)?

The rest I'd like to leave as is unless you can convert _all_ resources
to be managed ones: mixing up 2 styles (manual and automatic release) is
bound to have issues (like we had with ads7846_probe_dt which assumed
that since it was releasing its resources automatically the rest would
be released automatically as well.

Thanks.

-- 
Dmitry
