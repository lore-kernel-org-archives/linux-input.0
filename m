From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 0/4] Various intel small device drivers
Date: Wed, 14 Apr 2010 15:30:52 +0200
Message-ID: <20100414153052.4e07f0cc@hyperion.delvare>
References: <20100414124913.23181.75903.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100414124913.23181.75903.stgit-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Alan,

On Wed, 14 Apr 2010 13:51:30 +0100, Alan Cox wrote:
> These have been through my clean up processing, in particular the accelerometers
> are now using the input layer infrastructure.
> 
> 
> ---
> 
> Kalhan Trisal (4):
>       emc1403: thermal sensor support
>       liss331d1: accelerometer driver
>       isl29020: ambient light sensor
>       hmc6352: Add driver for the HMC6352 compass

The liss331d1, isl29020 and hmc6352 are not hardware monitoring drivers
and thus do not belong to drivers/hwmon.

BTW, when sending actual hardware monitoring drivers, the right mailing
list is lm-sensors, which you did not include. Please see MAINTAINERS.

>  drivers/hwmon/Kconfig    |   34 ++++
>  drivers/hwmon/Makefile   |    4 
>  drivers/hwmon/emc1403.c  |  437 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/hwmon/hmc6352.c  |  235 +++++++++++++++++++++++++
>  drivers/hwmon/isl29020.c |  243 ++++++++++++++++++++++++++
>  drivers/hwmon/lis331dl.c |  286 ++++++++++++++++++++++++++++++
>  6 files changed, 1239 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/hwmon/emc1403.c
>  create mode 100644 drivers/hwmon/hmc6352.c
>  create mode 100644 drivers/hwmon/isl29020.c
>  create mode 100644 drivers/hwmon/lis331dl.c
> 


-- 
Jean Delvare
