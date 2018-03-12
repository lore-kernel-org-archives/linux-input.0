From: JeffyChen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH v5 1/3] Input: gpio-keys - add support for wakeup event
 action
Date: Mon, 12 Mar 2018 18:40:54 +0800
Message-ID: <5AA65936.7040500@rock-chips.com>
References: <20180308073213.8419-1-jeffy.chen@rock-chips.com> <20180308073213.8419-2-jeffy.chen@rock-chips.com> <20180310181509.GB260013@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180310181509.GB260013@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, briannorris@google.com, heiko@sntech.de, dtor@google.com, dianders@google.com, devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Thomas Gleixner <tglx@linutronix.de>, Joseph Lo <josephl@nvidia.com>, stephen lu <lumotuwe@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Philippe Ombredanne <pombredanne@nexb.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

Thanks for your reply.

On 03/11/2018 02:15 AM, Dmitry Torokhov wrote:>> +static int 
gpio_keys_enable_wakeup(struct gpio_button_data *bdata)
 > These new helpers need to be __maybe_unused in case we compile on system
 > without suspend support.
 >
 > I also wanted a bit more of error handling, so I ended up with the
 > version of the patch below. Can you please try it and let me know if I
 > broke it.

sure, the patch you sent works :)

Tested-by: Jeffy Chen <jeffy.chen@rock-chips.com>

 >
 > Thanks.
 >
 > -- Dmitry
 >
 > Input: gpio-keys - add support for wakeup event action
 >
 > From: Jeffy Chen <jeffy.chen@rock-chips.com>
 >
 > Add support for specifying event actions to trigger wakeup when using
 > the gpio-keys input device as a wakeup source.
 >
 > This would allow the device to configure when to wakeup the system. For
 > example a gpio-keys input device for pen insert, may only want to wakeup
 > the system when ejecting the pen.
 >
 > Suggested-by: Brian Norris <briannorris@chromium.org>
 > Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
 > Reviewed-by: Rob Herring <robh@kernel.org>
 > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
