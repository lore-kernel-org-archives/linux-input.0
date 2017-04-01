From: Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: Re: [PATCH 2/6] Input: pm8xxx-vib: sync device tree bindings doc
 with the driver
Date: Sat, 1 Apr 2017 13:51:27 -0400
Message-ID: <20170401175127.3nt5gujkvgyoh2tc@workotop.localdomain>
References: <20170331161538.11657-1-damien.riegel@savoirfairelinux.com>
 <20170331161538.11657-2-damien.riegel@savoirfairelinux.com>
 <20170401165409.GE17130@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:45298 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751798AbdDARwG (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 1 Apr 2017 13:52:06 -0400
Content-Disposition: inline
In-Reply-To: <20170401165409.GE17130@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, kernel@savoirfairelinux.com

On Sat, Apr 01, 2017 at 09:54:09AM -0700, Dmitry Torokhov wrote:
> On Fri, Mar 31, 2017 at 12:15:34PM -0400, Damien Riegel wrote:
> > The driver uses a hardcoded value for the register, so the parameter set
> > in the device tree is not actually used.
> > 
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> > ---
> >  Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt
> > index 4ed467b1e402..86ce95fc6cf8 100644
> > --- a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt
> > +++ b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt
> > @@ -12,7 +12,8 @@ PROPERTIES
> >  - reg:
> >  	Usage: required
> >  	Value type: <prop-encoded-array>
> > -	Definition: address of vibration control register
> > +	Definition: address of vibration control register. This value is
> > +		    actually ignored and hardcoded in the driver to value 0x4a
> 
> I do not think we need to commit that the value is hard coded, it is
> implementation detail of current version of Linux driver, whereas DT
> bindings should be independent of OS as much as reasonably possible.
> 
> Also, I think you can change the code to actually read and use it from
> DT to support your other device use case.

I was hesitant to do that because that might break stuff for people who
use a device tree with reg != 0x4a, but if you tell me that's okay I'll
send a v2 that reads device tree for all pm8xxx vibrators.

Thanks,
-- 
Damien
