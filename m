From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 1/2] i2c: cros-ec-tunnel: Fix usage of cros_ec_cmd_xfer()
Date: Mon, 25 Jul 2016 13:48:25 -0700
Message-ID: <20160725204825.GA144142@google.com>
References: <1469470451-111822-1-git-send-email-briannorris@chromium.org>
 <1469470451-111822-2-git-send-email-briannorris@chromium.org>
 <20160725204313.GA1698@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160725204313.GA1698@katana>
Sender: linux-i2c-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Olof Johansson <olof@lixom.net>, Brian Norris <computersforpeace@gmail.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Shawn Nematbakhsh <shawnn@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-input@vger.kernel.org

On Mon, Jul 25, 2016 at 10:43:13PM +0200, Wolfram Sang wrote:
> On Mon, Jul 25, 2016 at 11:14:10AM -0700, Brian Norris wrote:
> > cros_ec_cmd_xfer returns success status if the command transport
> > completes successfully, but the execution result is incorrectly ignored.
> > In many cases, the execution result is assumed to be successful, leading
> > to ignored errors and operating on uninitialized data.
> > 
> > We've recently introduced the cros_ec_cmd_xfer_status() helper to avoid these
> > problems. Let's use it.
> > 
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> 
> I agree with Dmitry about Thierry pushing the patch. So:
> 
> Acked-by: Wolfram Sang <wsa@the-dreams.de>

Fine with me, as long as Thierry is up for it.

BTW, I think the dependency is on target for v4.8-rc1, so if Thierry
misses this, then you should be able to apply this yourself after the
merge window.

Regards,
Brian
