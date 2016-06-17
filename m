From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 2/6] hid: intel_ish-hid: ISH Transport layer
Date: Fri, 17 Jun 2016 22:43:47 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1606172236520.6874@cbobk.fhfr.pm>
References: <1465647219-7798-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1465647219-7798-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465647219-7798-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jic23@kernel.org, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, chaya.golan@intel.com, daniel.drubin@intel.com, A.Bhattacharya@ulg.ac.be
List-Id: linux-input@vger.kernel.org

On Sat, 11 Jun 2016, Srinivas Pandruvada wrote:

[ ... snip ... ]
> diff --git a/drivers/hid/intel-ish-hid/Kconfig b/drivers/hid/intel-ish-hid/Kconfig
> new file mode 100644
> index 0000000..8914f3b
> --- /dev/null
> +++ b/drivers/hid/intel-ish-hid/Kconfig
> @@ -0,0 +1,22 @@
> +menu "Intel ISH HID support"
> +	depends on X86 && PCI
> +
> +config INTEL_ISH_HID_TRANSPORT
> +	bool
> +	default n
> +
> +config INTEL_ISH_HID
> +	bool "Intel Integrated Sensor Hub"

Why can't the transport driver be built as a module?

[ ... snip ... ]
> +/**
> + * ishtp_bus_add_device() - Function to create device on bus
> + *
> + * @dev:	ishtp device
> + * @uuid:	uuid of the client
> + * @name:	Name of the client
> + *
> + * Allocate ISHTP bus client device, attach it to uuid
> + * and register with ISHTP bus.
> + */
> +struct ishtp_cl_device *ishtp_bus_add_device(struct ishtp_device *dev,
> +					     uuid_le uuid, char *name)
> +{

Should be static.

[ ... snip ... ]
> +/**
> + * ishtp_bus_remove_device() - Function to relase device on bus
> + *
> + * @device:	client device instance
> + *
> + * This is a counterpart of ishtp_bus_add_device.
> + * Device is unregistered.
> + * the device structure is freed in 'ishtp_cl_dev_release' function
> + * Called only during error in pci driver init path.
> + */
> +void ishtp_bus_remove_device(struct ishtp_cl_device *device)
> +{

Should be static.

[ ... snip ... ]
> +/*
> + * ishtp_hbm_dma_xfer_ack - receive ack for ISHTP-over-DMA client message
> + *
> + * Constraint:
> + * First implementation is one ISHTP message per DMA transfer
> + */
> +void ishtp_hbm_dma_xfer_ack(struct ishtp_device *dev,

Should be static.

[ ... snip ... ]
> +/* ishtp_hbm_dma_xfer - receive ISHTP-over-DMA client message */
> +void ishtp_hbm_dma_xfer(struct ishtp_device *dev,
> +			struct dma_xfer_hbm *dma_xfer)

Should be static.

-- 
Jiri Kosina
SUSE Labs
