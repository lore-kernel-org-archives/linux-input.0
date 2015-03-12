From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [RESEND PATCH v6 09/22] mfd: ab8500: Use power_supply_*() API for
 accessing function attrs
Date: Thu, 12 Mar 2015 10:24:27 +0100
Message-ID: <1426152267.31959.1.camel@AMDC1943>
References: <1426146260-30081-1-git-send-email-k.kozlowski@samsung.com>
 <1426146260-30081-10-git-send-email-k.kozlowski@samsung.com>
 <20150312090156.GB3314@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:9304 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbbCLJYc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Mar 2015 05:24:32 -0400
In-reply-to: <20150312090156.GB3314@x1>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org

On czw, 2015-03-12 at 09:01 +0000, Lee Jones wrote:
> On Thu, 12 Mar 2015, Krzysztof Kozlowski wrote:
> 
> > Replace direct calls to power supply function attributes with wrappers.
> > Wrappers provide safe access in case of unregistering the power
> > supply (e.g. by removing the driver). Replace:
> >  - get_property -> power_supply_get_property
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Acked-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> > Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Reviewed-by: Sebastian Reichel <sre@kernel.org>
> > ---
> >  drivers/mfd/ab8500-sysctrl.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> Has the infrastructure for these been merged yet?
> 
> I.e. Can I just take them?

Previous patches were not merged yet so you cannot take it. This whole
patchset can be applied incrementally but cherry picking won't work.

Best regards,
Krzysztof


