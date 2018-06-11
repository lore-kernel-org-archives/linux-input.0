From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: dts: am437x: make edt-ft5x06 a wakeup source
 for imx6 boards
Date: Mon, 11 Jun 2018 00:56:29 -0700
Message-ID: <20180611075629.GQ5738@atomide.com>
References: <20180523083013.7570-1-daniel@zonque.org>
 <20180523083013.7570-2-daniel@zonque.org>
 <20180611074420.GF16091@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180611074420.GF16091@dragon>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-input@vger.kernel.org, fabio.estevam@nxp.com, Daniel Mack <daniel@zonque.org>
List-Id: linux-input@vger.kernel.org

* Shawn Guo <shawnguo@kernel.org> [180611 07:47]:
> On Wed, May 23, 2018 at 10:30:13AM +0200, Daniel Mack wrote:
> > The touchscreen driver no longer configures the device as wakeup source by
> > default. A "wakeup-source" property is needed.
> > 
> > Signed-off-by: Daniel Mack <daniel@zonque.org>
> 
> This is not an imx6 board, and I have to leave it to relevant platform
> maintainer.  The patch subject should be fixed to drop 'imx6'.

Daniel, can you please resend after -rc1?

Thanks,

Tony
