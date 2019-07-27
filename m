From: Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [PATCH v3 2/2] Input: soc_button_array - Add support for newer
 surface devices
Date: Sat, 27 Jul 2019 14:01:26 +0200
Message-ID: <fb53b082-4d83-83a6-1ae6-b9fae9dc750f@gmail.com>
References: <20190720150511.95076-1-luzmaximilian@gmail.com>
 <20190720150511.95076-3-luzmaximilian@gmail.com>
 <20190727091443.GC795@penguin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190727091443.GC795@penguin>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Chen Yu <yu.c.chen@intel.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

On 7/27/19 11:14 AM, Dmitry Torokhov wrote:
> On Sat, Jul 20, 2019 at 05:05:11PM +0200, Maximilian Luz wrote:
>> -
>> -	error = gpiod_count(dev, NULL);
>> -	if (error < 0) {
>> -		dev_dbg(dev, "no GPIO attached, ignoring...\n");
>> -		return -ENODEV;
> 
> I do not think we need to move this into individual "check" functions.
> It is needed in all cases so we should keep it here.
> 
> How about version below?

Makes sense, looks good to me!

Maximilian
