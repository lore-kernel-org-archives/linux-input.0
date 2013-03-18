From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 10/10] drivers: misc: use module_platform_driver_probe()
Date: Mon, 18 Mar 2013 10:58:51 +0000
Message-ID: <201303181058.51641.arnd@arndb.de>
References: <1363266691-15757-1-git-send-email-fabio.porcedda@gmail.com>
 <201303152018.09094.arnd@arndb.de>
 <CAHkwnC9YFTw8gVzyZB3_gZCgM5zMA6tLch15EDqcA2F4CAOpAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAHkwnC9YFTw8gVzyZB3_gZCgM5zMA6tLch15EDqcA2F4CAOpAQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Grant Likely <grant.likely@secretlab.ca>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, H Hartley Sweeten <hartleys@visionengravers.com>, Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Monday 18 March 2013, Fabio Porcedda wrote:
> Since by using platform_driver_probe() the  function
> ep93xx_pwm_probe() is freed after initialization,
> is better to use module_platform_drive_probe().
> IMHO i don't see any good reason to use module_platform_driver() for
> this driver.

As I commented earlier, the platform_driver_probe() and
module_platform_drive_probe() interfaces are rather dangerous in combination
with deferred probing, I would much prefer Harley's patch.

	Arnd
