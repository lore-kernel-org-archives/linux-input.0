From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 1/8] dt-bindings: mfd: document stpmic1
Date: Fri, 26 Oct 2018 12:46:18 +0100
Message-ID: <20181026114618.GR4870@dell>
References: <1539853324-29051-1-git-send-email-p.paillet@st.com>
 <1539853324-29051-2-git-send-email-p.paillet@st.com>
 <20181025094430.GQ4939@dell>
 <CAL_JsqKsp8kTK2v_cBrNm+enzieQSEh2G7KMxsBdidr+XhDwTg@mail.gmail.com>
 <20181026064614.GG4870@dell>
 <5BD2E2DB.5090305@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5BD2E2DB.5090305@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pascal PAILLET-LME <p.paillet@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Enric Balletbo i Serra <eballetbo@gmail.com>
List-Id: linux-input@vger.kernel.org

On Fri, 26 Oct 2018, Pascal PAILLET-LME wrote:

> Hello Lee,
> 
> Le 10/26/2018 08:46 AM, Lee Jones a écrit :
> > On Thu, 25 Oct 2018, Rob Herring wrote:
> >
> >> On Thu, Oct 25, 2018 at 4:44 AM Lee Jones <lee.jones@linaro.org> wrote:
> >>> Rob: please grep your name for some feedback.
> > [Moved to the top]
> >
> >>> I'm surprised Rob allowed you to add register bits in a DT property?
> >> Yeah, they are certainly questionable and not something we encourage,
> >> but the alternative would be dozens of properties which only apply for
> >> this one device and just get translated back to register values.
> > I don't see how this device is any different to the 100's of devices
> > which are already supported in DT.
> >
> >>> On Thu, 18 Oct 2018, Pascal PAILLET-LME wrote:
> >>>
> >>>> From: pascal paillet <p.paillet@st.com>
> >>>> +Optional parent device properties:
> >>>> +- st,main-control-register:
> >>>> +     -bit 1: Power cycling will be performed on turn OFF condition
> >>>> +     -bit 2: PWRCTRL is functional
> >>>> +     -bit 3: PWRCTRL active high
> >>>> +- st,pads-pull-register:
> >>>> +     -bit 1: WAKEUP pull down is not active
> >>>> +     -bit 2: PWRCTRL pull up is active
> >>>> +     -bit 3: PWRCTRL pull down is active
> >>>> +     -bit 4: WAKEUP detector is disabled
> > This should be part of the Pinctrl configuration/driver.
> >
> > And Pinctrl probably already has properties for this?
> I will remove this in the next version.
> >>>> +- st,vin-control-register:
> >>>> +     -bit 0: VINLOW monitoring is enabled
> >>>> +     -bit [1...3]: VINLOW rising threshold
> >>>> +             000 VINOK_f + 50mV
> >>>> +             001 VINOK_f + 100mV
> >>>> +             010 VINOK_f + 150mV
> >>>> +             011 VINOK_f + 200mV
> >>>> +             100 VINOK_f + 250mV
> >>>> +             101 VINOK_f + 300mV
> >>>> +             110 VINOK_f + 350mV
> >>>> +             111 VINOK_f + 400mV
> >>>> +     -bit [4...5]: VINLOW hyst
> >>>> +             00 100mV
> >>>> +             01 200mV
> >>>> +             10 300mV
> >>>> +             11 400mV
> >>>> +     -bit 6: SW_OUT detector is disabled
> >>>> +     -bit 7: SW_IN detector is enabled.
> > This should be part of the Regulator configuration/driver?
> I will also remove this in the next version. I think this could be 
> handled by an hardware monitor future driver.
> >>>> +- st,usb-control-register:
> >>>> +     -bit 3: SW_OUT current limit
> >>>> +             0: 600mA
> >>>> +             1: 1.1A
> >>>> +     -bit 4: VBUS_OTG discharge is enabled
> >>>> +     -bit 5: SW_OUT discharge is enabled
> >>>> +     -bit 6: VBUS_OTG detection is enabled
> >>>> +     -bit 7: BOOST_OVP is disabled
> > This should be part of the USB configuration/driver?
> >
> I will also remove this in the next version. And I'm going to add active 
> discharge ops in the regulator driver.

And unless this device is in any way special, these subsystems should
already have generic bindings to set these hardware configuration
options.

I would say that passing raw register values is not the way to go.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
