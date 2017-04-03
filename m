From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/6] Input: pm8xxx-vib: sync device tree bindings doc
 with the driver
Date: Mon, 3 Apr 2017 11:31:33 -0700
Message-ID: <20170403183133.GC34530@dtor-ws>
References: <20170331161538.11657-1-damien.riegel@savoirfairelinux.com>
 <20170331161538.11657-2-damien.riegel@savoirfairelinux.com>
 <20170401165409.GE17130@dtor-ws>
 <20170401175127.3nt5gujkvgyoh2tc@workotop.localdomain>
 <20170401180607.GM17130@dtor-ws>
 <20170401185722.b4fet5i2mmoe7elf@workotop.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35080 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751136AbdDCSbh (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 3 Apr 2017 14:31:37 -0400
Received: by mail-pg0-f68.google.com with SMTP id g2so31540835pge.2
        for <linux-input@vger.kernel.org>; Mon, 03 Apr 2017 11:31:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170401185722.b4fet5i2mmoe7elf@workotop.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Damien Riegel <damien.riegel@savoirfairelinux.com>
Cc: linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, kernel@savoirfairelinux.com

On Sat, Apr 01, 2017 at 02:57:23PM -0400, Damien Riegel wrote:
> On Sat, Apr 01, 2017 at 11:06:07AM -0700, Dmitry Torokhov wrote:
> > On Sat, Apr 01, 2017 at 01:51:27PM -0400, Damien Riegel wrote:
> > > On Sat, Apr 01, 2017 at 09:54:09AM -0700, Dmitry Torokhov wrote:
> > > > On Fri, Mar 31, 2017 at 12:15:34PM -0400, Damien Riegel wrote:
> > > > > The driver uses a hardcoded value for the register, so the parameter set
> > > > > in the device tree is not actually used.
> > > > > 
> > > > > Cc: Rob Herring <robh+dt@kernel.org>
> > > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > > Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt
> > > > > index 4ed467b1e402..86ce95fc6cf8 100644
> > > > > --- a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt
> > > > > +++ b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt
> > > > > @@ -12,7 +12,8 @@ PROPERTIES
> > > > >  - reg:
> > > > >  	Usage: required
> > > > >  	Value type: <prop-encoded-array>
> > > > > -	Definition: address of vibration control register
> > > > > +	Definition: address of vibration control register. This value is
> > > > > +		    actually ignored and hardcoded in the driver to value 0x4a
> > > > 
> > > > I do not think we need to commit that the value is hard coded, it is
> > > > implementation detail of current version of Linux driver, whereas DT
> > > > bindings should be independent of OS as much as reasonably possible.
> > > > 
> > > > Also, I think you can change the code to actually read and use it from
> > > > DT to support your other device use case.
> > > 
> > > I was hesitant to do that because that might break stuff for people who
> > > use a device tree with reg != 0x4a, but if you tell me that's okay I'll
> > > send a v2 that reads device tree for all pm8xxx vibrators.
> > 
> > Actually, I was looking at the rest of the code and I now I wonder if we
> > should be doing this for any of the devices. The registers are
> > chip-specific and we get chip data from compatible string, so the driver
> > is fine to simply use static mappings. It is only if we start using a
> > common compatible string for different chips we would need to start
> > parsing DT data.
> 
> I agree that for now, it's chip-specific and storing the base address as
> DT data instead of static data doesn't bring much. But on the other
> hand, using DT data makes us consistent with the other PMIC IPs' drivers
> and future-ready if they ever decide to reuse the same IP at a different
> offset in another chip.
> 
> Anyway I'm fine with both ways, just let me know which one you prefer
> and I'll do it that way.

I think to keep with the current structure of the driver I'd prefer
using compatible property to fetch a structure describing chip's
registers instead of fetching it from device tree.

Thanks.

-- 
Dmitry
