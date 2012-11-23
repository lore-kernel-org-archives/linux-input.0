From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 230/493] input: remove use of __devinit
Date: Fri, 23 Nov 2012 04:01:00 +0100
Message-ID: <CABxcv==MXEgRpExxDm_Cx4D5bxm5fPR80_2PiU-vzAwcgu31QA@mail.gmail.com>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
	<1353349642-3677-230-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1353349642-3677-230-git-send-email-wfp5p@virginia.edu>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: gregkh@linuxfoundation.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wan ZongShun <mcuos.com@gmail.com>, Miloslav Trmac <mitr@volny.cz>, Russell King <linux@arm.linux.org.uk>, Pau Oliva Fora <pof@eslack.org>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, linux-input@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, linux-arm-kernel@lists.infradead.org, patches@opensource.wolfsonmicro.com, linux-samsung-soc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Nov 19, 2012 at 7:22 PM, Bill Pemberton <wfp5p@virginia.edu> wrote:
> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.
>

>  drivers/input/touchscreen/cyttsp_i2c.c      |  2 +-
>  drivers/input/touchscreen/cyttsp_spi.c      |  2 +-

For these two,

Acked-by: Javier Martinez Canillas <javier@dowhile0.org>

Thanks

Best regards,
Javier
