From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 2/3] thinkpad_acpi: Support micmute LED
Date: Fri, 23 Aug 2013 15:16:42 -0300
Message-ID: <20130823181642.GA27893@khazad-dum.debian.net>
References: <1377180132-4933-1-git-send-email-Jason@zx2c4.com>
 <1377180132-4933-2-git-send-email-Jason@zx2c4.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1377180132-4933-2-git-send-email-Jason@zx2c4.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, mjg@redhat.com, rjw@sisk.pl, len.brown@intel.com, dtor@insightbb.com
List-Id: linux-input@vger.kernel.org

Hi Jason!

On Thu, 22 Aug 2013, Jason A. Donenfeld wrote:

> The micmute LED is currently unused. This patch allows it to be hooked
> up to various LED triggers.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/platform/x86/thinkpad_acpi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 54d31c0..33b23cb 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -5050,8 +5050,10 @@ static const char * const tpacpi_led_names[TPACPI_LED_NUMLEDS] = {
>  	"tpacpi::unknown_led2",
>  	"tpacpi::unknown_led3",
>  	"tpacpi::thinkvantage",
> +	"tpacpi::unknown_led4",
> +	"tpacpi::micmute"
>  };
> -#define TPACPI_SAFE_LEDS	0x1081U
> +#define TPACPI_SAFE_LEDS	0x5081U

Micmute is not a "safe" LED by thinkpad-acpi's definition.

Besides, I want to see that LED hooked to alsa, any other use should be
protected by a module parameter (like fan-control is) or kernel config (like
unsafe LEDs are).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
