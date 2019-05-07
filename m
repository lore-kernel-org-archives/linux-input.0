From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/3] mfd: apple-ibridge: Add Apple iBridge MFD driver.
Date: Tue, 7 May 2019 13:24:15 +0100
Message-ID: <20190507122415.GC29524@dell>
References: <20190422031251.11968-1-ronald@innovation.ch>
 <20190422031251.11968-2-ronald@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190422031251.11968-2-ronald@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, 21 Apr 2019, Ronald Tschalär wrote:

> The iBridge device provides access to several devices, including:
> - the Touch Bar
> - the iSight webcam
> - the light sensor
> - the fingerprint sensor
> 
> This driver provides the core support for managing the iBridge device
> and the access to the underlying devices. In particular, since the
> functionality for the touch bar and light sensor is exposed via USB HID
> interfaces, and the same HID device is used for multiple functions, this
> driver provides a multiplexing layer that allows multiple HID drivers to
> be registered for a given HID device. This allows the touch bar and ALS
> driver to be separated out into their own modules.
> 
> Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
> ---
>  drivers/mfd/Kconfig               |  15 +
>  drivers/mfd/Makefile              |   1 +
>  drivers/mfd/apple-ibridge.c       | 883 ++++++++++++++++++++++++++++++

I haven't taken a thorough look through, but I can tell you that the
vast majority of what you're trying to do here does not belong in
MFD.  MFD drivers are used to register child devices.  Almost all
functionality or 'real work' should be contained in the drivers the
MFD registers, not in the MFD parent itself.  You will need to move
all 'real work' out into the subordinate device drivers for
acceptance.

>  include/linux/mfd/apple-ibridge.h |  39 ++
>  4 files changed, 938 insertions(+)
>  create mode 100644 drivers/mfd/apple-ibridge.c
>  create mode 100644 include/linux/mfd/apple-ibridge.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
