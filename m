From: Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [PATCH v2 1/2] platform: Fix device check for surfacepro3_button
Date: Tue, 2 Jul 2019 04:04:37 +0200
Message-ID: <3eab65a6-90d6-d598-2b16-805c28864716@gmail.com>
References: <20190702003740.75970-1-luzmaximilian@gmail.com>
 <20190702003740.75970-2-luzmaximilian@gmail.com>
 <20190702011443.GA19902@chenyu-office.sh.intel.com>
 <91349d00-e7e2-887b-45e5-4689a401aa2f@gmail.com>
 <d7e17f54-4c33-fa8d-be03-9e507da8e495@gmail.com>
 <20190702015717.GA20346@chenyu-office.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190702015717.GA20346@chenyu-office.sh.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yu Chen <yu.c.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

On 7/2/19 3:57 AM, Yu Chen wrote:
> How about using a boolean, according to the function name, if a mshw0040 revison
> is detected then returns true other wise false. Other than that,
> Acked-by: Chen Yu <yu.c.chen@intel.com>

I can change that if you want me to. Just thought this might be a bit
more flexible in case we ever have to adapt the check for future device
generations.

Thanks,
Maximilian
