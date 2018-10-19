From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: pm8941-pwrkey - Add pms405 pwrkey support
Date: Thu, 18 Oct 2018 17:01:16 -0700
Message-ID: <20181019000116.GD210757@dtor-ws>
References: <20180920014928.15422-1-bjorn.andersson@linaro.org>
 <20181018052437.GW2400@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181018052437.GW2400@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Oct 18, 2018 at 10:54:37AM +0530, Vinod wrote:
> On 19-09-18, 18:49, Bjorn Andersson wrote:
> > From: Vinod Koul <vkoul@kernel.org>
> > 
> > Update the binding and driver for pms405 pwrkey.
> 
> Rob, Dmitry
> 
> Gentle reminder for this patch...
> 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt | 1 +
> >  drivers/input/misc/pm8941-pwrkey.c                             | 1 +
> >  2 files changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
> > index 34ab5763f494..736fba3bad54 100644
> > --- a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
> > +++ b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
> > @@ -8,6 +8,7 @@ PROPERTIES
> >  	Definition: must be one of:
> >  		    "qcom,pm8941-pwrkey"
> >  		    "qcom,pm8941-resin"
> > +		    "qcom,pms405-pwrkey"
> >  
> >  - reg:
> >  	Usage: required
> > diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
> > index 48153e0ca19a..fccf63263c1c 100644
> > --- a/drivers/input/misc/pm8941-pwrkey.c
> > +++ b/drivers/input/misc/pm8941-pwrkey.c
> > @@ -317,6 +317,7 @@ static const struct pm8941_data resin_data = {
> >  static const struct of_device_id pm8941_pwr_key_id_table[] = {
> >  	{ .compatible = "qcom,pm8941-pwrkey", .data = &pwrkey_data },
> >  	{ .compatible = "qcom,pm8941-resin", .data = &resin_data },
> > +	{ .compatible = "qcom,pms405-pwrkey", .data = &pwrkey_data },

I am sure I asked this question before (in context of a different
driver), but why do we need this compatible if we already have
pm8941-pwrkey compatible? Isn't pms405-pwrkey compatible with
pm8941-pwrkey as far as power key block goes? In which cases do we need
new compatibles and when can we reuse existing ones? Rob?

Thanks.

-- 
Dmitry
