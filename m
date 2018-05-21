From: Jian-Hong Pan <jian-hong@endlessm.com>
Subject: Re: [PATCH] mfd: intel-lpss: Fix Intel Cannon Lake LPSS I2C input clock
Date: Mon, 21 May 2018 15:06:07 +0800
Message-ID: <CAPpJ_eenULHGQOSG7xOpdTh8gCuVpFW8V3u=gp1OfnXQY8Yw=A@mail.gmail.com>
References: <20180518083827.20626-1-jarkko.nikula@linux.intel.com> <20180518104638.GF15419@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180518104638.GF15419@lahna.fi.intel.com>
Sender: stable-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, Chris Chiu <chiu@endlessm.com>, Daniel Drake <drake@endlessm.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Jarkko,

We have tried this patch on the two laptops we have now:

ASUS X580GD

dev@endless:~$ lscpu | grep "Model name"
Model name:          Intel(R) Core(TM) i5-8300H CPU @ 2.30GHz
dev@endless:~$ lspci | grep -E '(a36[89ab]|97c[56])'
00:15.0 Serial bus controller [0c80]: Intel Corporation Device a368 (rev 10)
00:15.1 Serial bus controller [0c80]: Intel Corporation Device a369 (rev 10)
dev@endless:~$ dmesg | grep -E 'lpss|i2c'
[    9.692511] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
[    9.697702] intel-lpss 0000:00:15.1: enabling device (0000 -> 0002)
[    9.920034] input: ELAN1200:00 04F3:303E Touchpad as
/devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-8/i2c-ELAN1200:00/0018:04F3:303E.0001/input/input18
[    9.920204] hid-multitouch 0018:04F3:303E.0001: input,hidraw0: I2C
HID v1.00 Mouse [ELAN1200:00 04F3:303E] on i2c-ELAN1200:00
[    9.923873] intel-lpss 0000:00:1e.0: enabling device (0000 -> 0002)
[    9.924806] intel-lpss 0000:00:1e.2: enabling device (0000 -> 0002)

ASUS UX550GE

dev@endless:~$ lscpu | grep "Model name"
Model name:          Intel(R) Core(TM) i7-8750H CPU @ 2.20GHz
dev@endless:~$ lspci | grep -E '(a36[89ab]|97c[56])'
00:15.0 Serial bus controller [0c80]: Intel Corporation Device a368 (rev 10)
00:15.1 Serial bus controller [0c80]: Intel Corporation Device a369 (rev 10)
dev@endless:~$ dmesg | grep -E 'lpss|i2c'
[    6.926801] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
[    6.940907] intel-lpss 0000:00:15.1: enabling device (0000 -> 0002)
[    6.971915] input: FTE1200:00 0B05:0201 Touchpad as
/devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-9/i2c-FTE1200:00/0018:0B05:0201.0002/input/input21
[    6.971961] hid-multitouch 0018:0B05:0201.0002: input,hidraw1: I2C
HID v1.00 Mouse [FTE1200:00 0B05:0201] on i2c-FTE1200:00
[    6.973930] intel-lpss 0000:00:1e.0: enabling device (0000 -> 0002)
[    6.974700] intel-lpss 0000:00:1e.2: enabling device (0000 -> 0002)

The patch works on both of the laptops with the touchpads.

2018-05-18 18:46 GMT+08:00 Mika Westerberg <mika.westerberg@linux.intel.com>:
> On Fri, May 18, 2018 at 11:38:27AM +0300, Jarkko Nikula wrote:
>> Intel Cannon Lake PCH has much higher 216 MHz input clock to LPSS I2C
>> than Sunrisepoint which uses 120 MHz. Preliminary information was that
>> both share the same clock rate but actual silicon implements elevated
>> rate for better support for 3.4 MHz high-speed I2C.
>>
>> This incorrect input clock rate results too high I2C bus clock in case
>> ACPI doesn't provide tuned I2C timing parameters since I2C host
>> controller driver calculates them from input clock rate.
>>
>> Fix this by using the correct rate. We still share the same 230 ns SDA
>> hold time value than Sunrisepoint.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: b418bbff36dd ("mfd: intel-lpss: Add Intel Cannonlake PCI IDs")
>> Reported-by: Jian-Hong Pan <jian-hong@endlessm.com>
>> Reported-by: Chris Chiu <chiu@endlessm.com>
>> Reported-by: Daniel Drake <drake@endlessm.com>
>> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Tested-by: Jian-Hong Pan <jian-hong@endlessm.com>
