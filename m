From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] iio: exynos-adc: add experimental touchscreen support
Date: Mon, 21 Jul 2014 17:11:27 +0200
Message-ID: <6569004.FG0IRy8WyL@wuerfel>
References: <1405663186-26464-1-git-send-email-cw00.choi@samsung.com>
 <5158672.dMAnnUQc7Z@wuerfel> <20140721144442.GB9112@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140721144442.GB9112@core.coreip.homeip.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, kgene.kim@samsung.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux-iio@vger.kernel.org, t.figa@samsung.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, kyungmin.park@samsung.com, robh+dt@kernel.org, rdunlap@infradead.org, Ben Dooks <ben-linux@fluff.org>, galak@codeaurora.org, ch.naveen@samsung.com, linux-input <linux-input@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, heiko.stuebner@bq.com
List-Id: linux-input@vger.kernel.org

On Monday 21 July 2014 07:44:42 Dmitry Torokhov wrote:
> > > 
> > > It would be nice to actually close the device even if someone is
> > > touching screen. Please implement open/close methods and have them set a
> > > flag that you would check here.
> > 
> > Ok. I think it's even better to move the request_irq() into the open function,
> > which will avoid the flag and defer the error handling into the actual opening,
> > as well as syncing the running irq with the close function.
> 
> I do not quite like acquiring resources needed in open. I think drivers should
> do all resource acquisition in probe() and leave open()/close() to
> activate/quiesce devices.

Ok, I'll move it back then. I'm not sure what I'm supposed to do
in open/close then. Isn't it enough to check info->input->users
like this?

static irqreturn_t exynos_ts_isr(int irq, void *dev_id)
{
        struct exynos_adc *info = dev_id;
        struct iio_dev *dev = dev_get_drvdata(info->dev);
        u32 x, y;
        bool pressed;
        int ret;

        while (info->input->users) {
                ret = exynos_read_s3c64xx_ts(dev, &x, &y);
                if (ret == -ETIMEDOUT)
                        break;

                pressed = x & y & ADC_DATX_PRESSED;
                if (!pressed) {
                        input_report_key(info->input, BTN_TOUCH, 0);
                        input_sync(info->input);
                        break;
                }

                input_report_abs(info->input, ABS_X, x & ADC_DATX_MASK);
                input_report_abs(info->input, ABS_Y, y & ADC_DATY_MASK);
                input_report_key(info->input, BTN_TOUCH, 1);
                input_sync(info->input);

                msleep(1);
        };

        writel(0, ADC_V1_CLRINTPNDNUP(info->regs));

        return IRQ_HANDLED;
}

I could do enable_irq()/disable_irq(), but that leaves a small
race at startup where we request the irq line and then immediately
disable it again.

	Arnd
