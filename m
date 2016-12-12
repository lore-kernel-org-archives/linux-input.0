From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2 1/2] devicetree: i2c-hid: Add Wacom digitizer +
 regulator support
Date: Mon, 12 Dec 2016 11:01:10 +0100
Message-ID: <20161212100110.GA13907@mail.corp.redhat.com>
References: <20161206084803.GR1280@mail.corp.redhat.com>
 <CAL_Jsq+C1MWrN4Sg_xOgpTzQh9gfL12G5Uxb1ya2MTkoa=7fMA@mail.gmail.com>
 <CAD=FV=UMonRe8WJ1feDv3Nh9g8hEGAwwFT5NYLbzXADBqhTf-A@mail.gmail.com>
 <20161208154145.GA30888@mail.corp.redhat.com>
 <CAL_Jsq+fdoFnarXYkPv6FjVue3v31ry-Ddfkq9fQk9Ek+AjETw@mail.gmail.com>
 <E409F66F-1E4B-4A63-9977-69DF44ACAB0A@gmail.com>
 <CAL_JsqKu0yhLVyEjcZs_rn=VqM9O4F_VMhOkfhEEvbYAjvWSTg@mail.gmail.com>
 <alpine.LNX.2.00.1612091532240.16984@cbobk.fhfr.pm>
 <CAL_JsqLpjhHeeKq3PmNToux1Rgkg0M84-dv9HGCOws223ima4w@mail.gmail.com>
 <alpine.LNX.2.00.1612120951130.16984@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1612120951130.16984@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Doug Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Caesar Wang <wxt@rock-chips.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-input@vger.kernel.org

On Dec 12 2016 or thereabouts, Jiri Kosina wrote:
> Given the timing (merge window being open) and given then NACK given by 
> Rob, I've now unapplied the patches (the for-4.10/i2c-hid branch is now 
> obsolete, and has been superseded by for-4.10/i2c-hid-nopower).
> 
> However, this is mostly done in order to provide more time for discussion; 
> I still disagree with the reasoning behind the NACK.
> 

To hopefully make things going forward a little bit, I was wondering
over the week-end if we should not solve this particular issue by adding
an intermediate platform DT node:

instead of having:
---
	i2c-hid-dev@2c {
		compatible = "hid-over-i2c";
		reg = <0x2c>;
		hid-descr-addr = <0x0020>;
		interrupt-parent = <&gpx3>;
		interrupts = <3 2>;
		vdd-supply = <sth>;
		init-delay-ms = <100>;
	};
---

we would have:
---
	platform-i2c-hid@01 {
		compatible = "very-special-board-that-needs-firmware-quirks-and-delay-of-100ms";
		vdd-supply = <sth>;
		i2c-hid-dev@2c {
			compatible = "hid-over-i2c";
			reg = <0x2c>;
			hid-descr-addr = <0x0020>;
			interrupt-parent = <&gpx3>;
			interrupts = <3 2>;
                };
	};
---

If I am not wrong, the platform device should be initialized before
i2c-hid get called, which allows to setup properly the vdd supply.
On resume/suspend, the tree should be respected and we should be able to
enable/disable power in the same fashion this patch provides.

We could then extend this platform device at will without tinkering in
i2c-hid and we could also handle the GPIOs, reset or whatever is
required in the future through compatibles.

Thoughts? yes? no? bullshit?

Cheers,
Benjamin
