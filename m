From: Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [PATCH v2 2/2] input: soc_button_array for newer surface devices
Date: Wed, 17 Jul 2019 21:23:33 +0200
Message-ID: <fbcb6b9d-01b4-43d3-a177-342d88120a4b@gmail.com>
References: <20190702003740.75970-1-luzmaximilian@gmail.com>
 <20190702003740.75970-3-luzmaximilian@gmail.com>
 <20190716072135.GA806@penguin>
 <92e13b01-7353-1430-fb38-b5098d509da2@gmail.com>
 <20190716201807.GA584@penguin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190716201807.GA584@penguin>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Chen Yu <yu.c.chen@intel.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

On 7/16/19 10:18 PM, Dmitry Torokhov wrote:
> OK, fair enough. By the way, I see you are adding some #ifdef
> CONFIG_ACPI and stubbing out new functions, but the driver does not
> really work without ACPI (acpi_match_device() will fail in this case I
> would think and that will cause probe() to abort). So maybe we just add
> depends on ACPI to the driver's Kconfig entry?

Makes sense, I can change that too.

Maximilian
