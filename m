From: Claudiu Beznea <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH v3 06/10] pwm: add PWM modes
Date: Thu, 22 Feb 2018 19:42:29 +0200
Message-ID: <e5090740-520a-34c0-6b52-09cc8ada11b1@microchip.com>
References: <1519300881-8136-1-git-send-email-claudiu.beznea@microchip.com>
 <1519300881-8136-7-git-send-email-claudiu.beznea@microchip.com>
 <CAHp75Ver6GuKSDooAr2DW+eqt=B3p8O+X6+rOSWNgfhHxgVqNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAHp75Ver6GuKSDooAr2DW+eqt=B3p8O+X6+rOSWNgfhHxgVqNQ@mail.gmail.com>
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
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, milo.kim@ti.com, linux-fbdev@vger.kernel.org, Sean Young <sean@mess.org>, devicetree <devicetree@vger.kernel.org>, David Airlie <airlied@linux.ie>, Michael Turquette <mturquette@baylibre.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, kamil@wypas.org, dri-devel@lists.freedesktop.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org, Linux LED Subsystem <linux-leds@vger.kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>, linux-samsung-soc@vger.kernel.org, Alexander Shiyan <shc_work@mail.ru>, Jonathan Corbet <corbet@lwn.net>, Linux Documentation List <linux-doc@vger.kernel.org>, Russell King - ARM Linux <linux@armlinux.org.>
List-Id: linux-input@vger.kernel.org



On 22.02.2018 19:28, Andy Shevchenko wrote:
> On Thu, Feb 22, 2018 at 2:01 PM, Claudiu Beznea
> <claudiu.beznea@microchip.com> wrote:
>> Add PWM normal and complementary modes.
> 
>> +- PWM_DTMODE_COMPLEMENTARY: PWM complementary working mode (for PWM
>> +channels two outputs); if not specified, the default for PWM channel will
>> +be used
> 
> What DT stands for?
It stands for Device Tree. It remained this way from the previous version. In
the previous version I had modes described in an enum, to be used by PWM core,
as follows:
enum pwm_mode {
	PWM_MODE_NORMAL,
	PWM_MODE_COMPLEMENTARY,
};

and, to avoid conflict b/w these defines and the one from
include/dt-bindings/pwm/pwm.h I introduced this DT in the define names from
dt-bindings. But now the DT might be removed since I've changed the way the PWM
mode is identified in PWM core. I will remove the DT in the next version, if not
requested otherwise.

Thank you,
Claudiu Benea
