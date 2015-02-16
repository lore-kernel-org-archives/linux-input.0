From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: [PATCH v2 0/2] Qualcomm PM8941 power key driver
Date: Mon, 16 Feb 2015 11:55:16 +0200
Message-ID: <1424080516.2328.1.camel@mm-sol.com>
References: <1422058747-13486-1-git-send-email-bjorn.andersson@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ns.mm-sol.com ([37.157.136.199]:56358 "EHLO extserv.mm-sol.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754049AbbBPJzV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Feb 2015 04:55:21 -0500
In-Reply-To: <1422058747-13486-1-git-send-email-bjorn.andersson@sonymobile.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org


On Fri, 2015-01-23 at 16:19 -0800, Bjorn Andersson wrote:
> These patches add dt bindings and a device driver for the power key block in
> the Qualcomm PM8941 pmic.
> 
> Changes since v1:
>  * Use a reboot_notifier to set power off/reboot mode
>  * Use irq flags from devicetree
>  * Some style fixes
> 
> Courtney Cavin (2):
>   input: Add Qualcomm PM8941 power key driver
>   input: pm8941-pwrkey: Add DT binding documentation

Tested-by: Ivan T. Ivanov <iivanov@mm-sol.com>

Thanks.

> 
>  .../bindings/input/qcom,pm8941-pwrkey.txt          |  43 ++++
>  drivers/input/misc/Kconfig                         |  12 +
>  drivers/input/misc/Makefile                        |   1 +
>  drivers/input/misc/pm8941-pwrkey.c                 | 281 +++++++++++++++++++++
>  4 files changed, 337 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
>  create mode 100644 drivers/input/misc/pm8941-pwrkey.c
> 
> 
