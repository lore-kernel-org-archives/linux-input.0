From: daoguang wu <wdgvip@gmail.com>
Subject: Re: [PATCH] INPUT:Add ABS_PRESSURE input event support for
	touchscreen driver
Date: Mon, 27 Jun 2011 10:15:05 +0800
Message-ID: <BANLkTi=O44wyaFB_B83LGiQhAVtFOp64pyhMaCKCf_YZz6b1GA@mail.gmail.com>
References: <1308881738-6392-1-git-send-email-wdgvip@gmail.com>
	<20110624124154.GC19804@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110624124154.GC19804@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: kgene.kim@samsung.com, ben-linux@fluff.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, wdgvip@gamil.com, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

2011/6/24 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Fri, Jun 24, 2011 at 10:15:38AM +0800, Wu DaoGuang wrote:
>> The touchscreen driver s3c2410_ts.c doesn't work well when using
>> the tslib, an abstraction layer for touchscreen panel events.
>> Tslib needs ABS_X ABS_Y and ABS_PRESSURE events to report, but only
>> the former two the driver can provide.
>
> It seems much more sane to fix this in tslib, the kernel is not actually
> reporting pressure meaningfully here and there's already BTN_TOUCH to
> report if the pen is down.
>
yeah,I will try to fix it in tslib.
Thanks a lot.
