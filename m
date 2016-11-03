From: Daniel Drake <drake@endlessm.com>
Subject: Support for ACPI0011 Generic Buttons Device
Date: Thu, 3 Nov 2016 07:24:03 -0600
Message-ID: <CAD8Lp4553c8U=XfzbiXsKYgj_PKnVjmk9MdB3j=O-pPt9yi7BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc: Linux Upstreaming Team <linux@endlessm.com>
List-Id: linux-input@vger.kernel.org

Hi,

We are working with a new consumer laptop model which has physical
volume up/down keys on the left side of the chassis.

It appears that these buttons are driven by the ACPI0011 Generic
Buttons Device defined in section 9.19 of the ACPI spec. The _DSD has
entries for the appropriate HID codes for volume up/down which can
also be seen in examples here:

https://msdn.microsoft.com/en-us/windows/hardware/drivers/hid/acpi-button-device

I can't see a Linux driver for this ACPI0011 interface, is one planned?

Thanks
Daniel
