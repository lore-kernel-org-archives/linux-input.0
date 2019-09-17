From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH RESEND V5 1/5] dt-bindings: fsl: scu: add scu key binding
Date: Tue, 17 Sep 2019 09:37:16 -0500
Message-ID: <20190917143716.GA23562@bogus>
References: <1568689939-8871-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1568689939-8871-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <Anson.Huang@nxp.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com, will@kernel.org, dmitry.torokhov@gmail.com, aisheng.dong@nxp.com, ulf.hansson@linaro.org, fugang.duan@nxp.com, peng.fan@nxp.com, leonard.crestez@nxp.com, daniel.baluta@nxp.com, olof@lixom.net, mripard@kernel.org, arnd@arndb.de, jagan@amarulasolutions.com, dinguyen@kernel.org, bjorn.andersson@linaro.org, marcin.juszkiewicz@linaro.org, andriy.shevchenko@linux.intel.com, yuehaibing@huawei.com, cw00.choi@samsung.com, enric.balletbo@collabora.com, m.felsch@pengutronix.de, ping.bai@nxp.com, ronald@innovation.ch, stefan@agner.ch, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@
List-Id: linux-input@vger.kernel.org

On Tue, 17 Sep 2019 11:12:15 +0800, Anson Huang wrote:
> NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
> system controller, the system controller is in charge of system
> power, clock and scu key event etc. management, Linux kernel has
> to communicate with system controller via MU (message unit) IPC
> to get scu key event, add binding doc for i.MX system controller
> key driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No changes.
> ---
>  .../devicetree/bindings/arm/freescale/fsl,scu.txt          | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
