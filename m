From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 2/6] MFD: twl6040: Cache the vibra
	control registers
Date: Tue, 11 Oct 2011 15:48:24 +0100
Message-ID: <20111011144824.GE1098@sirena.org.uk>
References: <1316760584-27426-1-git-send-email-peter.ujfalusi@ti.com>
	<1316760584-27426-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1316760584-27426-3-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Dmitry Torokhov <dtor@mail.ru>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Samuel Ortiz <samuel.ortiz@intel.com>, Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@ti.com>
List-Id: linux-input@vger.kernel.org

On Fri, Sep 23, 2011 at 09:49:40AM +0300, Peter Ujfalusi wrote:
> The vibra control register will be used from the ASoC codec driver as well.
> In order to avoid latency issues caused by I2C read access, cache the two
> control register within the core driver, so we do not need to reach out
> to the chip to read it back.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

It strikes me that it might be useful to just convert the driver to
regmap and get cache for everything...

Anyway, could you please restructure this series to minimize the
dependency on the input subsystem?  Then we can get the rest of it
applied.
