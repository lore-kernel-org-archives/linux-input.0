From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Input: pmic8xxx-pwrkey - Support shutdown
Date: Fri, 17 Jul 2015 15:36:48 -0700
Message-ID: <20150717223648.GE39282@dtor-ws>
References: <1436900724-10994-1-git-send-email-sboyd@codeaurora.org>
 <20150714201852.GB32767@usrtlx11787.corpusers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150714201852.GB32767@usrtlx11787.corpusers.net>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Jul 14, 2015 at 01:18:52PM -0700, Bjorn Andersson wrote:
> On Tue 14 Jul 12:05 PDT 2015, Stephen Boyd wrote:
> 
> > On pm8xxx PMICs, shutdown and restart are signaled to the PMIC
> > via a pin called PS_HOLD. When this pin goes low, the PMIC
> > performs a configurable power sequence. Add a .shutdown hook so
> > that we can properly configure this power sequence for shutdown
> > or restart depending on the system state.
> > 
> > Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> > 
> > Changes since v2:
> >  * s/ret/error/
> >  * Use of_device_get_match_data() and don't move match table
> >  * Fix whitespace errors
> > 
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> 
> And thanks for finding of_device_get_match_data()

Thanks, I'll apply when I sync with mainline and pull in
of_device_get_match_data(). Shout if you do not see it in next in a
week.

Thanks.

-- 
Dmitry
