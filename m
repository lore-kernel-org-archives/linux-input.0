From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2 5/5] HID: intel_ish-hid: enable compile testing
Date: Fri, 26 May 2017 13:59:02 -0700
Message-ID: <1495832342.79527.6.camel@linux.intel.com>
References: <20170518202144.3482304-1-arnd@arndb.de>
         <20170518202144.3482304-6-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170518202144.3482304-6-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 2017-05-18 at 22:21 +0200, Arnd Bergmann wrote:
> To increase build coverage, drivers should generally be allowed to
> build on other architectures even if they are only used on one
> of them.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
 Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/hid/intel-ish-hid/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/intel-ish-hid/Kconfig b/drivers/hid/intel-
> ish-hid/Kconfig
> index ea065b3684a2..519e4c8b53c4 100644
> --- a/drivers/hid/intel-ish-hid/Kconfig
> +++ b/drivers/hid/intel-ish-hid/Kconfig
> @@ -1,5 +1,5 @@
>  menu "Intel ISH HID support"
> -	depends on X86_64 && PCI
> +	depends on (X86_64 || COMPILE_TEST) && PCI
>  
>  config INTEL_ISH_HID
>  	tristate "Intel Integrated Sensor Hub"
