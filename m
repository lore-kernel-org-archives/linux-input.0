From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Subject: Re: [PATCH] input/touchscreen: add S3C24XX SoC touchscreen input
	driver
Date: Mon, 19 Oct 2009 13:28:13 +0200
Message-ID: <4ADC4D4D.5020508@gmail.com>
References: <mailman.4020.1255949705.2256.linux-arm-kernel@lists.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <mailman.4020.1255949705.2256.linux-arm-kernel@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shine Liu <shinel@foxmail.com>
Cc: Nelson Castillo <arhuaco@freaks-unidos.net>, dtor@mail.ru, dmitry.torokhov@gmail.com, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Op 19-10-09 12:55, linux-arm-kernel-request@lists.infradead.org schreef:
> This touchscreen driver is for touchscreen controller on Samsung
> S3C2410/S3C2440 SoC chip. S3C2410/S3C2440 has the on chip touchscreen
> controller based on it's analog to digital converter(8-channel analog
> inputs, touchscreen uses 4 of them). This driver uses the exsiting S3C
> ADC driver to make the touchscreen controller of S3C2410/S3C2440 work
> well together with other ADC devices connected to the S3C24XX SoC chip.
>
> The patch is created against kernel 2.6.32-rc4 and tested with S3C2440
> SoC and Samsung LTE430WQ-F0C touchscreen.
>
>
> Signed-off-by: Shine Liu<liuxian@redflag-linux.com>
> Signed-off-by: Shine Liu<shinel@foxmail.com>
>    

Do you know that there's another patch (at Openmoko) created by Nelson 
Castillo that does the same, but also has support for kernel-space 
touchscreen filters? (I think [1] is his latest version)
I don't know how your patch performs, but according to [2] the filters 
should help a lot avoiding jitter etc.

I'm not sure whether Nelson has submitted his patches for mainline 
review yet and what the status is on the kernel filters, but IMHO doing 
some filtering in kernel space (see the "Why are we doing filtering in 
kernel space?" part of [2]) which results in a "cleaner" output is 
preferred over reporting possible "jittery" data.

Regards,
Maurus Cuelenaere


[1] 
http://nelson-patches.googlecode.com/svn/trunk/openmoko/kernel/ts-with-s3c-adc/
[2] http://wiki.openmoko.org/wiki/Touchscreen_Filters
