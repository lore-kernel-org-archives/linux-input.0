From: Andi Shyti <andi-4oq5MDd++3k@public.gmane.org>
Subject: Re: [PATCH v5 5/5] arm64: dts: exynos: Add tm2 touchkey node
Date: Sun, 8 Jan 2017 15:13:31 +0900
Message-ID: <20170108061331.uzpig4gzrlyhndhc@jack.zhora.eu>
References: <CGME20170106134356epcas1p1aee9f715c58b50f6056bf0b43b849497@epcas1p1.samsung.com>
 <20170106134350.32428-1-andi.shyti@samsung.com>
 <20170106134350.32428-6-andi.shyti@samsung.com>
 <CAGTfZH2QYQK190kYFbOMqJMFgH32548ra-VqzYwc5LVBJwqisA@mail.gmail.com>
 <CAGTfZH347ZRve20cdGLwtuf6arRAJ4Ry+HQrTubDj-RGR=K9cA@mail.gmail.com>
 <CAGTfZH1QtbieMxQzoPvxsP_3tSYBSuXe+wtq0uUs03mhcLFdXg@mail.gmail.com>
 <20170107124026.gl447hl5bucdflyk@jack.zhora.eu>
 <CAGTfZH35sx5v-XcxkDG7TVRmW8cLirAXRxA=kGZQDBnpw3vYhg@mail.gmail.com>
 <20170108054504.fssqicmeovufar2r@jack.zhora.eu>
 <CAGTfZH1CuMxhaqPJCzxgF8p39OAu+o0GDJEsh5DVGtU-hqfxvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGTfZH1CuMxhaqPJCzxgF8p39OAu+o0GDJEsh5DVGtU-hqfxvQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chanwoo Choi <cwchoi00-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Andi Shyti <andi-ahk0KpmfxKRAfugRpC6u6w@public.gmane.org>, Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jaechul Lee <jcsing.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jaechul Lee <galaxyra-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Chanwoo,

> >> >> >>> +       touchkey@20 {
> >> >> >>> +               compatible = "samsung,tm2-touchkey";
> >> >> >>> +               reg = <0x20>;
> >> >> >>> +               interrupt-parent = <&gpa3>;
> >> >> >>> +               interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
> >> >> >>> +               vcc-supply = <&ldo32_reg>;
> >> >> >>> +               vdd-supply = <&ldo33_reg>;
> >> >> >>> +       };
> >> >> >>> +};
> >> >> >>> +
> >> >> >>>  &ldo31_reg {
> >> >> >>>         regulator-name = "TSP_VDD_1.85V_AP";
> >> >> >>>         regulator-min-microvolt = <1850000>;
> >> >>
> >> >> I repiled the touchkey driver against compatible name.
> >> >> Usually, when developing the device driver, we use the specific h/w name
> >> >> but in this patch, the touckey dt node uses the h/w board name instead of
> >> >> original touckhey name.
> >> >
> >> > this should be a device specifically done for the tm2 and we are
> >> > not sure who is the manufacturer of the device. In order to not
> >>
> >> As I knew, this touchkey was made by Cypress semiconductor.
> >> But, for more correct information, you may try to find it.
> >
> > The Android Kernel says that this is the cy8cmbr3xxx. I
> > downloaded the datasheets, but it doesn't have any similarity
> > with the device. Which means that on tm2 we don't the
> > cy8cmbr3xxx bot something else that I even doubt comes from
> > cypress, but I strongly believe it's a dedicated hardware.
> 
> Although this device is a dedicated h/w, you should keep the principal.
> Did you check the schematic document of TM2? The schematic document
> might include the specific device name.
> 
> Sometimes, the downloaded datasheet does not include the
> all of information of device because of confidential information.
> But, I’m not sure. Just it is guess as my experience.
> 
> I want to check the manufacturer and name of device with you
> on next Monday.

Yes, I checked everything, but didn't find the exact device name.

Anyway, let's take this discussion offline and find the correct
way.

Andi
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
