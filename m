From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 1/2] i2c: cros-ec-tunnel: Fix usage of cros_ec_cmd_xfer()
Date: Tue, 26 Jul 2016 11:38:20 -0700
Message-ID: <20160726183819.GA9660@google.com>
References: <1469470451-111822-1-git-send-email-briannorris@chromium.org>
 <1469470451-111822-2-git-send-email-briannorris@chromium.org>
 <20160725204313.GA1698@katana>
 <20160725204825.GA144142@google.com>
 <20160726091433.GC2433@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160726091433.GC2433@ulmo.ba.sec>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Olof Johansson <olof@lixom.net>, Brian Norris <computersforpeace@gmail.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Shawn Nematbakhsh <shawnn@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-input@vger.kernel.org

Hi Thierry,

On Tue, Jul 26, 2016 at 11:14:33AM +0200, Thierry Reding wrote:
> On Mon, Jul 25, 2016 at 01:48:25PM -0700, Brian Norris wrote:
> > On Mon, Jul 25, 2016 at 10:43:13PM +0200, Wolfram Sang wrote:
> > > On Mon, Jul 25, 2016 at 11:14:10AM -0700, Brian Norris wrote:
> > > > cros_ec_cmd_xfer returns success status if the command transport
> > > > completes successfully, but the execution result is incorrectly ignored.
> > > > In many cases, the execution result is assumed to be successful, leading
> > > > to ignored errors and operating on uninitialized data.
> > > > 
> > > > We've recently introduced the cros_ec_cmd_xfer_status() helper to avoid these
> > > > problems. Let's use it.
> > > > 
> > > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > > 
> > > I agree with Dmitry about Thierry pushing the patch. So:
> > > 
> > > Acked-by: Wolfram Sang <wsa@the-dreams.de>
> > 
> > Fine with me, as long as Thierry is up for it.
> > 
> > BTW, I think the dependency is on target for v4.8-rc1, so if Thierry
> > misses this, then you should be able to apply this yourself after the
> > merge window.
> 
> Why the rush? The behaviour of the cros_ec_cmd_xfer() function has not
> changed in at least a year, so this can't be very urgent. I merged the
> original patch because it is a dependency for another patch, but given
> the above I think it's fine if we wait until after v4.8-rc1 and let
> subsystem maintainers pick them up individually.

I wasn't personally suggesting it was a rush -- actually, the contrary.
I was just informing Wolfram and Dmitry that the dependency only was
relevant *if* they were rushing to have the patches applied.

Regarding timeline: some form of this patch was authored and submitted
to our downstream tree over a year ago. I just happened to notice
recently, now that the ..._status() helper is going upstream.

> On another note, the commit message makes it sound like this might fix
> potential bugs. Since it's been like that for a couple of releases, do
> we need to Cc: stable@vger.kernel.org?

It does potentially fix bugs. I suspect those bugs would probably occur
mostly in cases of poorly-configured software (e.g., using the wrong EC
protocol) or prototype hardware, but it's certainly possible this could
head off in-the-field bugs. Perhaps Gwendal or Shawn could elaborate.

At any rate, if you Cc: stable@vger.kernel.org, you'll want to include
the dependency in the commit message. I think the format is something
like this:

Fixes: SHA ("i2c: wherever this driver was introduced")
Cc: <stable@vger.kernel.org> # 9798ac6d32c1 mfd: cros_ec: Add cros_ec_cmd_xfer_status() helper

Regards,
Brian
