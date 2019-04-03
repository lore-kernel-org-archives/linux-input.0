From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ELAN touchpad i2c_hid bugs fix
Date: Wed, 3 Apr 2019 13:18:23 +0200
Message-ID: <a58ebeb8-10fd-29d0-1562-4ed8d84f2239@redhat.com>
References: <20190325125704.6585-1-hotwater438@tutanota.com>
 <CAE_wzQ8Aep1FOONeCUxvjBFbgKcVRWP5mUuwQnDxzfemUw-eaA@mail.gmail.com>
 <a2952bc4-0ad0-c8a0-5a5b-13a279023455@redhat.com>
 <CAE_wzQ8sYcMVYLmnctw_UQuvn0B8U2CU2dNeg-9sh85AL_CfgQ@mail.gmail.com>
 <abe3eccb-1490-e088-1fd8-6af4dc1bd2ec@redhat.com> <LbI7kio--3-1@tutanota.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <LbI7kio--3-1@tutanota.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: hotwater438@tutanota.com
Cc: Dmitry Torokhov <dtor@chromium.org>, Vladislav Dalechyn <vlad.dalechin@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Kai Heng Feng <kai.heng.feng@canonical.com>, Swboyd <swboyd@chromium.org>, Bigeasy <bigeasy@linutronix.de>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi,

On 31-03-19 11:50, hotwater438@tutanota.com wrote:
> Hi. I've done everything you said, here are results:
> 
>     Vladislav can you check the output of /cat/interrupts on a kernel
>     without the patch and while *not* using the touchpad; and check
>     if the amount of touchpads-interrupts still keeps increasing in this
>     case?
> 
> IWI or IRQ work interrupts keep increasing with speed at least 3 interrupts/s.

I'm really only interested in the touchpad related IRQs, so e.g. the line
about "intel-gpio  129  ELAN1200:00", if you're seeing 3 interrupts/s on
some others that is fine, so I take it the ELAN1200:00 interrupt count
does not increase on an *unpatched* kernel, unless you use the touchpad?

> Also when I am moving touchpad IR-IO-APIC 14-fasteoi INT345D:00 get's triggered and increased.

That is the GPIO controller interrupt, so that one increasing is normal.

If I understand things correctly then this all means that the IRQ indeed
is a normal level IRQ and Dmitry is likely correct that there is an
pinctrl / gpiochip driver problem here.

Can you try the following with an *unpatched* kernel? :

1) Run "cat /proc/interrupts | grep ELAN" , note down the value
2) Very quickly/briefly touch the touchpad once
3) Run "cat /proc/interrupts | grep ELAN" , note down the value again
4) Subtract result from 1. from result from 3, this difference is
    the value we are interested in. E.g. my testing got 254 and 257, so
    a difference of 3.

The goal here is to get an as low as possible difference. Feel free
to repeat this a couple of times.

On an Apollo Lake laptop with an I2C hid mt touchpad I can get the
amount of interrupts triggered for a single touch down to 3,
given the huge interrupt counts of 130000+ reported in:
https://bugzilla.redhat.com/show_bug.cgi?id=1543769

I expect you to get a much bigger smallest possible difference
between 2 "cat /proc/interrupts | grep ELAN" commands, note a
difference of 0 means your touch did not register.

Assuming you indeed see much more interrupts for a very quick
touch + release, then we indeed have an interrupt handling problem
we need to investigate further.

> I don't know if it's important or not, but for some reason these interrupts keep popping only on CPU2 (i have 4cpu processor).

That does not matter.

>     1) Suspending the machine by selecting suspend from a menu in your
>     desktop environment, or by briefly pressing the power-button, do
>     not close the lid
>     2) As soon as the system starts suspending and while it is suspended, move
>     your finger around the touchpad
>     3) Wake the system up with the powerbutton while moving your finger around
>     4) Check if the touchpad still works after this
> 
> It works, but as it seems, looses edge. JournalCTL is being flooded with i2c_hid_get_input: incomplete report (16/65535)

That is probably a different issue. If you loose the edge IRQ, then the touchpad
would stop working without any messages. I believe that the suspend / resume
issue may be fixed by:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=52cf93e63ee672a92f349edc6ddad86ec8808fd8

Does your kernel have this commit?  (please always use the latest kernel while
testing).

> Also a thing to notice, that after manually removing and modprobing i2c_hid module, it says next in journalctl:
> 
> i2c_hid i2c-ELAN1200:00: i2c-ELAN1200:00 supply vdd not found, using dummy regulator
> i2c_hid i2c-ELAN1200:00: i2c-ELAN1200:00 supply vddl not found, using dummy regulator

Those messages can safely be ignored.

Regards,

Hans
