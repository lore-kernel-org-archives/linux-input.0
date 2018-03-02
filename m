From: Claudiu Beznea <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH v3 05/10] pwm: add PWM mode to pwm_config()
Date: Fri, 2 Mar 2018 11:19:43 +0200
Message-ID: <0c3fc3ba-8640-0b2c-a9ec-ab848227c92d@microchip.com>
References: <1519300881-8136-1-git-send-email-claudiu.beznea@microchip.com>
 <1519300881-8136-6-git-send-email-claudiu.beznea@microchip.com>
 <20180228194429.GD22932@mithrandir>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180228194429.GD22932@mithrandir>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: mark.rutland@arm.com, milo.kim@ti.com, linux-fbdev@vger.kernel.org, sean@mess.org, devicetree@vger.kernel.org, airlied@linux.ie, mturquette@baylibre.com, joonas.lahtinen@linux.intel.com, kamil@wypas.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, alexandre.belloni@free-electrons.com, pavel@ucw.cz, lee.jones@linaro.org, linux-clk@vger.kernel.org, linux-leds@vger.kernel.org, daniel.thompson@linaro.org, linux-samsung-soc@vger.kernel.org, shc_work@mail.ru, corbet@lwn.net, linux-doc@vger.kernel.org, linux@armlinux.org.uk, krzk@kernel.org, kgene@kernel.org, linux-input@vger.kernel.org, linux@roeck-us.net, linux-media@vger.kernel.org, linux-pwm@vger.kernel.org, jdelvare@suse.com, b.zolnierkie@samsung.com, intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com, robh+dt@kernel.org, jacek.anaszewski@gmail.com, rodrigo.vivi@intel.com, mchehab@kernel.orgl
List-Id: linux-input@vger.kernel.org



On 28.02.2018 21:44, Thierry Reding wrote:
> On Thu, Feb 22, 2018 at 02:01:16PM +0200, Claudiu Beznea wrote:
>> Add PWM mode to pwm_config() function. The drivers which uses pwm_config()
>> were adapted to this change.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>> ---
>>  arch/arm/mach-s3c24xx/mach-rx1950.c  | 11 +++++++++--
>>  drivers/bus/ts-nbus.c                |  2 +-
>>  drivers/clk/clk-pwm.c                |  3 ++-
>>  drivers/gpu/drm/i915/intel_panel.c   | 17 ++++++++++++++---
>>  drivers/hwmon/pwm-fan.c              |  2 +-
>>  drivers/input/misc/max77693-haptic.c |  2 +-
>>  drivers/input/misc/max8997_haptic.c  |  6 +++++-
>>  drivers/leds/leds-pwm.c              |  5 ++++-
>>  drivers/media/rc/ir-rx51.c           |  5 ++++-
>>  drivers/media/rc/pwm-ir-tx.c         |  5 ++++-
>>  drivers/video/backlight/lm3630a_bl.c |  4 +++-
>>  drivers/video/backlight/lp855x_bl.c  |  4 +++-
>>  drivers/video/backlight/lp8788_bl.c  |  5 ++++-
>>  drivers/video/backlight/pwm_bl.c     | 11 +++++++++--
>>  drivers/video/fbdev/ssd1307fb.c      |  3 ++-
>>  include/linux/pwm.h                  |  6 ++++--
>>  16 files changed, 70 insertions(+), 21 deletions(-)
> 
> I don't think it makes sense to leak mode support into the legacy API.
> The pwm_config() function is considered legacy
I missed this aspect.

 and should eventually go
> away. As such it doesn't make sense to integrate a new feature such as
> PWM modes into it. 
Agree.

All users of pwm_config() assume normal mode, and
> that's what pwm_config() should provide.
Agree.

> 
> Anyone that needs something other than normal mode should use the new
> atomic PWM API.
Agree.

> 
> Thierry
> 
