From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 1/2] ARM: dts: imx6: make edt-ft5x06 a wakeup source for
 imx6 boards
Date: Mon, 11 Jun 2018 15:42:23 +0800
Message-ID: <20180611074222.GE16091@dragon>
References: <20180523083013.7570-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180523083013.7570-1-daniel@zonque.org>
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

On Wed, May 23, 2018 at 10:30:12AM +0200, Daniel Mack wrote:
> The touchscreen driver no longer configures the device as wakeup source by
> default. A "wakeup-source" property is needed.
> 
> Signed-off-by: Daniel Mack <daniel@zonque.org>

Applied, thanks.
