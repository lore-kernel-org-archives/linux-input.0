From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: Add Lenovo Miix 630
Date: Thu, 6 Jun 2019 09:13:48 +0100
Message-ID: <20190606081348.GB4797@dell>
References: <20190423160543.9922-1-jeffrey.l.hugo@gmail.com>
 <20190423160616.10017-1-jeffrey.l.hugo@gmail.com>
 <20190606055034.GA4797@dell>
 <20190606072601.GT22737@tuxbook-pro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190606072601.GT22737@tuxbook-pro>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>, robh+dt@kernel.org, mark.rutland@arm.com, agross@kernel.org, david.brown@linaro.org, dmitry.torokhov@gmail.com, jikos@kernel.org, benjamin.tissoires@redhat.com, hdegoede@redhat.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 06 Jun 2019, Bjorn Andersson wrote:

> On Wed 05 Jun 22:50 PDT 2019, Lee Jones wrote:
> 
> > On Tue, 23 Apr 2019, Jeffrey Hugo wrote:
> > 
> > > This adds the initial DT for the Lenovo Miix 630 laptop.  Supported
> > > functionality includes USB (host), microSD-card, keyboard, and trackpad.
> > > 
> > > Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> > > ---
> > >  arch/arm64/boot/dts/qcom/Makefile             |   1 +
> > >  .../boot/dts/qcom/msm8998-clamshell.dtsi      | 278 ++++++++++++++++++
> > >  .../boot/dts/qcom/msm8998-lenovo-miix-630.dts |  30 ++
> > 
> > What's happening with this patch?
> > 
> 
> The thermal-zones are wrong, but I'm okay with an incremental patch for
> that...

I guess it would take you about 10 seconds to whip those out when
merging?

> > It's been on the list a while now.  I'm waiting for it to be accepted,
> > since there are patches I wish to submit which are based on it.
> > 
> > Who is responsible for merging these?
> 
> ...so I've just been waiting for a conclusion on the HID patch before I
> could pick this up.

Aren't they orthogonal? 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
