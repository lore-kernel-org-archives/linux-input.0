From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCHv6] staging/iio/adc: change the MXS touchscreen driver
 implementation
Date: Thu, 09 Jan 2014 14:31:22 +0100
Message-ID: <52CEA4AA.8050503@free-electrons.com>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379946998-23041-1-git-send-email-jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

Sorry to chime in only now but it seems that this series is breaking the
touchscreen calibration on 3.13 (and -rc7 is out so it might be too
late).

At first, I though I became a terrible clicker ;) but I found some
evidences:

xinput_calibrator is complaining about misclicks, debug output:
DEBUG: Adding click 0 (X=105, Y=59)
DEBUG: Not adding click 1 (X=100, Y=59): within 7 pixels of previous click
DEBUG: Adding click 1 (X=696, Y=58)
DEBUG: Not adding click 2 (X=700, Y=55): within 7 pixels of previous click
DEBUG: Adding click 2 (X=103, Y=422)
DEBUG: Mis-click detected, click 3 (X=438, Y=415) not aligned with click 1 (X=696, Y=58) or click 2 (X=103, Y=422) (threshold=15)
DEBUG: Adding click 0 (X=424, Y=411)

Do you see the confusion ? At some point one of the coordinates is not
updated. Successful calibration with 3.12.6 gives:
DEBUG: Adding click 0 (X=126, Y=405)
DEBUG: Adding click 1 (X=684, Y=399)
DEBUG: Adding click 2 (X=128, Y=77)
DEBUG: Adding click 3 (X=683, Y=77)


With ts_calibrate:
xres = 800, yres = 480
Took 1 samples...
Top left : X =  435 Y = 3572
Took 2 samples...
Top right : X = 2094 Y = 3553
Took 2 samples...
Bot right : X = 2939 Y = 2077
Took 2 samples...
Bot left : X = 2060 Y =  644
Took 2 samples...
Center : X = 1279 Y = 1346

We experience the same thing, when changing position on an axis, we get
an average between the previous and the new position (probably because
we got 2 samples):
 - Top Left is ok
 - Top right is almost ok: X should be around 3500/3700
 - Bot right is starting to get really wrong: X is getting better (it
   should still be around 3500/3700) but Y should be quite lower
 - Bot left: Y is ok but X should be lower
 - Center is completely wrong, both values should be around 2000

Last test with evtest which is always difficult because it outputs a lot
of debug. Two separate touchs, bottom left and then top right (note that
this is with fsl,ave-ctrl = <8>;):

Event: time 1389210862.451000, type 3 (Absolute), code 0 (X), value 2183
Event: time 1389210862.451000, type 3 (Absolute), code 1 (Y), value 720
Event: time 1389210862.451000, type 3 (Absolute), code 24 (Pressure), value 6
Event: time 1389210862.451000, type 1 (Key), code 330 (Touch), value 1
Event: time 1389210862.451000, -------------- Report Sync ------------
Event: time 1389210862.477721, type 3 (Absolute), code 0 (X), value 448
Event: time 1389210862.477721, type 3 (Absolute), code 1 (Y), value 667
Event: time 1389210862.477721, type 3 (Absolute), code 24 (Pressure), value 595
Event: time 1389210862.477721, -------------- Report Sync ------------
Event: time 1389210862.504718, type 3 (Absolute), code 0 (X), value 434
Event: time 1389210862.504718, type 3 (Absolute), code 1 (Y), value 704
Event: time 1389210862.504718, type 3 (Absolute), code 24 (Pressure), value 580
Event: time 1389210862.504718, -------------- Report Sync ------------
Event: time 1389210862.536688, type 1 (Key), code 330 (Touch), value 0
Event: time 1389210862.536688, -------------- Report Sync ------------
Event: time 1389210863.359697, type 3 (Absolute), code 0 (X), value 432
Event: time 1389210863.359697, type 3 (Absolute), code 1 (Y), value 726
Event: time 1389210863.359697, type 3 (Absolute), code 24 (Pressure), value 210
Event: time 1389210863.359697, type 1 (Key), code 330 (Touch), value 1
Event: time 1389210863.359697, -------------- Report Sync ------------
Event: time 1389210863.391687, type 1 (Key), code 330 (Touch), value 0
Event: time 1389210863.391687, -------------- Report Sync ------------

