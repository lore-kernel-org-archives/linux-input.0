From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2 02/10] genirq: Add devm_request_any_context_irq()
Date: Fri, 7 Feb 2014 13:08:17 -0800
Message-ID: <20140207210816.GD12815@codeaurora.org>
References: <1388709460-19222-1-git-send-email-sboyd@codeaurora.org>
 <1388709460-19222-3-git-send-email-sboyd@codeaurora.org>
 <52CB2D29.3050107@codeaurora.org>
 <52D5A266.5000504@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52D5A266.5000504@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-msm@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 01/14, Stephen Boyd wrote:
> On 01/06/14 14:24, Stephen Boyd wrote:
> > On 01/02/14 16:37, Stephen Boyd wrote:
> >> Some drivers use request_any_context_irq() but there isn't a
> >> devm_* function for it. Add one so that these drivers don't need
> >> to explicitly free the irq on driver detach.
> >>
> >> Cc: Thomas Gleixner <tglx@linutronix.de>
> >> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > Thomas, can you please review this patch?
> 
> ping?

ping?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
