From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Subject: Re: [PATCH] ARM: S3C64XX: Add s3c64xx support to touchscreen driver
Date: Mon, 28 Jun 2010 23:11:11 +0200
Message-ID: <4C290FEF.5040405@gmail.com>
References: <4BE290E5.9050703@gmail.com> <20100507004030.GX2589@trinity.fluff.org> <20100628183041.GC7427@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20100628183041.GC7427@core.coreip.homeip.net>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, arnaud.patard@rtp-net.org
List-Id: linux-input@vger.kernel.org

 Op 28-06-10 20:30, Dmitry Torokhov schreef:
> On Fri, May 07, 2010 at 01:40:30AM +0100, Ben Dooks wrote:
>> On Thu, May 06, 2010 at 11:50:29AM +0200, Maurus Cuelenaere wrote:
>>> Add support for the s3c64xx touchscreen to the s3c2410_ts driver,
>>> ensuring it compiles and supports the extra features such as the
>>> interrupt generation.
>>>
>>> Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
>> Acked-by: Ben Dooks <ben-linux@fluff.org>
> Hmm, it looks like I slept on th epatch for too long. Is it still
> needed? Could you please rebase it against 2.6.35-rc*?
>
> Thanks!

This was superseded by "Input: s3c24xx_ts - Add FEAT for Samsung touchscreen support" which is already in Linus' tree AFAICR.

So you can drop this.

-- 
Maurus Cuelenaere
