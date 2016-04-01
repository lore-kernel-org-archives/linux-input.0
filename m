From: Kamil Debski <k.debski@samsung.com>
Subject: RE: [PATCH v5 08/46] hwmon: pwm-fan: use pwm_get_args() where
 appropriate
Date: Fri, 01 Apr 2016 10:29:57 +0200
Message-ID: <00e701d18bf0$ade6efe0$09b4cfa0$@samsung.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-9-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1459368249-13241-9-git-send-email-boris.brezillon@free-electrons.com>
Content-language: pl
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: 'Boris Brezillon' <boris.brezillon@free-electrons.com>, 'Thierry Reding' <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: 'Milo Kim' <milo.kim@ti.com>, linux-fbdev@vger.kernel.org, 'Heiko Stuebner' <heiko@sntech.de>, linux-doc@vger.kernel.org, 'David Airlie' <airlied@linux.ie>, 'Mike Turquette' <mturquette@baylibre.com>, 'Krzysztof Kozlowski' <k.kozlowski@samsung.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, 'Alexandre Belloni' <alexandre.belloni@free-electrons.com>, 'Daniel Vetter' <daniel.vetter@intel.com>, 'Lee Jones' <lee.jones@linaro.org>, linux-clk@vger.kernel.org, linux-leds@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 'Alexander Shiyan' <shc_work@mail.ru>, 'Jonathan Corbet' <corbet@lwn.net>, 'Robert Jarzmik' <robert.jarzmik@free.fr>, lm-sensors@lm-sensors.org, linux-rockchip@lists.infradead.org, 'Chen-Yu Tsai' <wens@csie.org>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, linux-input@vger.kernel.org, 'Jean-Christophe
List-Id: linux-input@vger.kernel.org

Hi Boris,

From: Boris Brezillon [mailto:boris.brezillon@free-electrons.com]
Sent: Wednesday, March 30, 2016 10:04 PM
Subject: [PATCH v5 08/46] hwmon: pwm-fan: use pwm_get_args() where
appropriate
> 
> The PWM framework has clarified the concept of reference PWM config (the
> platform dependent config retrieved from the DT or the PWM lookup table)
> and real PWM state.
> 
> Use pwm_get_args() when the PWM user wants to retrieve this reference
> config and not the current state.
> 
> This is part of the rework allowing the PWM framework to support hardware
> readout and expose real PWM state even when the PWM has just been
> requested (before the user calls pwm_config/enable/disable()).
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Acked-by: Kamil Debski <k.debski@samsung.com>

Best wishes,
-- 
Kamil Debski
Samsung R&D Institute Poland
