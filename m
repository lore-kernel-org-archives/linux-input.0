From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 6/9] power_supply: wm97xx_battery: use
 power_supply_get_drvdata
Date: Thu, 27 Oct 2016 09:41:08 +0100
Message-ID: <20161027084108.GE28180@localhost.localdomain>
References: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
 <1477510907-23495-7-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1477510907-23495-7-git-send-email-robert.jarzmik@free.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Takashi Iwai <tiwai@suse.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Lee Jones <lee.jones@linaro.org>, Daniel Mack <daniel@zonque.org>
List-Id: linux-input@vger.kernel.org

On Wed, Oct 26, 2016 at 09:41:44PM +0200, Robert Jarzmik wrote:
> As the power supply framework provides a way to store and retrieve
> private supply data, use it.
> 
> In the process, change the platform data for wm97xx_battery from a
> container of a single struct wm97xx_batt_pdata to the direct point to wm97xx_batt_pdata.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
