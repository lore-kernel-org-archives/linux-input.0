From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 3/3] ARM: dts: imx28/imx53: enable edt-ft5x06 wakeup
 source
Date: Tue, 22 May 2018 11:20:43 -0700
Message-ID: <20180522182043.GA123708@dtor-ws>
References: <20180517090552.5704-1-daniel@zonque.org>
 <20180517090552.5704-4-daniel@zonque.org>
 <20180520130528.GC26863@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180520130528.GC26863@dragon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-input@vger.kernel.org, fabio.estevam@nxp.com, Daniel Mack <daniel@zonque.org>
List-Id: linux-input@vger.kernel.org

On Sun, May 20, 2018 at 09:05:30PM +0800, Shawn Guo wrote:
> On Thu, May 17, 2018 at 11:05:52AM +0200, Daniel Mack wrote:
> > The touchscreen driver no longer configures the device as wakeup source by
> > default. A "wakeup-source" property is needed.
> > 
> > To avoid regressions, this patch changes the DTS files for the only two
> > users of this driver that didn't have this property yet.
> > 
> > Signed-off-by: Daniel Mack <daniel@zonque.org>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> 
> Applied this one, thanks.

I think there are few more that need "wakeup-source" added:

arch/arm/boot/dts/am437x-sk-evm.dts
arch/arm/boot/dts/imx6q-var-dt6customboard.dts
arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi
arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi

Thanks.

-- 
Dmitry
