From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v5 30/46] regulator: pwm: retrieve correct voltage
Date: Thu, 7 Apr 2016 23:54:31 +0200
Message-ID: <20160407235431.788dc24a@bbrezillon>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
	<1459368249-13241-31-git-send-email-boris.brezillon@free-electrons.com>
	<20160330212410.GX2350@sirena.org.uk>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBI5OTO4AKGQEVXNH6AI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20160330212410.GX2350-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>Lee Jones <l>
List-Id: linux-input@vger.kernel.org

Hi Mark,

On Wed, 30 Mar 2016 14:24:10 -0700
Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> On Wed, Mar 30, 2016 at 10:03:53PM +0200, Boris Brezillon wrote:
> > The continuous PWM voltage regulator is caching the voltage value in
> > the ->volt_uV field. While most of the time this value should reflect the
> > real voltage, sometime it can be sightly different if the PWM device
> > rounded the set_duty_cycle request.
> > Moreover, this value is not valid until someone has modified the regulator
> > output.
> 
> Acked-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Actually this patch introduces a bug (reported by Stephen):

"
I applied your patch series [PATCH v5 00/46] pwm: add support for
atomic update and found a null pointer dereference when probing a
pwm-regulator at boot. See the below stack trace:

[ 4.282374] [<ffffffc000399088>] pwm_regulator_get_voltage+0x78/0xa0
[ 4.289344] [<ffffffc000390740>] regulator_attr_is_visible+0x7c/0x264
[ 4.296408] [<ffffffc0001f75a0>] internal_create_group+0x14c/0x280
[ 4.303184] [<ffffffc0001f76e8>] sysfs_create_group+0x14/0x1c
[ 4.309483] [<ffffffc0001f77c8>] sysfs_create_groups+0x30/0x78
[ 4.315881] [<ffffffc00043631c>] device_add+0x224/0x4d8
[ 4.321609] [<ffffffc0004365ec>] device_register+0x1c/0x28
[ 4.327623] [<ffffffc0003952a4>] regulator_register+0x2e4/0xc14
[ 4.334112] [<ffffffc000396844>] devm_regulator_register+0x54/0x94
[ 4.340887] [<ffffffc000399328>] pwm_regulator_probe+0x278/0x2b8
[ 4.347473] [<ffffffc000439fe4>] platform_drv_probe+0x58/0xa4
[ 4.353772] [<ffffffc0004387a8>] driver_probe_device+0x114/0x2ac
[ 4.360358] [<ffffffc0004389a4>] __driver_attach+0x64/0x90
[ 4.366371] [<ffffffc000436f50>] bus_for_each_dev+0x74/0x90
[ 4.372478] [<ffffffc000438bd4>] driver_attach+0x20/0x28
[ 4.378299] [<ffffffc00043778c>] bus_add_driver+0xe8/0x1e0
[ 4.384312] [<ffffffc00043959c>] driver_register+0x98/0xe4
[ 4.390326] [<ffffffc00043aa04>] __platform_driver_register+0x48/0x50
[ 4.397388] [<ffffffc000cb2710>] pwm_regulator_driver_init+0x18/0x20
[ 4.404356] [<ffffffc000c8ca7c>] do_one_initcall+0xf8/0x180
[ 4.410466] [<ffffffc000c8cc58>] kernel_init_freeable+0x154/0x1f4
[ 4.417148] [<ffffffc000929cf4>] kernel_init+0x10/0xf8
[ 4.422782] [<ffffffc000084450>] ret_from_fork+0x10/0x40

It looks like the root cause is that regulator_attr_is_visible will
try to get the voltage, but at this point in regulator_register,
rdev->constraints is still null. So
pwm_duty_cycle_percentage_to_voltage will dereference a null
rdev->constraints pointer.
"

The problem is that we need to know the min and max voltage constraints
to calculate the current voltage. ->get_voltage() is called when the
sysfs attributes are created (part of device registration), and
set_machine_constraints() is called after device_register(), thus
leading to the NULL pointer dereference.

Is there any reason for calling set_machine_constraints() after
device_register() in regulator_register()?

Best Regards,

Boris
