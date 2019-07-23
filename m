From: Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [PATCH v3 2/2] Input: soc_button_array - Add support for newer
 surface devices
Date: Tue, 23 Jul 2019 13:29:27 +0200
Message-ID: <901b9b74-4c59-9c6a-ce41-404d8885cb83@gmail.com>
References: <20190720150511.95076-1-luzmaximilian@gmail.com>
 <20190720150511.95076-3-luzmaximilian@gmail.com>
 <a2f75544-54ce-abce-56a4-ca226dbed51f@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a2f75544-54ce-abce-56a4-ca226dbed51f@metux.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Chen Yu <yu.c.chen@intel.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

On 7/22/19 10:00 AM, Enrico Weigelt, metux IT consult wrote:
> On 20.07.19 17:05, Maximilian Luz wrote:
>> Power and volume button support for 5th and 6th generation Microsoft
>> Surface devices via soc_button_array.
>>
>> Note that these devices use the same MSHW0040 device as on the Surface
>> Pro 4, however the implementation is different (GPIOs vs. ACPI
>> notifications). Thus some checking is required to ensure we only load
>> this driver on the correct devices.
> 
> Could this also used on the older (pre pro4) devices (also using the
> gpios directly, and leave off acpi notifications) ?

As far as I can tell, no. The Pro 4 and Pro 3 don't have any GPIOs on
MSHW0028/MSHW0040. Book 1 has GPIOs but for a different purpose. The Pro
2 has a standard PNP0C0C power button (no idea how the volume buttons
are handled there, but also seems to be different from what I can gather
from DSDT). I can't say anything for the Pro 1 and non-Pro devices.

Maximilian
