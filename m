From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 1/3] acpi: lpss: call pwm_add_table() for bsw pwm
 device
Date: Tue, 31 Jan 2017 09:29:58 +0100
Message-ID: <1da769cc-aebc-96f9-4ff1-cf43b43a6f90@redhat.com>
References: <20170122152415.10374-1-hdegoede@redhat.com>
 <CAHp75VdqUhcW2ufJk5yPHYJv=Kb5-7EiC6FxZ7T+7jTaubhbbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59752 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbdAaIaC (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 31 Jan 2017 03:30:02 -0500
In-Reply-To: <CAHp75VdqUhcW2ufJk5yPHYJv=Kb5-7EiC6FxZ7T+7jTaubhbbg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Darren Hart <dvhart@infradead.org>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input <linux-input@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>

Hi,

On 30-01-17 23:21, Andy Shevchenko wrote:
> On Sun, Jan 22, 2017 at 5:24 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> On x86 we do not have devicetree to link the pwm controller and
>> the display controller together. So someone needs to call
>> pwm_add_table() to create the link, so that the i915 driver's
>> pwm_get(dev, "pwm_backlight") call returns the lpss' pwm0.
>>
>> The pwm subsystem does not want to have pwm_add_table() calls
>> directly in pwm drivers (this leads to probe ordering issues),
>> so lets do it here since the acpi-lpss code is always builtin.
>
> Hans, just to be sure, the device you have is using LPSS pwm for backlight.

Correct, I've 2 cherrytrail tablets and one mini laptop, the 2 tablets
both use LPSS for backlight, the mini laptop just arrived and I
still need to put Linux on it.

> Since I just recall that on some (Baytrail) models we have PMIC
> (Crystal Cove) that responsible for PWM for backlight.
> And we have no PMIC driver in kernel for CherryTrail (Dollar Cove).

Right, on baytrail the pwm_crc driver is used which AFAIK is
for CRystal Cove.

Regards,

Hans
