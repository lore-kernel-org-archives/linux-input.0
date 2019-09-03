From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V3 1/5] dt-bindings: fsl: scu: add scu key binding
Date: Tue, 3 Sep 2019 19:01:19 +0100
Message-ID: <20190903180119.GA5856@bogus>
References: <1567546600-21566-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1567546600-21566-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <Anson.Huang@nxp.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com, will@kernel.org, dmitry.torokhov@gmail.com, aisheng.dong@nxp.com, ulf.hansson@linaro.org, fugang.duan@nxp.com, peng.fan@nxp.com, daniel.baluta@nxp.com, leonard.crestez@nxp.com, mripard@kernel.org, olof@lixom.net, arnd@arndb.de, jagan@amarulasolutions.com, bjorn.andersson@linaro.org, dinguyen@kernel.org, marcin.juszkiewicz@linaro.org, stefan@agner.ch, gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com, yuehaibing@huawei.com, tglx@linutronix.de, ronald@innovation.ch, m.felsch@pengutronix.de, ping.bai@nxp.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.
List-Id: linux-input@vger.kernel.org

On Tue,  3 Sep 2019 17:36:36 -0400, Anson Huang wrote:
> NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
> system controller, the system controller is in charge of system
> power, clock and scu key event etc. management, Linux kernel has
> to communicate with system controller via MU (message unit) IPC
> to get scu key event, add binding doc for i.MX system controller
> key driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V2:
> 	- use "key" instead of "pwrkey" as the key function can be defined in DT.
> ---
>  .../devicetree/bindings/arm/freescale/fsl,scu.txt          | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
