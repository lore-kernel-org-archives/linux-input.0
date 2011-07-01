From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH 08/11] misc: Kconfig and Makefile changes for inv_mpu
 driver
Date: Fri, 1 Jul 2011 10:10:18 -0700
Message-ID: <20110701101018.0f02d2f3.rdunlap@xenotime.net>
References: <1309486707-1658-1-git-send-email-nroyer@invensense.com>
	<1309486707-1658-8-git-send-email-nroyer@invensense.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from oproxy8-pub.bluehost.com ([69.89.22.20]:41009 "HELO
	oproxy8-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756650Ab1GARKV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Jul 2011 13:10:21 -0400
In-Reply-To: <1309486707-1658-8-git-send-email-nroyer@invensense.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nathan Royer <nroyer@invensense.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Jonathan Cameron <jic23@cam.ac.uk>, Jiri Kosina <jkosina@suse.cz>, Alan Cox <alan@linux.intel.com>, Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Thu, 30 Jun 2011 19:18:24 -0700 Nathan Royer wrote:

> Signed-off-by: Nathan Royer <nroyer@invensense.com>
> ---
>  drivers/misc/Kconfig          |    1 +
>  drivers/misc/Makefile         |    1 +
>  drivers/misc/inv_mpu/Kconfig  |   58 +++++++++++++++++++++++++++++++++++++++++
>  drivers/misc/inv_mpu/Makefile |   17 ++++++++++++
>  4 files changed, 77 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/misc/inv_mpu/Kconfig
>  create mode 100644 drivers/misc/inv_mpu/Makefile
> 
> diff --git a/drivers/misc/inv_mpu/Kconfig b/drivers/misc/inv_mpu/Kconfig
> new file mode 100644
> index 0000000..fdfa7a6
> --- /dev/null
> +++ b/drivers/misc/inv_mpu/Kconfig
> @@ -0,0 +1,58 @@
> +
> +menuconfig: INV_SENSORS

hm, that ':' there happens to work, but the syntax description for
"menuconfig" does not show it as allowed, and no other Kconfig files use
a colon there, so please drop it.

Oh, also not "default y", please.

> +	tristate "Motion Processing Unit"
> +	depends on I2C
> +	default y
> +
> +if INV_SENSORS
> +
> +choice
> +	prompt "MPU Master"
> +	depends on I2C && INV_SENSORS
> +	default MPU_SENSORS_MPU3050
> +
> +config MPU_SENSORS_MPU3050
> +	bool "MPU3050"
> +	depends on I2C
> +	select MPU_SENSORS_MPU3050_GYRO
> +	help
> +	  If you say yes here you get support for the MPU3050 Gyroscope driver
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called mpu3050.
> +
> +config MPU_SENSORS_MPU6050A2
> +	bool "MPU6050A2"
> +	depends on I2C
> +	select MPU_SENSORS_MPU6050_GYRO
> +	help
> +	  If you say yes here you get support for the MPU6050A2 Gyroscope driver
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called mpu6050a2.
> +
> +config MPU_SENSORS_MPU6050B1
> +	bool "MPU6050B1"
> +	select MPU_SENSORS_MPU6050_GYRO
> +	depends on I2C
> +	help
> +	  If you say yes here you get support for the MPU6050 Gyroscope driver
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called mpu6050b1.
> +
> +endchoice
> +
> +choice
> +	prompt "Gyroscope Type"
> +	depends on I2C && INV_SENSORS
> +	default MPU_SENSORS_MPU3050_GYRO
> +
> +config MPU_SENSORS_MPU3050_GYRO
> +	bool "MPU3050 built in gyroscope"
> +	depends on MPU_SENSORS_MPU3050
> +
> +config MPU_SENSORS_MPU6050_GYRO
> +	bool "MPU6050 built in gyroscope"
> +	depends on MPU_SENSORS_MPU6050B1 || MPU_SENSORS_MPU6050A2
> +
> +endchoice
> +
> +endif #INV_SENSORS



---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
