From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 10/10] drivers: misc: use module_platform_driver_probe()
Date: Fri, 15 Mar 2013 11:28:48 +0000
Message-ID: <201303151128.48432.arnd@arndb.de>
References: <1363266691-15757-1-git-send-email-fabio.porcedda@gmail.com>
 <20130314140631.GM1906@pengutronix.de>
 <CAHkwnC9nGsdgOTQZ6VpeDyPWXw7tpP+2oHvnLv6LEr1cNdnrsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAHkwnC9nGsdgOTQZ6VpeDyPWXw7tpP+2oHvnLv6LEr1cNdnrsg@mail.gmail.com>
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
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, H Hartley Sweeten <hsweeten@visionengravers.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org, lm-sensors <lm-sensors@lm-sensors.org>, Grant Likely <grant.likely@secretlab.ca>, linux-ide <linux-ide@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>, linux-arm-kernel@lists.infradead.org, linux-media <linux-media@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Friday 15 March 2013, Fabio Porcedda wrote:
> >> * Regarding the use of module_platform_driver_probe, I'm a little worried about
> >>   the interactions with deferred probing. I don't think there are any regressions,
> >>   but we should probably make people aware that one cannot return -EPROBE_DEFER
> >>   from a platform_driver_probe function.
> 
> The use of module_platform_driver_probe() doesn't change anything about that,
> it's exactly the same thing as using "return platform_driver_probe()".
> I'm right or I'm missing something? Maybe are you just speaking about
> the misuse of "platform_driver_probe"?

Yes, that was what I meant. The point is that if we need to review or remove
all uses of platform_driver_probe, it would be better not to introduce a
module_platform_driver_probe() interface to make it easier to use.

	Arnd
