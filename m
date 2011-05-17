From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V3 2/2] input: pmic8xxx_pwrkey: Add support for power key
Date: Mon, 16 May 2011 23:36:51 -0700
Message-ID: <20110517063651.GE20428@core.coreip.homeip.net>
References: <1305280071-1652-1-git-send-email-aghayal@codeaurora.org>
 <1305280071-1652-2-git-send-email-aghayal@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1305280071-1652-2-git-send-email-aghayal@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Anirudh Ghayal <aghayal@codeaurora.org>
Cc: linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org, Trilok Soni <tsoni@codeaurora.org>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-input@vger.kernel.org

On Fri, May 13, 2011 at 03:17:51PM +0530, Anirudh Ghayal wrote:
> From: Trilok Soni <tsoni@codeaurora.org>
> 
> Add support for PMIC8XXX power key driven over dedicated
> KYPD_PWR_N pin.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Trilok Soni <tsoni@codeaurora.org>
> Signed-off-by: Anirudh Ghayal <aghayal@codeaurora.org>

Acked-by: Dmitry Torokhov <dtor@mail.ru>

Anirudh,

Looks great, thank you for making changes. Please feel free to merge
with the rest of the pmic8xxx MFD patches. I assume they will go through
MFD tree, right?

Thanks.

-- 
Dmitry
