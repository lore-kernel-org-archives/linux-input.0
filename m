From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 0/9] Goodix touchscreen enhancements
Date: Thu, 04 Jun 2015 15:04:38 +0200
Message-ID: <1433423078.5346.27.camel@hadess.net>
References: <1432817265-23891-1-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432817265-23891-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hey Irina,

On Thu, 2015-05-28 at 15:47 +0300, Irina Tirdea wrote:
> Add several enhancements to the Goodix touchscreen driver:
>  - write configuration data to the device
>  - power management support
>  - cleanup and refactoring
> 
> Irina Tirdea (9):
>   input: goodix: fix alignment issues
>   input: goodix: fix variable length array warning
>   input: goodix: export id and version read from device
>   input: goodix: add ACPI IDs for GT911 and GT9271
>   input: goodix: reset device at init
>   input: goodix: write configuration data to device
>   input: goodix: add power management support
>   input: goodix: add support for ESD
>   input: goodix: use goodix_i2c_write_u8 instead of i2c_master_send

Thanks a lot of that patch series. I was travelling when you sent it,
but I should be able to test the patch series quicker when you send a
v2.

Could you please also add some references to hardware that you're
enabling (and presumably have been testing on) to the driver's Kconfig?
If the hardware is still not public, any sort of other reference would
be useful (Windows 8 compatible harwdare? Hardware that usually runs a
particular Android vendor tree?...)

Cheers
