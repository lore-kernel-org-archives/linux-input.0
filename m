From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: RE: [PATCH V1 5/6] watchdog: da9062: DA9062 watchdog driver
Date: Thu, 7 May 2015 17:45:13 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B221DD2@SW-EX-MBX02.diasemi.com>
References: <cover.1429280614.git.stwiss.opensource@diasemi.com>
 <2afd9f55c71553186e99bfe386312f0c7d7501ed.1429280614.git.stwiss.opensource@diasemi.com>
 <55327DDA.4080003@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7014B21924A@SW-EX-MBX02.diasemi.com>
 <20150506160227.GA28101@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7014B21925B@SW-EX-MBX02.diasemi.com>
 <20150506200631.GA25846@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150506200631.GA25846@roeck-us.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: LINUXKERNEL <linux-kernel@vger.kernel.org>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>, Alessandro Zummo <a.zummo@towertech.it>, DEVICETREE <devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LINUXINPUT <linux-input@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, RTCLINUX <rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Support Opensource <Support.Opensource@diasemi.com>
List-Id: linux-input@vger.kernel.org

On 06 May 2015 21:07 Guenter Roeck wrote:

> > > > The DA9062 watchdog ping (register CONTROL_F) is "windowed" for protection
> > > > against spurious writes -- i.e. the ping function cannot be called within a 250ms
> > > > time limit or the PMIC will reset. This windowing protection also extends to altering
> > > > the timeout scale in the CONTROL_D register -- in which case if the timeout
> > > > register is altered and the ping() function is called within the 250ms limit, the
> > > > PMIC will reset. The delay is there to stop that from happening.
> > > >
> > > > I realised my previous patch was over-sanitised: by putting the time delay into the
> > > > ping() function I was protecting CONTROL_D in stop() and update_timeout_register(),
> > > > but I was being too over-protective of the ping() function. Therefore if there was an
> > > > "incorrect trigger signal", the watchdog would not be allowed to fail because the
> > > > driver would have filtered out the errors.
> > > >
> > > Hi Steve,
> > >
> > > From your description, it sounds like the protection is only necessary if there
> > > was a previous write to the same register(s).

Hi Guenter,

A clarification from me. It is not the CONTROL_D register that needs protecting, but when
the CONTROL_D register is altered the function call also performs a CONTROL_F watchdog
ping. Too many pings close together would cause the PMIC reset.

> > > If so, it might make sense to record the time of such writes, and only add the delay
> > > if necessary, and only for the remainder of the time.

I've tried it several ways, but my previous suggestion of putting the delays in the stop() and 
update_timeout_register() functions just cause even more lengthy delays.

So, I've followed your suggestion and used a variable delay inside the ping() function instead:
this seems to cause a lot less delay. A debug message can be used to notify the user if the
watchdog is trying to be kicked too quickly -- that would be more preferable than just shutting
the PMIC down and still provide a notification that something wasn't quite right.

> > > Would this be possible ?

I'll run the tests overnight.
I'm going to do something like this:

diff --git a/linux-next/v4.0/drivers/watchdog/da9062_wdt.c b/linux-next/v4.0/drivers/watchdog/da9062_wdt.c
index ad80261..d596910 100644
--- a/gp_sparse/linux-next/v4.0/drivers/watchdog/da9062_wdt.c
+++ b/gp_sparse/linux-next/v4.0/drivers/watchdog/da9062_wdt.c

@@ -32,12 +33,37 @@ static const unsigned int wdt_timeout[] = { 0, 2, 4, 8, 16, 32, 65, 131 };
 #define DA9062_WDT_MIN_TIMEOUT         wdt_timeout[DA9062_TWDSCALE_MIN]
 #define DA9062_WDT_MAX_TIMEOUT         wdt_timeout[DA9062_TWDSCALE_MAX]
 #define DA9062_WDG_DEFAULT_TIMEOUT     wdt_timeout[DA9062_TWDSCALE_MAX-1]
+#define DA9062_RESET_PROTECTION_MS     300
 
 struct da9062_watchdog {
        struct da9062 *hw;
        struct watchdog_device wdtdev;
+       unsigned long j_time_stamp;
 };
 
+static void da9062_set_window_start(struct da9062_watchdog *wdt)
+{
+       wdt->j_time_stamp = jiffies;
+}
+
+static void da9062_apply_window_protection(struct da9062_watchdog *wdt)
+{
+       unsigned long delay = msecs_to_jiffies(DA9062_RESET_PROTECTION_MS);
+       unsigned long timeout = wdt->j_time_stamp + delay;
+       unsigned long now = jiffies;
+       unsigned int diff_ms;
+
+       /* if time-limit has not elapsed then wait for remainder */
+       if (time_before(now, timeout)) {
+               diff_ms = jiffies_to_msecs(timeout-now);
+               dev_dbg(wdt->hw->dev,
+                       "Delaying watchdog ping by %u msecs\n", diff_ms);
+               mdelay(diff_ms);
+       }
+
+       return;
+}
+
 static unsigned int da9062_wdt_timeout_to_sel(unsigned int secs)
 {
        unsigned int i;
@@ -50,26 +76,29 @@ static unsigned int da9062_wdt_timeout_to_sel(unsigned int secs)
        return DA9062_TWDSCALE_MAX;
 }
 
-static int da9062_reset_watchdog_timer(struct da9062 *hw)
+static int da9062_reset_watchdog_timer(struct da9062_watchdog *wdt)
 {
        int ret;
 
-       ret = regmap_update_bits(hw->regmap,
+       da9062_apply_window_protection(wdt);
+
+       ret = regmap_update_bits(wdt->hw->regmap,
                           DA9062AA_CONTROL_F,
                           DA9062AA_WATCHDOG_MASK,
                           DA9062AA_WATCHDOG_MASK);
 
-       mdelay(300);
+       da9062_set_window_start(wdt);
 
        return ret;
 }

[...]
 
@@ -216,6 +245,8 @@ static int da9062_wdt_probe(struct platform_device *pdev)
                dev_err(wdt->hw->dev,
                        "watchdog registration incomplete (%d)\n", ret);
 
+       da9062_set_window_start(wdt);
+
        da9062_wdt_ping(&wdt->wdtdev);
        if (ret < 0)
                dev_err(wdt->hw->dev,
