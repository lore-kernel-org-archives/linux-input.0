From: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: Add Lenovo Miix 630
Date: Mon, 29 Apr 2019 09:16:49 -0600
Message-ID: <CAOCk7Nqa_nXkOJeoOg2n2UMrkdYfT6jEBpVcPh2zTE+NJLe8FA@mail.gmail.com>
References: <20190415160915.16324-1-jeffrey.l.hugo@gmail.com>
 <20190415161115.16466-1-jeffrey.l.hugo@gmail.com> <20190427044245.GD3137@builder>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190427044245.GD3137@builder>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Andy Gross <agross@kernel.org>, David Brown <david.brown@linaro.org>, Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Apr 26, 2019 at 10:42 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Mon 15 Apr 09:11 PDT 2019, Jeffrey Hugo wrote:
> > diff --git a/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi b/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
> [..]
> > +     thermal-zones {
> > +             battery-thermal {
> > +                     polling-delay-passive = <250>;
> > +                     polling-delay = <1000>;
> > +
> > +                     thermal-sensors = <&tsens0 0>;
>
> I guess you inherited the battery and skin thermal nodes from my MTP
> dts. Unfortunately after talking to Amit I think I got these wrong, and
> they should be &pmi8998_adc 0 and 5 instead.
>
> Can you confirm this?

Yeah, I pulled thermal from the MTP.  Someone pointed this out on the
v4 series.  I haven't circled back to it yet.

>
> > +
> > +                     trips {
> > +                             battery_crit: trip0 {
> > +                                     temperature = <60000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "critical";
> > +                             };
> > +                     };
> > +             };
>
> Regards,
> Bjorn
