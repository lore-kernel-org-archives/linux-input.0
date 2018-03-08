From: JeffyChen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH v4 1/3] Input: gpio-keys - add support for wakeup event
 action
Date: Thu, 08 Mar 2018 15:32:09 +0800
Message-ID: <5AA0E6F9.6060704@rock-chips.com>
References: <20180306074418.8879-1-jeffy.chen@rock-chips.com> <20180306074418.8879-2-jeffy.chen@rock-chips.com> <CAHp75VcmbHbnD8FnTHXAqGajhs10wA7Z7U_D6SY9=j=y+GLLPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VcmbHbnD8FnTHXAqGajhs10wA7Z7U_D6SY9=j=y+GLLPA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, briannorris@google.com, =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, Dmitry Torokhov <dtor@google.com>, Douglas Anderson <dianders@google.com>, devicetree <devicetree@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, Thomas Gleixner <tglx@linutronix.de>, Joseph Lo <josephl@nvidia.com>, stephen lu <lumotuwe@gmail.com>, Rob Herring <robh+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kate Stewart <kstewart@linuxfoundation.org>, linux-input <linux-input@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Philippe Ombredanne <pombredanne@nexb.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>
List-Id: linux-input@vger.kernel.org

Hi Andy,

Thanks for your reply.

On 03/07/2018 07:57 PM, Andy Shevchenko wrote:
> On Tue, Mar 6, 2018 at 9:44 AM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
>> Add support for specifying event actions to trigger wakeup when using
>> the gpio-keys input device as a wakeup source.
>>
>> This would allow the device to configure when to wakeup the system. For
>> example a gpio-keys input device for pen insert, may only want to wakeup
>> the system when ejecting the pen.
>
>> +       bool wakeup_enabled;
>
>> +                       if (bdata->wakeup_enabled) {
>
> This is redundant. IRQ core keeps track on this information already.
>
> Check below as an example
> aef3ad103a68 ("serial: core: remove unneeded irq_wake flag")
>
right, that make sense.
>
