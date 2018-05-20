From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2 3/3] ARM: dts: imx28/imx53: enable edt-ft5x06 wakeup
 source
Date: Sun, 20 May 2018 21:05:30 +0800
Message-ID: <20180520130528.GC26863@dragon>
References: <20180517090552.5704-1-daniel@zonque.org>
 <20180517090552.5704-4-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180517090552.5704-4-daniel@zonque.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Mack <daniel@zonque.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, robh+dt@kernel.org, kernel@pengutronix.de, linux-input@vger.kernel.org, fabio.estevam@nxp.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Thu, May 17, 2018 at 11:05:52AM +0200, Daniel Mack wrote:
> The touchscreen driver no longer configures the device as wakeup source by
> default. A "wakeup-source" property is needed.
> 
> To avoid regressions, this patch changes the DTS files for the only two
> users of this driver that didn't have this property yet.
> 
> Signed-off-by: Daniel Mack <daniel@zonque.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Rob Herring <robh+dt@kernel.org>

Applied this one, thanks.
