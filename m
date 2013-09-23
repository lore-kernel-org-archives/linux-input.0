From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH 1/9] Staging/iio/adc/touchscreen/MXS: add proper clock
 handling
Date: Mon, 23 Sep 2013 12:13:03 -0300
Message-ID: <52405A7F.1050801@freescale.com>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
 <1379946998-23041-2-git-send-email-jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1379946998-23041-2-git-send-email-jbe@pengutronix.de>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Juergen Beisert <jbe@pengutronix.de>, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, marex@denx.de, jic23@cam.ac.uk, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 09/23/2013 11:36 AM, Juergen Beisert wrote:

> +	lradc->clk = devm_clk_get(&pdev->dev, NULL);
> +	clk_prepare_enable(lradc->clk);

clk_prepare_enable() may fail, so better check its return value.
