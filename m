From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v3] ARM: pxa: magician: Add support for ADS7846 touchscreen
Date: Fri, 17 Mar 2017 08:14:43 +0100
Message-ID: <87wpbofk7w.fsf@belgarion.home>
References: <bca1b7cc-e4d6-d101-0591-61694c07bfd8@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <bca1b7cc-e4d6-d101-0591-61694c07bfd8@tul.cz> (Petr Cvek's
 message of "Mon, 13 Mar 2017 09:05:49 +0100")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Petr Cvek <petr.cvek@tul.cz>, philipp.zabel@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, haojian.zhuang@gmail.com, daniel@zonque.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Petr Cvek <petr.cvek@tul.cz> writes:

> This patch adds a support for ADS7846 touchscreen driver.
>
> The basic functionality was tested, x_plate_ohms and y_plate_ohms were
> physically measured. The value pressure_max was empirically set to match
> the measured range, which is affected by x_plate_ohms and ADS samples.
>
> The value of keep_vref_on should be set. A tested model (T-Mobile MDA
> Compact PM10A) doesn't seem to use Vref pin as the input from an external
> source. On this model the unset keep_vref_on cause high jitter of measured
> values.
>
> SPI framing pin (gpio_cs) must be used in GPIO mode due to an incompatible
> autoframing of PXA27x controller and ADS7846 device.
>
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
Applied to pxa/for-next, unless Philipp objects in the next couple of days,
thanks.

Cheers.

--
Robert
