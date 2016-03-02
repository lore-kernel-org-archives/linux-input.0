From: sergk sergk2mail <sergk.admin@gmail.com>
Subject: Re: How to use ACPI for touchscreen
Date: Wed, 2 Mar 2016 18:13:27 +0000
Message-ID: <CA+V1LzoiheCTZRv9xS=f_aTLkb27vw0aha=otYy=eiwOPB52+Q@mail.gmail.com>
References: <CA+V1LzqohgdNChrBUO+VqUiPD-9gPGvSCiu0t3L7aUk5dRyD1w@mail.gmail.com>
	<56D568C7.20203@gmail.com>
	<CA+V1LzohZr1ryibyS+YQ75D8-txQaiYU5qo2CNWTKS2kwn53dg@mail.gmail.com>
	<CA+V1Lzp8pEtiwH-EWJiDCu=oFpXO9N2SEM5UbSqi5-mxgwsiTg@mail.gmail.com>
	<20160302175232.GC4318@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:32943 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755336AbcCBSNd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Mar 2016 13:13:33 -0500
Received: by mail-qg0-f41.google.com with SMTP id t4so19177579qge.0
        for <linux-input@vger.kernel.org>; Wed, 02 Mar 2016 10:13:28 -0800 (PST)
In-Reply-To: <20160302175232.GC4318@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org

"Why do you think that mlsfw in modalias string has anything to do with
loading firmware? I must have misunderstood your statement..."

Hi Dmitriy,
  Its rather guessing based on such disovering: On Chuwi Vi10 rev 11
under Android the only touch related module that is loaded is
atmel_mxt_ts while I exactly know (and have firmware too) that in this
tablet there is Chipone icn8528.h.   (drivers from Windows + dmesg
provs this).
When you rmmod atmel_mxt_ts the touch still continues to work! I guess
someone just used atmel_mxt_ts probably as prototype for detecting
(wake uping) chip and loading its firmware and after - no need in any
module. According specs of Chipone icn85xx it looks that it even has
corresponding mode - to be initialized from firmware and work after
with it. It looks weird, but this is the clevest explanation that I
could provide - I never seen before such behaviour in Android when
there is no dedicated driver for touch screen.

In anyway - this is only curiousity, the main goal is simple - to
create a driver for icn85xx that wakeup it and loads firmware.
I have specs, I have firmware, there is for arm open source drivers
(including firmware in .h file):
https://github.com/bbelos/rk3188-kernel/blob/master/drivers/input/touchscreen/ICN8503/icn85xx.c

Current problem - I could not wake up the chip to obtain its permanent
presence on i2c-bus.
Regards,
                Serge Kolotylo.

On Wed, Mar 2, 2016 at 5:52 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tue, Mar 01, 2016 at 04:55:02PM +0000, sergk sergk2mail wrote:
>> In addition this touch is used like so:
>>
>> dmesg | grep chipone:
>> <6> : input: chipone-ts as /devices/virtual/input/input3
>> cat /devices/virtual/input/input3/modalias gives
>>
>> input:b000v0000p0000e0000-e0,1,3,k8B,9E,D9,ra2F,30,32,35,36,39,m1sfw
>> - I guess the key is m1sfw which means loaded firmware.
>
> Why do you think that mlsfw in modalias string has anything to do with
> loading firmware? I must have misunderstood your statement...
>
> Thanks.
>
> --
> Dmitry
