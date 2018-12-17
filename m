From: Kai Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: Elantech SMBus support regression
Date: Mon, 17 Dec 2018 15:25:36 +0800
Message-ID: <A67BA4A8-7A32-4B80-AF90-B9D99E7D5582@canonical.com>
References: <6E2F161C-046B-4D5F-B831-B1308A554C40@canonical.com>
 <CAO-hwJ+fshPj7xbJoBvK8uGrhfKCdFSmzicmmOyMJS0cdzAapQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJ+fshPj7xbJoBvK8uGrhfKCdFSmzicmmOyMJS0cdzAapQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi,

> On Dec 12, 2018, at 22:25, Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
> 
> Hi,
> 
> sorry for the late reply. I was always meaning to fix this the proper
> way but couldn't dedicate a full day of work to go to the bottom of
> elan_i2c.
> 
> Meanwhile, I am thinking at simply having a blacklist of devices that
> we know are not working well (P52, L480, L580 and P72).
> 
> Could you get the value of /sys/bus/serio/devices/serio1/firmware_id
> from all of these laptops?
> I know the P52 is LEN2131, but I don't seem to find the other PNPIds.

These are feedbacks from the users:

L480:
cat /sys/bus/serio/devices/serio1/firmware_id
PNP: LEN2036 PNP0f13

P52:
"cat /sys/bus/serio/devices/serio1/firmware_id":
PNP: LEN2132 PNP0f13

So looks like it’s different to LEN2131.

Kai-Heng

> 
> Cheers,
> Benjamin
> 
> On Thu, Nov 22, 2018 at 5:22 AM Kai Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> 
>> Hi Benjamin,
>> 
>> It appears the Elantech SMBus support breaks some users’ touchpad.
>> 
>> Please have a look at [1] [2], thanks!
>> 
>> [1] https://bugs.launchpad.net/bugs/1803600
>> [2] https://bugs.archlinux.org/task/59714
>> 
>> Kai-Heng
