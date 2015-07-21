From: "Opensource [Steve Twiss]" <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH V2 3/3] rtc: da9063: Add DA9062 RTC capability to DA9063
 RTC driver
Date: Tue, 21 Jul 2015 10:15:29 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B254064@SW-EX-MBX02.diasemi.com>
References: <cover.1437471790.git.stwiss.opensource@diasemi.com>
 <93f0906ed7db18b893385b60a43b02f248dfe9a6.1437471790.git.stwiss.opensource@diasemi.com>
 <20150721100151.GC2853@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150721100151.GC2853-m++hUPXGwpdeoWH0uzbU5w@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUXINPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUXKERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, RTCLINUX <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, David Dajun Chen <david.chen-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Support Opensource <Support.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 21 July 2015 11:02, Alexandre Belloni wrote:

Hi Alexandre,

Thanks for your help on this
I will send patch v3 with the following changes ...
 
> On 21/07/2015 at 10:43:10 +0100, S Twiss wrote :
> > -	if (val & (DA9063_E_ALARM))
> > +	if (val & (config->rtc_event_alarm_mask))
> unneeded parenthesis here

changed to this:
-       if (val & (config->rtc_event_alarm_mask))
+       if (val & config->rtc_event_alarm_mask)

> > +	if (of_device_is_compatible(pdev->dev.of_node, "dlg,da9063-rtc")) {
> > +		struct da9063 *chip = dev_get_drvdata(pdev->dev.parent);
> > +
> > +		if (chip->variant_code == PMIC_DA9063_AD)
> > +			rtc->config = &da9063_ad_regs;
> > +	} else
> > +		rtc->config = match->data;
> 
> Both arms of the if should use braces.
> Also, what happens if it is a da9063, BB variant? I guess rtc->config
> will not be set.
> maybe you should write:
> 
> rtc->config = match->data;
> if (of_device_is_compatible(pdev->dev.of_node, "dlg,da9063-rtc")) {
>      struct da9063 *chip = dev_get_drvdata(pdev->dev.parent);
> 
>      if (chip->variant_code == PMIC_DA9063_AD)
>          rtc->config = &da9063_ad_regs;
> }

Sure, that is more efficient. No need for an else and explicitly defaulting the BB
register mappings.

+       rtc->config = match->data;
        if (of_device_is_compatible(pdev->dev.of_node, "dlg,da9063-rtc")) {
                struct da9063 *chip = dev_get_drvdata(pdev->dev.parent);
 
                if (chip->variant_code == PMIC_DA9063_AD)
                        rtc->config = &da9063_ad_regs;
-       } else
-               rtc->config = match->data;
+       }

> >  MODULE_AUTHOR("S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>");
> >  MODULE_DESCRIPTION("Real time clock device driver for Dialog DA9063");
> > -MODULE_LICENSE("GPL v2");
> > +MODULE_LICENSE("GPL");
> 
> This should be part of the license change.

Sure:
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");

Regards,
Steve
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
