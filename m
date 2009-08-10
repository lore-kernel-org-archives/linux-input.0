From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] input: PCAP2 misc input driver
Date: Sun, 9 Aug 2009 23:54:07 -0700
Message-ID: <20090810072431.D2068526EC9@mailhub.coreip.homeip.net>
References: <1249678456-15381-1-git-send-email-drwyrm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751836AbZHJGyO@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1249678456-15381-1-git-send-email-drwyrm@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Ribeiro <drwyrm@gmail.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, eric.y.miao@gmail.com, linux-arm-kernel@lists.arm.linux.org.uk, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, openezx-devel@lists.openezx.org, Ilya Petrov <ilya.muromec@gmail.com>, Antonio Ospite <ospite@studenti.unina.it>
List-Id: linux-input@vger.kernel.org

On Fri, Aug 07, 2009 at 10:54:16PM +0200, Daniel Ribeiro wrote:
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 0d979fd..679bae3 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -26,3 +26,4 @@ obj-$(CONFIG_INPUT_TWL4030_PWRBUTTON)	+= twl4030-pwrbutton.o
>  obj-$(CONFIG_INPUT_UINPUT)		+= uinput.o
>  obj-$(CONFIG_INPUT_WISTRON_BTNS)	+= wistron_btns.o
>  obj-$(CONFIG_INPUT_YEALINK)		+= yealink.o
> +obj-$(CONFIG_INPUT_PCAP)		+= pcap_keys.o

Btw, could we please keep Makefile sorted alphabetically? This should
help with merge conflicts a bit (I know Kconfig is still not sorted).

-- 
Dmitry
