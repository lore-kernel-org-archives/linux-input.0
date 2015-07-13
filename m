From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: Re: [PATCH v2] Input: pmic8xxx-pwrkey - Support shutdown
Date: Mon, 13 Jul 2015 16:37:50 -0700
Message-ID: <20150713233750.GA32767@usrtlx11787.corpusers.net>
References: <1436830234-28316-1-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436830234-28316-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon 13 Jul 16:30 PDT 2015, Stephen Boyd wrote:

> On pm8xxx PMICs, shutdown and restart are signaled to the PMIC
> via a pin called PS_HOLD. When this pin goes low, the PMIC
> performs a configurable power sequence. Add a .shutdown hook so
> that we can properly configure this power sequence for shutdown
> or restart depending on the system state.
> 
> Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/input/misc/pmic8xxx-pwrkey.c | 284 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 277 insertions(+), 7 deletions(-)
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Regards,
Bjorn
