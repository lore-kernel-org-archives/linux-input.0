From: "Chris Verges" <chrisv-TDbMi1wZJFNf2ZY+IB7+a9BPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3] input/misc: new ADXL345/346
	driver
Date: Tue, 20 Oct 2009 11:46:08 -0700
Message-ID: <68FBE0F3CE97264395875AC1C468F22C1CA0D8@mail03.cyberswitching.local>
References: <1255517680-30733-1-git-send-email-vapier@gentoo.org>
	<1256028039-15044-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, Barry Song <barry.song-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Mike and Michael,

>+config INPUT_ADXL34X
>+config INPUT_ADXL34X_I2C
>+config INPUT_ADXL34X_SPI

Should the INPUT_ADXL34X option be auto-selected when the _I2C or _SPI
counterparts are selected?  Something like:

config HAVE_INPUT_ADXL34X

config INPUT_ADXL34X
	depends on HAVE_INPUT_ADXL34X

config INPUT_ADXL34X_I2C
	bool "..."
	depends on I2C
	select HAVE_INPUT_ADXL34X

config INPUT_ADXL34X_SPI
	bool "..."
	depends on SPI_MASTER
	select HAVE_INPUT_ADXL34X

The end user would only see the INPUT_ADXL34X_SPI and INPUT_ADXL34X_I2C
options, with the common INPUT_ADXL34X option being automagically
selected due to the reverse dependencies.

Chris
