From: Claudiu Beznea <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH v3 05/10] pwm: add PWM mode to pwm_config()
Date: Fri, 2 Mar 2018 11:28:09 +0200
Message-ID: <585cc4ae-3674-c119-295b-e59f4242e619@microchip.com>
References: <1519300881-8136-1-git-send-email-claudiu.beznea@microchip.com>
 <1519300881-8136-6-git-send-email-claudiu.beznea@microchip.com>
 <20180228194429.GD22932@mithrandir> <87r2p4hod7.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87r2p4hod7.fsf@intel.com>
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
To: Jani Nikula <jani.nikula@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: mark.rutland@arm.com, milo.kim@ti.com, linux-fbdev@vger.kernel.org, sean@mess.org, devicetree@vger.kernel.org, airlied@linux.ie, mturquette@baylibre.com, joonas.lahtinen@linux.intel.com, kamil@wypas.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, alexandre.belloni@free-electrons.com, pavel@ucw.cz, lee.jones@linaro.org, linux-clk@vger.kernel.org, linux-leds@vger.kernel.org, daniel.thompson@linaro.org, linux-samsung-soc@vger.kernel.org, shc_work@mail.ru, corbet@lwn.net, linux-doc@vger.kernel.org, linux@armlinux.org.uk, krzk@kernel.org, kgene@kernel.org, linux-input@vger.kernel.org, linux@roeck-us.net, linux-media@vger.kernel.org, linux-pwm@vger.kernel.org, jdelvare@suse.com, b.zolnierkie@samsung.com, intel-gfx@lists.freedesktop.org, robh+dt@kernel.org, jacek.anaszewski@gmail.com, rodrigo.vivi@intel.com, mchehab@kernel.org, linux-arm-kernel@lists.infrade
List-Id: linux-input@vger.kernel.org



On 28.02.2018 22:04, Jani Nikula wrote:
> On Wed, 28 Feb 2018, Thierry Reding <thierry.reding@gmail.com> wrote:
>> Anyone that needs something other than normal mode should use the new
>> atomic PWM API.
> 
> At the risk of revealing my true ignorance, what is the new atomic PWM
> API? Where? Examples of how one would convert old code over to the new
> API?
As far as I know, the old PWM core code uses config(), set_polarity(),
enable(), disable() methods of driver, registered as pwm_ops:
struct pwm_ops {

        int (*request)(struct pwm_chip *chip, struct pwm_device *pwm);

        void (*free)(struct pwm_chip *chip, struct pwm_device *pwm);

        int (*config)(struct pwm_chip *chip, struct pwm_device *pwm,

                      int duty_ns, int period_ns);

        int (*set_polarity)(struct pwm_chip *chip, struct pwm_device *pwm,

                            enum pwm_polarity polarity);

        int (*capture)(struct pwm_chip *chip, struct pwm_device *pwm,

                       struct pwm_capture *result, unsigned long timeout);

        int (*enable)(struct pwm_chip *chip, struct pwm_device *pwm);

        void (*disable)(struct pwm_chip *chip, struct pwm_device *pwm);

        int (*apply)(struct pwm_chip *chip, struct pwm_device *pwm,

                     struct pwm_state *state);

        void (*get_state)(struct pwm_chip *chip, struct pwm_device *pwm,

                          struct pwm_state *state);

#ifdef CONFIG_DEBUG_FS

        void (*dbg_show)(struct pwm_chip *chip, struct seq_file *s);

#endif

        struct module *owner;

};


to do settings on hardware. In order to so settings on a PWM the users
should have been follow the below steps:
->config()
->set_polarity()
->enable()
Moreover, if the PWM was previously enabled it should have been first
disable and then to follow the above steps in order to apply a new settings
on hardware.
The driver should have been provide, at probe, all the above function:
->config(), ->set_polarity(), ->disable(), ->enable(), function that were
used by PWM core.

Now, having atomic PWM, the driver should provide one function to PWM core,
which is ->apply() function. Every PWM has a state associated, which keeps
the period, duty cycle, polarity and enable/disable status. The driver's
->apply() function takes as argument the state that should be applied and
it takes care of applying this new state directly without asking user to
call ->disable(), then ->config()/->set_polarity(), then ->enable() to
apply new hardware settings.

The PWM consumer could set a new state for PWM it uses, using
pwm_apply_state(pwm, new_state);

Regarding the models to switch on atomic PWM, on the controller side you
can check for drivers that registers apply function at probe time.
Regarding the PWM users, you can look for pwm_apply_state()
(drivers/hwmon/pwm-fan.c or drivers/input/misc/pwm-beeper.c are some examples).

Thierry, please correct me if I'm wrong.

Thank you,
Claudiu Beznea

> 
> BR,
> Jani.
> 
