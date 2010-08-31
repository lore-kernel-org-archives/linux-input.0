From: Kevin Wells <kevin.wells@nxp.com>
Subject: RE: [PATCH] input/touch: Introduce the LPC32xx touchscreen
	controller driver (v2)
Date: Wed, 1 Sep 2010 00:46:35 +0200
Message-ID: <083DF309106F364B939360100EC290F80AD44F8E1B@eu1rdcrdc1wx030.exi.nxp.com>
References: <1281993661-21097-1-git-send-email-wellsk40@gmail.com>
	<1281993661-21097-2-git-send-email-wellsk40@gmail.com>
	<20100829054838.GC15369@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100829054838.GC15369@core.coreip.homeip.net>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "wellsk40@gmail.com" <wellsk40@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Durgesh Pattamatta <durgesh.pattamatta@nxp.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org



> Subject: Re: [PATCH] input/touch: Introduce the LPC32xx touchscreen
> controller driver (v2)
> 
> On Mon, Aug 16, 2010 at 02:21:01PM -0700, wellsk40@gmail.com wrote:
> > From: Kevin Wells <wellsk40@gmail.com>
> >
> > This patch set introduces support for the LPC32xx touchscreen
> > controller driver. The LPC32xx touchscreen controller supports
> > automated event detection and X/Y data conversion for resistive
> > touchscreens.
> >
> > Signed-off-by: Kevin Wells <wellsk40@gmail.com>
> > Signed-off-by: Durgesh Pattamatta <durgesh.pattamatta@nxp.com>
> 
> Applied to my .37 queue, thanks Kevin.
> 

Thanks for applying this Dmitry.
Ryan M also had some good comments about the v2 driver that I'll
resolve once some other associated fixes get pulled in.

> --
> Dmitry
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
