From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH v3 2/2] Input: soc_button_array - Add support for newer
 surface devices
Date: Mon, 22 Jul 2019 10:00:14 +0200
Message-ID: <a2f75544-54ce-abce-56a4-ca226dbed51f@metux.net>
References: <20190720150511.95076-1-luzmaximilian@gmail.com>
 <20190720150511.95076-3-luzmaximilian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190720150511.95076-3-luzmaximilian@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Maximilian Luz <luzmaximilian@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Chen Yu <yu.c.chen@intel.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

On 20.07.19 17:05, Maximilian Luz wrote:
> Power and volume button support for 5th and 6th generation Microsoft
> Surface devices via soc_button_array.
> 
> Note that these devices use the same MSHW0040 device as on the Surface
> Pro 4, however the implementation is different (GPIOs vs. ACPI
> notifications). Thus some checking is required to ensure we only load
> this driver on the correct devices.

Could this also used on the older (pre pro4) devices (also using the
gpios directly, and leave off acpi notifications) ?

--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
