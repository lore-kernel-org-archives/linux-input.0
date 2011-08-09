From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add device tree binding for WM8753
Date: Tue, 9 Aug 2011 23:28:52 +0900
Message-ID: <20110809142851.GA15861@opensource.wolfsonmicro.com>
References: <1312778255-29755-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<CAGsJ_4y2tDb3ZBPo8bCtrjFt0OWzR8WeG+kL_RKJPRP7-pZopw@mail.gmail.com>
	<20110809065100.GB8017@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20110809065100.GB8017@core.coreip.homeip.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Barry Song <21cnbao@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, linux-input@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: linux-input@vger.kernel.org

On Mon, Aug 08, 2011 at 11:51:00PM -0700, Dmitry Torokhov wrote:

> The issue I have with the ads7846 driver is that it still needs platform
> code to supply the needed platform data structure to make the
> driver/device usable. So I am not sure what the benefit DT matching code
> brings to that driver.

Oh, if that's the case the driver ought to have device tree bindings
which replicate the platform data.  Unless the platform data is
sufficiently obscure for hardly anyone to want to use it I guess.
