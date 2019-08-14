From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v6 21/57] Input: Remove dev_err() usage after
 platform_get_irq()
Date: Wed, 14 Aug 2019 10:48:09 -0700
Message-ID: <20190814174809.GB121898@dtor-ws>
References: <20190730181557.90391-1-swboyd@chromium.org>
 <20190730181557.90391-22-swboyd@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190730181557.90391-22-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-input@vger.kernel.org

On Tue, Jul 30, 2019 at 11:15:21AM -0700, Stephen Boyd wrote:
> We don't need dev_err() messages when platform_get_irq() fails now that
> platform_get_irq() prints an error message itself when something goes
> wrong. Let's remove these prints with a simple semantic patch.
> 
> // <smpl>
> @@
> expression ret;
> struct platform_device *E;
> @@
> 
> ret =
> (
> platform_get_irq(E, ...)
> |
> platform_get_irq_byname(E, ...)
> );
> 
> if ( \( ret < 0 \| ret <= 0 \) )
> {
> (
> -if (ret != -EPROBE_DEFER)
> -{ ...
> -dev_err(...);
> -... }
> |
> ...
> -dev_err(...);
> )
> ...
> }
> // </smpl>
> 
> While we're here, remove braces on if statements that only have one
> statement (manually).
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Applied, thank you.

-- 
Dmitry