We get 3 reports for bottom left, then pen up, then one report for top
right that is almost exactly the same a bottom left !

Output from 3.12:
Event: time 1389210022.146809, type 3 (Absolute), code 0 (X), value 286
Event: time 1389210022.146809, type 3 (Absolute), code 1 (Y), value 504
Event: time 1389210022.146809, type 3 (Absolute), code 24 (Pressure), value 3045
Event: time 1389210022.146809, type 1 (Key), code 330 (Touch), value 1
Event: time 1389210022.146809, -------------- Report Sync ------------
Event: time 1389210022.166830, type 3 (Absolute), code 0 (X), value 256
Event: time 1389210022.166830, type 3 (Absolute), code 1 (Y), value 489
Event: time 1389210022.166830, type 3 (Absolute), code 24 (Pressure), value 3033
Event: time 1389210022.166830, -------------- Report Sync ------------
Event: time 1389210022.186812, type 3 (Absolute), code 24 (Pressure), value 0
Event: time 1389210022.186812, type 1 (Key), code 330 (Touch), value 0
Event: time 1389210022.186812, -------------- Report Sync ------------
Event: time 1389210025.196808, type 3 (Absolute), code 0 (X), value 3812
Event: time 1389210025.196808, type 3 (Absolute), code 1 (Y), value 3637
Event: time 1389210025.196808, type 3 (Absolute), code 24 (Pressure), value 4032
Event: time 1389210025.196808, type 1 (Key), code 330 (Touch), value 1
Event: time 1389210025.196808, -------------- Report Sync ------------
Event: time 1389210025.216819, type 3 (Absolute), code 24 (Pressure), value 0
Event: time 1389210025.216819, type 1 (Key), code 330 (Touch), value 0
Event: time 1389210025.216819, -------------- Report Sync ------------


While this is not necessarily an issue with ts_calibrate (it is possible
to click longer so it collects more samples), I don't see that working
with xinput_calibrator.

While I don't have much experience with the TS part of the code but I
can investigate if you don't have any idea.


On 23/09/2013 16:36, Juergen Beisert wrote:
> The following series replaces the current busy loop touchscreen implementation
> for i.MX28/i.MX23 SoCs by a fully interrupt driven implementation.
> 
> Since i.MX23 and i.MX28 silicon differs, the existing implementation can
> be used for the i.MX28 SoC only.
> 
> The first patch adds proper clock handling. Various platforms seems to disable
> the internal 2 kHz clock which is used by the LRADC delay units.
> 
> The next two patches of this series move the i.MX28 specific definitions
> out of the way. The forth patch simplifies the register access to make it easier
> to add the i.MX23 support. Then the i.MX23 specific definitions are added, also
> the code to distinguish both SoCs at run-time.
> Up to here the existing touchscreen driver will now run on an i.MX23 Soc as well.
> 
> When these i.MX SoCs are running from battery it seems not to be a good idea to
> run a busy loop to detect touches and their location. The 6th patch adds a
> fully interrupt driven implementation which makes use of the built-in delay
> and multiple sample features of the touchscreen controller. This will reduce
> the interrupt load to a minimum.
> 
> The remaining patches in this series just removes the existing busy loop
> implementation, add a proposal for devicetree binding and a reminder what has
> still to be done with the LRADC driver.
> 
> Changes since v5:
> 
> - add missing clock handling which prevents the delay units from work (this
>   should make it work on the MX28EVK and M28EVK as well)
> 
> Changes since v4:
> 
> - honor Jonathan's comments about function names
> - honor Dmitry's comments about workqueue canceling and interrupts
> - adding devicetree bindings proposal
> 
> Changes since v3:
> 
> - split adding register access functions and i.MX23 support into two patches
> 
> Changes since v2:
> 
> - useless debug output removed
> 
> Changes since v1:
> 
> - adding register access functions to make the existing code more readable
> - adding some functions to distinguish the SoCs at run-time to avoid if-else
>   contructs whenever differences in the register layout between i.MX23 and
>   i.MX28 must be handled
> 
> Comments are welcome.
> 
> Juergen
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
