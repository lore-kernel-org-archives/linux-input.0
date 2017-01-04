From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 7/7] misc: intel-ish-client: add intel ishtp clients
 driver
Date: Wed, 4 Jan 2017 14:03:16 +0100
Message-ID: <20170104130316.GA8378@kroah.com>
References: <1482456149-4841-1-git-send-email-even.xu@intel.com>
 <1482456149-4841-7-git-send-email-even.xu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1482456149-4841-7-git-send-email-even.xu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Even Xu <even.xu@intel.com>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, srinivas.pandruvada@linux.intel.com, arnd@arndb.de, andriy.shevchenko@intel.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Dec 23, 2016 at 09:22:29AM +0800, Even Xu wrote:
> Intel ISHFW supports many different clients, in
> hid/intel-ish-hid/ishtp bus driver, it creates following client devices:
> HID client:
> 	interface of sensor configure and sensor event report.
> SMHI client:
> 	interface of sensor calibration, ISHFW debug, ISHFW performance
> 	analysis and manufacture support.
> Trace client:
> 	interface of ISHFW debug log output.
> Trace configure client:
> 	interface of ISHFW debug log configuration, such as output port,
> 	log level, filter.
> ISHFW loader client:
> 	interface of customized ISHFW loader.
> HID client has been handle by hid/intel-ish-hid/intel-ishtp-hid client
> driver, and rest of the clients export interface using miscellaneous
> drivers. This interface is used by user space tools for debugging and
> calibration of sensors.
> 
> Signed-off-by: Even Xu <even.xu@intel.com>
> Reviewed-by: Andriy Shevchenko <andriy.shevchenko@intel.com>
> Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/misc/Kconfig                               |   1 +
>  drivers/misc/Makefile                              |   1 +
>  drivers/misc/intel-ish-client/Kconfig              |  15 +
>  drivers/misc/intel-ish-client/Makefile             |   8 +
>  .../misc/intel-ish-client/intel-ishtp-clients.c    | 884 +++++++++++++++++++++
>  include/uapi/linux/intel-ishtp-clients.h           |  73 ++


Why create a whole new subdirectory for just one .c file?  Is that
really needed?

And I'm not quite sure why you need a misc driver, what exactly is this
code doing?

Let me look at your uapi header file:

> --- /dev/null
> +++ b/include/uapi/linux/intel-ishtp-clients.h
> @@ -0,0 +1,73 @@
> +/*
> + * Intel ISHTP Clients Interface Header
> + *
> + * Copyright (c) 2016, Intel Corporation.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
> + * more details.
> + *
> + */
> +
> +#ifndef _INTEL_ISHTP_CLIENTS_H
> +#define _INTEL_ISHTP_CLIENTS_H
> +
> +#include <linux/ioctl.h>
> +#include <linux/miscdevice.h>
> +#include <linux/mutex.h>
> +#include <linux/types.h>
> +#include <linux/uuid.h>
> +
> +/*
> + * This IOCTL is used to associate the current file descriptor with a
> + * FW Client (given by UUID). This opens a communication channel
> + * between a host client and a FW client. From this point every read and write
> + * will communicate with the associated FW client.
> + * Only in close() (file_operation release()) the communication between
> + * the clients is disconnected

Why do you want to do this?  What will read/write do with this device
now?

> + *
> + * The IOCTL argument is a struct with a union that contains
> + * the input parameter and the output parameter for this IOCTL.

Is that sentance really needed?

> + *
> + * The input parameter is UUID of the FW Client.
> + * The output parameter is the properties of the FW client
> + * (FW protocol version and max message size).
> + *
> + */
> +#define IOCTL_ISHTP_CONNECT_CLIENT	_IOWR('H', 0x81,	\
> +				struct ishtp_connect_client_data)
> +
> +/* Configuration: set number of Rx/Tx buffers. Must be used before connection */
> +#define IOCTL_ISHTP_SET_RX_FIFO_SIZE	_IOWR('H', 0x82, long)
> +#define IOCTL_ISHTP_SET_TX_FIFO_SIZE	_IOWR('H', 0x83, long)

Before connection to what?

> +
> +/* Get FW status */
> +#define IOCTL_ISH_GET_FW_STATUS	_IO('H', 0x84)

What is this?

> +
> +#define IOCTL_ISH_HW_RESET	_IO('H', 0x85)

No documentation?

> +
> +/*
> + * Intel ISHTP client information struct
> + */
> +struct ishtp_client {
> +	__u32 max_msg_length;
> +	__u8 protocol_version;
> +	__u8 reserved[3];
> +};
> +

Nice job using the correct types.

I still don't know what this api does, let me go look at the .c code
now...

thanks,

greg k-h
