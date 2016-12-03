From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: Re: [PATCH] Input: touchscreen: edt_ft5x06 - change msleep to
 usleep_range for small msecs
Date: Sat, 3 Dec 2016 23:47:22 +0530
Message-ID: <CADYu309AZ_pj_ssVqPV+sXjW8fqMKTXwL_EoTBgLg2K1Ci614Q@mail.gmail.com>
References: <1480358514-2894-1-git-send-email-a.mathur@samsung.com>
 <CAOXgUe1MULGQZJ=pNsSKrvVcCFptVn5b2Qafjao1_xrxVYn0JQ@mail.gmail.com> <d95fa514-6e3f-1eb3-8204-60a7d7df494d@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34875 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbcLCSRZ (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 3 Dec 2016 13:17:25 -0500
In-Reply-To: <d95fa514-6e3f-1eb3-8204-60a7d7df494d@kernelconcepts.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Budig <simon.budig@kernelconcepts.de>
Cc: Aniroop Mathur <a.mathur@samsung.com>, daniel.wagener@kernelconcepts.de, LW@karo-electronics.de, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, SAMUEL SEQUEIRA <s.samuel@samsung.com>, Rahul Mahale <r.mahale@samsung.com>

Hello Mr. Simon,

On Sat, Dec 3, 2016 at 10:58 PM, Simon Budig
<simon.budig@kernelconcepts.de> wrote:
> Hello Mr, Mathur.
>
> On 29/11/16 21:54, Aniroop Mathur wrote:
>> I have submitted one patch as below for review to Linux Open Source.
>> The problem is that we do not have the hardware available with us to
>> test it and we would like to test it before actually applying it.
>> As you are the author of this driver, I am contacting you to request you=
 to
>> provide your feedback upon this patch.
>>
>> Also if you have the hardware available, could you please help to
>> test this patch on your hardware? or could you provide contact points
>> of individuals who could support to test it?
>
> My first question regarding the patch is: What is your motivation for
> doing this change? Did you actually encounter any problems with some
> touch hardware? Or is this a part of a global search/replace mission
> across the linux kernel?
>

Well firstly, I decided to change this as it is recommended and mentioned
in the kernel documentation to use usleep_range over msleep for 1 - 10
ms delays. Secondly, we found problems in response time in our sensor
drivers because there is need to give delays after some register initializa=
tion
to make the device work properly.and when we changed to usleep_range
we got decent results like first sensor data was generated faster than befo=
re
indeed. Since I work on input/iio device drivers so I decided to make same
changes in other input subsystem drivers as well.

> The change is in a function that is pretty irrelevant for most users of
> the driver: reading out raw sensor data, which is only available for
> EDT's M06 models of the touchscreen. I am actually tempted to remove
> this stuff, since it never really provided helpful for us in debugging
> touch screen problems, and adds a certain amount of complexity to the
> driver.
>
> I don't have a setup for the hardware readily available at the moment,
> so I can't currently help you there. But from reading the patch it seems
> pretty harmless and from my point of view there is nothing that speaks
> against incorporating that patch. On the other hand I don't see a lot
> that speaks in favor of it.
>
> *shrug*
>

I guess, reviewing the patch for this change should be okay. Thanks!

Since here we are using msleep(1) which is worse as it sleeps for
minimum two jiffies so 20 ms on HZ=3D100 system and we are doing here
100 retries if register reading fails. So as you can deduce usleep_range
will serve better here.
Explained originally here why to not use msleep for 1-20ms:
http://lkml.org/lkml/2007/8/3/250

BR,
Aniroop Mathur


> Bye,
>         Simon
> --
>      kernel concepts GmbH                 Simon Budig
>      Sieghuetter Hauptweg 48              simon.budig@kernelconcepts.de
>      D-57072 Siegen                       +49-271-771091-17
>      http://www.kernelconcepts.de/
>      HR Siegen, HR B 9613; Gesch=C3=A4ftsf=C3=BChrer: Nils Faerber, Ole R=
einhardt
>
>
