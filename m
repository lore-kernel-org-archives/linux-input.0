From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] Haptic class support (v2)
Date: Mon, 12 Oct 2009 09:32:28 +0900
Message-ID: <9c9fda240910111732x262a9510rf3dd862aa16d0bdf@mail.gmail.com>
References: <20091006074533.GA28889@july> <20091011090549.GE1414@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751861AbZJLAdI@vger.kernel.org>
In-Reply-To: <20091011090549.GE1414@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, soni.trilok@gmail.com, Greg KH <greg@kroah.com>
List-Id: linux-input@vger.kernel.org

On Sun, Oct 11, 2009 at 6:05 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Tue 2009-10-06 16:45:33, Kyungmin Park wrote:
>> This patch includes two haptic devices, isa1000 and isa1200
>> ISA1000 is gpio based haptic, but isa1200 is based on I2C
>> Both are working on Samsung SoCs and tested.
>>
>> To enable the haptic, echo 1 > /sys/class/haptic/${name}/enable
>> You can adjust the level by echo ${level} > /sys/class/haptic/${name}/enable
>> or
>> With oneshot feature, echo ${msec time} > /sys/class/haptic/${name}/oneshot
>
> New device classes should certainly be documented in Documentation/.
>
> For example... is level 0-100?

Basically. range from 0 to 255. also each device can set max level in
case of isa1000 it's 6.

>  Is it valid to change level while 'oneshot' is running?

we usually use it under 1 sec. but I think it's possible to change it
but not tried.

>  Does oneshot use last level set?

Right. it used last set value.

If you don't mind to update these at Documentation please wait until
commit first patches merged.

Thank you,
Kyungmin Park
