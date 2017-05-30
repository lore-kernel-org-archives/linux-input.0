From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 2/2] Input: pm8941-pwrkey: Introduce reboot mode support
Date: Mon, 29 May 2017 21:47:11 -0700
Message-ID: <20170530044711.GP12920@tuxbook>
References: <20170527065130.3456-1-bjorn.andersson@linaro.org>
 <20170527065130.3456-2-bjorn.andersson@linaro.org>
 <20170530025324.GD32841@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170530025324.GD32841@dtor-ws>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, John Stultz <john.stultz@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon 29 May 19:53 PDT 2017, Dmitry Torokhov wrote:

> On Fri, May 26, 2017 at 11:51:30PM -0700, Bjorn Andersson wrote:
> > In some Qualcomm platforms the magic for informing LK which mode to
> > reboot into is stored in the PON_SOFT_RB_SPARE register. Register with
> > the reboot mode helpers to expose this to the user.
> 
> Hmm, is the power key driver the best place to have this? WHy isn't this
> a driver in its own right?
> 

The functionality is part of the "PON" block in the Qualcomm PMICs,
other functionality from this block relates to configuration and
handling related to power-key and reset-key.

Several of these properties are intermingled, so I do believe it's best
to handle them in a single driver; that said, it might no longer be
correct to name the driver "pwrkey" or that it is a "misc input" driver.

Regards,
Bjorn
