From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH] [v3] HID: add support for Apple Magic Trackpad 2
Date: Sun, 30 Sep 2018 13:34:20 +0200
Message-ID: <b3a3b9f8-3f74-d2d4-fb12-2cf46d756232@bitmath.org>
References: <20180920231308.237277-1-seobrien@chromium.org>
 <CAOOzhkosyZpr+B1xwZcG3viNbWZFWr9WQtgGdP13i_+_Ocdgmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOOzhkosyZpr+B1xwZcG3viNbWZFWr9WQtgGdP13i_+_Ocdgmg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sean O'Brien <seobrien@chromium.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: marek.wyborski@emwesoft.com, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, claudio@ponyfleisch.ch
List-Id: linux-input@vger.kernel.org

Hi Sean,

> Gentle reminder, thank you!
>
> On Thu, Sep 20, 2018 at 4:13 PM Sean O'Brien <seobrien@chromium.org> wrote:
>> USB device
>>          Vendor 05ac (Apple)
>>          Device 0265 (Magic Trackpad 2)
>> Bluetooth device
>>          Vendor 004c (Apple)
>>          Device 0265 (Magic Trackpad 2)
>>
>> Add support for Apple Magic Trackpad 2 over USB and bluetooth, putting
>> the device in multi-touch mode.
>>
>> Signed-off-by: Claudio Mettler <claudio@ponyfleisch.ch>
>> Signed-off-by: Marek Wyborski <marek.wyborski@emwesoft.com>
>> Signed-off-by: Sean O'Brien <seobrien@chromium.org>
>> ---
>>
>>   drivers/hid/hid-ids.h        |   1 +
>>   drivers/hid/hid-magicmouse.c | 149 +++++++++++++++++++++++++++++++----
>>   2 files changed, 134 insertions(+), 16 deletions(-)

This version looks good.

Reviewed-by: Henrik Rydberg <rydberg@bitmath.org>

Thank you!

Henrik
