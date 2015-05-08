From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: RE: [PATCH V1 5/6] watchdog: da9062: DA9062 watchdog driver
Date: Fri, 8 May 2015 13:46:42 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B227F1A@SW-EX-MBX02.diasemi.com>
References: <cover.1429280614.git.stwiss.opensource@diasemi.com>
 <2afd9f55c71553186e99bfe386312f0c7d7501ed.1429280614.git.stwiss.opensource@diasemi.com>
 <55327DDA.4080003@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.138]:62608 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752505AbbEHNrC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 8 May 2015 09:47:02 -0400
In-Reply-To: <55327DDA.4080003@roeck-us.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, LINUXKERNEL <linux-kernel@vger.kernel.org>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>
Cc: Alessandro Zummo <a.zummo@towertech.it>, DEVICETREE <devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LINUXINPUT <linux-input@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, RTCLINUX <rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Support Opensource <Support.Opensource@diasemi.com>

On 18 April 2015 16:53 Guenter Roeck wrote:

Hi Guenter,

There were some missing explanations in my previous e-mails for some of 
your comments. Please find them below.

During the da9062_wdt_probe() there were several ignored error paths and
a missing cleanup . I intend to rectify this with the following:

--- a/linux-next/v4.0/drivers/watchdog/da9062_wdt.c
+++ b/linux-next/v4.0/drivers/watchdog/da9062_wdt.c
@@ -232,8 +232,11 @@ static int da9062_wdt_probe(struct platform_device *pdev)
        dev_set_drvdata(&pdev->dev, wdt);
 
        irq = platform_get_irq_byname(pdev, "WDG_WARN");
-       if (irq < 0)
+       if (irq < 0) {
                dev_err(wdt->hw->dev, "Failed to get IRQ.\n");
+               ret = irq;
+               goto error;
+       }
 
        ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
                           da9062_wdt_wdg_warn_irq_handler,
@@ -242,20 +245,23 @@ static int da9062_wdt_probe(struct platform_device *pdev)
        if (ret) {
                dev_err(wdt->hw->dev,
                        "Failed to request watchdog device IRQ.\n");
+               goto error;
        }
 
        ret = watchdog_register_device(&wdt->wdtdev);
-       if (ret < 0)
+       if (ret < 0) {
                dev_err(wdt->hw->dev,
                        "watchdog registration incomplete (%d)\n", ret);
+               goto error;
+       }
 
        da9062_set_window_start(wdt);
 
        ret = da9062_wdt_ping(&wdt->wdtdev);
        if (ret < 0)
-               dev_err(wdt->hw->dev,
-                       "failed to ping the watchdog (%d)\n", ret);
+               watchdog_unregister_device(&wdt->wdtdev);
 
+error:
        return ret;
 }

Also there was an explanation required for the confusing ping() function
inside the driver probe() ...

> > +	da9062_wdt_ping(&wdt->wdtdev);
[...]
> That ping is asking for an explanation. Does it imply that the watchdog is
> known to be running and cannot be stopped ?

Pinging the DA9062 watchdog has no effect if it is disabled. But I guessed that
in a real application if the watchdog -was- enabled from start-up then the first
thing the driver needed to do was kick the watchdog.

I could have put protection around it, say by reading the TWDSCALE bit for 
whether the watchdog was enabled, and that would have made it more explicit
but in this case it wouldn't matter.

This can be removed if you prefer.

Regards,
Steve
