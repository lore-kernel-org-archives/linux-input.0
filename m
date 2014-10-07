From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/6] mfd: core: add helper function to register hotplug
 devices
Date: Tue, 7 Oct 2014 10:24:03 +0100
Message-ID: <20141007092403.GS25331@lee--X1>
References: <1411728933-13351-1-git-send-email-johan@kernel.org>
 <1411728933-13351-4-git-send-email-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1411728933-13351-4-git-send-email-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 26 Sep 2014, Johan Hovold wrote:

> Hot-pluggable multi-function devices should always be registered with
> PLATFORM_DEVID_AUTO to avoid name collisions on the platform bus. Thi=
s
> helper also hides the memory map and irq parameters, which aren't use=
d
> by hot-pluggable (e.g. USB-based) devices.
>=20
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  include/linux/mfd/core.h | 7 +++++++
>  1 file changed, 7 insertions(+)

Applied for v3.19.

> diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
> index f543de91ce19..1e47262a1c63 100644
> --- a/include/linux/mfd/core.h
> +++ b/include/linux/mfd/core.h
> @@ -108,6 +108,13 @@ extern int mfd_add_devices(struct device *parent=
, int id,
>  			   struct resource *mem_base,
>  			   int irq_base, struct irq_domain *irq_domain);
> =20
> +static inline int mfd_add_hotplug_devices(struct device *parent,
> +		const struct mfd_cell *cells, int n_devs)
> +{
> +	return mfd_add_devices(parent, PLATFORM_DEVID_AUTO, cells, n_devs,
> +			NULL, 0, NULL);
> +}
> +
>  extern void mfd_remove_devices(struct device *parent);
> =20
>  #endif

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
