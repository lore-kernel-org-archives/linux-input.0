From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v10 5/5] mfd: Move binding document
Date: Mon, 21 Nov 2016 10:50:23 +0000
Message-ID: <20161121105023.GH32509@dell>
References: <cover.1479638191.git.ksenija.stanojevic@gmail.com>
 <ed11371e67fb76fc6c6f347ec779e620412a339f.1479638191.git.ksenija.stanojevic@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ed11371e67fb76fc6c6f347ec779e620412a339f.1479638191.git.ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-95f8Dae0BrPYtjvyW6yDsg@public.gmane.org, stefan.wahren-eS4NqCHxEME@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sun, 20 Nov 2016, Ksenija Stanojevic wrote:

> The bindings, which are now used in MFD, need also to be
> documented in the MFD binding document.
> 
> Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> Changes in v10:
>  - none
> 
> Changes in v9:
>  - format patch using -M option
> 
> Changes in v8:
>  - rebase onto 4.9-rc1
> 
> Changes in v7:
>  - add to the patchset
> 
>  Documentation/devicetree/bindings/{iio/adc => mfd}/mxs-lradc.txt | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/{iio/adc => mfd}/mxs-lradc.txt (100%)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

> diff --git a/Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt b/Documentation/devicetree/bindings/mfd/mxs-lradc.txt
> similarity index 100%
> rename from Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt
> rename to Documentation/devicetree/bindings/mfd/mxs-lradc.txt

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
