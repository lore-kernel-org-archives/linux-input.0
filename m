From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: Re: [PATCH 1/2] input: touchscreen: ar1021_i2c: enable touch mode
 during open
Date: Mon, 5 Feb 2018 11:40:11 +0100
Message-ID: <5bfec26e-b09c-2fa0-4eb0-3f9a08d293ed@ginzinger.com>
References: <1493295756-17812-1-git-send-email-martin.kepplinger@ginzinger.com>
 <CAH9NwWeom2H89D5hUixxSL28YgDna_WS26boayzUBAPyVFUvTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAH9NwWeom2H89D5hUixxSL28YgDna_WS26boayzUBAPyVFUvTA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

﻿



Martin Kepplinger | Entwicklung Software 

GINZINGER ELECTRONIC SYSTEMS GMBH

Tel.: +43 7723 5422 157
Mail: martin.kepplinger@ginzinger.com
Web: www.ginzinger.com




On 2018-02-05 11:07, Christian Gmeiner wrote:
> Hi all.
> 
> 2017-04-27 14:22 GMT+02:00 Martin Kepplinger <martin.kepplinger@ginzinger.com>:
>> The device could as well be in command mode, in which this driver cannot
>> handle the device. When opening the device, let's make sure the device
>> will be in the mode we expect it to be for this driver.
>>
> 
> I run into issues caused by this change. It turns out that the device
> is non-functional
> after some warm-reboots and as a result I am not able to use xorg's
> evdev driver.
> So I have some questions about this change:
> 
> * Should we enable irq before calling i2c_master_send(..) as the chip raises an
>   irq if the command was processed?
> 
> * Would it be enough to send this command only once during driver
> lifetime? I can
>   see that on my system open gets called 3 times during boot-up.

It would. See below for my thought on this change.

> 
> * What are the circumstances the touch device would be in an other state? In the
>   official kernel driver the userspace can send commands via sysfs.
> Also the driver
>   does set the touch enable mode as this patch does.

I did this change as the device was once non-functional unexpectedly
because it wasn't in touch mode. We can set touch mode during open() or
probe() but I figured during open() would keep the driver working even
when others would use the device in command mode.

Does your problem go away when you revert this change or put it into
probe()?

                                  martin



________________________________________

Ginzinger electronic systems GmbH
Gewerbegebiet Pirath 16
4952 Weng im Innkreis
www.ginzinger.com

Firmenbuchnummer: FN 364958d
Firmenbuchgericht: Ried im Innkreis
UID-Nr.: ATU66521089
