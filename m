From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: [PATCH v3 0/4] Make input drivers y2038 safe
Date: Mon, 4 Dec 2017 12:43:17 -0800
Message-ID: <CABeXuvrnySYBZ2_sDws8ur9Kfq3AFOWUHmV8EQjgJKHgknwB=A@mail.gmail.com>
References: <20171204005545.23325-1-deepa.kernel@gmail.com> <CAK8P3a3BwRFXZ-AMxmhjHrJVdrYfxrSGEw7QSkuJCBhS+Pu-LQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a3BwRFXZ-AMxmhjHrJVdrYfxrSGEw7QSkuJCBhS+Pu-LQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>
List-Id: linux-input@vger.kernel.org

On Mon, Dec 4, 2017 at 6:30 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Dec 4, 2017 at 1:55 AM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>> The series is aimed at making input events y2038 safe.
>> It extends the lifetime of the realtime timestamps in the
>> events to year 2106.
>> The series is also a necessary update as glibc is set to provide
>> 64 bit time_t support for 32 bit binaries. glibc plan is detailed
>> at https://sourceware.org/glibc/wiki/Y2038ProofnessDesign .
>>
>> The series is a result of discussions with Arnd Bergmann and
>> Dmitry Torokhov at last Plumbers.
>>
>> The plan is to deprecate realtime timestamps anyway as they
>> are not appropriate for these timestamps as noted in the patch
>> a80b83b7b8 by John Stultz.
>>
>> The design also updates the format of the input events read/ written
>> to the device nodes. This breaks 32 bit interface to the input
>> events at compile time as preferred by the maintainer.
>>
>> The userspace library changes to libevdev, libuinput and mtdev
>> will be posted to the respective mailing groups for review.
>
> Thanks a lot for following up on this!
>
> Just to clarify, the four patches are all independent of one another
> and can be applied in any order, right? I had some comments
> for some patches, and I don't want to hold up the other ones
> from getting merged this time.

There is some minor dependency between patches [2/4] and [3/4]. Patch
[3/4] might not apply cleanly without patch [2/4].
But, others are independent.

-Deepa
