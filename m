From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: Elantech SMBus support regression
Date: Wed, 12 Dec 2018 15:25:38 +0100
Message-ID: <CAO-hwJ+fshPj7xbJoBvK8uGrhfKCdFSmzicmmOyMJS0cdzAapQ@mail.gmail.com>
References: <6E2F161C-046B-4D5F-B831-B1308A554C40@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6E2F161C-046B-4D5F-B831-B1308A554C40@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai Heng Feng <kai.heng.feng@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi,

sorry for the late reply. I was always meaning to fix this the proper
way but couldn't dedicate a full day of work to go to the bottom of
elan_i2c.

Meanwhile, I am thinking at simply having a blacklist of devices that
we know are not working well (P52, L480, L580 and P72).

Could you get the value of /sys/bus/serio/devices/serio1/firmware_id
from all of these laptops?
I know the P52 is LEN2131, but I don't seem to find the other PNPIds.

Cheers,
Benjamin

On Thu, Nov 22, 2018 at 5:22 AM Kai Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Hi Benjamin,
>
> It appears the Elantech SMBus support breaks some users’ touchpad.
>
> Please have a look at [1] [2], thanks!
>
> [1] https://bugs.launchpad.net/bugs/1803600
> [2] https://bugs.archlinux.org/task/59714
>
> Kai-Heng
