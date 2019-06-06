From: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: Add Lenovo Miix 630
Date: Thu, 6 Jun 2019 08:27:24 -0600
Message-ID: <CAOCk7Nrt+vWG6c9uYWunbKdUN4XcukbvyKDO1NdmYvFMfOYNhA@mail.gmail.com>
References: <20190423160543.9922-1-jeffrey.l.hugo@gmail.com>
 <20190423160616.10017-1-jeffrey.l.hugo@gmail.com> <20190606055034.GA4797@dell>
 <20190606072601.GT22737@tuxbook-pro> <20190606081348.GB4797@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190606081348.GB4797@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Andy Gross <agross@kernel.org>, David Brown <david.brown@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, devicetree@vger.kernel.org, MSM <linux-arm-msm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Jun 6, 2019 at 2:13 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Thu, 06 Jun 2019, Bjorn Andersson wrote:
>
> > On Wed 05 Jun 22:50 PDT 2019, Lee Jones wrote:
> >
> > > On Tue, 23 Apr 2019, Jeffrey Hugo wrote:
> > >
> > > > This adds the initial DT for the Lenovo Miix 630 laptop.  Supported
> > > > functionality includes USB (host), microSD-card, keyboard, and trackpad.
> > > >
> > > > Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> > > > ---
> > > >  arch/arm64/boot/dts/qcom/Makefile             |   1 +
> > > >  .../boot/dts/qcom/msm8998-clamshell.dtsi      | 278 ++++++++++++++++++
> > > >  .../boot/dts/qcom/msm8998-lenovo-miix-630.dts |  30 ++
> > >
> > > What's happening with this patch?
> > >
> >
> > The thermal-zones are wrong, but I'm okay with an incremental patch for
> > that...
>
> I guess it would take you about 10 seconds to whip those out when
> merging?
>
> > > It's been on the list a while now.  I'm waiting for it to be accepted,
> > > since there are patches I wish to submit which are based on it.
> > >
> > > Who is responsible for merging these?
> >
> > ...so I've just been waiting for a conclusion on the HID patch before I
> > could pick this up.
>
> Aren't they orthogonal?

Eh, if the HID stuff changes, we'll probably have to change the DT.
Which isn't great.

I guess we could also merge this, and fix it up as necessary if there
is fall out from the HID stuff.
