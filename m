From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 0/8] Input: support for latest Lenovo thinkpads (series 80)
Date: Fri, 6 Apr 2018 08:51:11 +0200
Message-ID: <CAO-hwJLY=OR1bk2y9c-6MZzoAYzorH9MEKf70=dnhqz8s-dCQg@mail.gmail.com>
References: <20180405132537.3218-1-benjamin.tissoires@redhat.com> <20180405235126.GB57189@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180405235126.GB57189@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>, Oliver Haessler <oliver@redhat.com>, Benjamin Berg <bberg@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On Fri, Apr 6, 2018 at 1:51 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Benjamin,
>
> On Thu, Apr 05, 2018 at 03:25:29PM +0200, Benjamin Tissoires wrote:
>> Hi Dmitry,
>>
>> well, this year, Lenovo gave us a surprise and decided to not use
>> the same touchpad/trackstick in all its model. And by default, the
>> support under Linux is less than ideal.
>>
>> Please find a series that should fix those issues. Compared to the 60
>> series, there do not seem to e BIOS table issues this time, and suspend/resume
>> works fine thanks to your latest trackstick fixes.
>>
>> The T480s is a different beast, as it uses an Elan touchpad.
>> I have been carrying the patches 3-6 for a while and tested previous
>> versions on various Elan PS/2 hardware without an issue as far as I
>> could tell. I was lacking tests from users with SMBus as all the laptops
>> I tried where puer PS/2.
>>
>> Anyway, it would be cool if you could have a look at the series.
>
> I am mostly happy with the series, but I would love to hear KT's take on
> it.

thanks for the quick review.
I worked closely with KT for this series. He helped me a lot for the
tiny firmware changes that were required. However, quoting his email
from Tuesday:
"There will be a spring vacation in Taiwan from tomorrow." I guess we
won't hear from him until the end of next week as we always have a
backlog of urgent things to do after holidays...

Cheers,
Benjamin
