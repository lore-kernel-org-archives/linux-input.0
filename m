From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] ELAN touchpad i2c_hid bugs fix
Date: Tue, 16 Apr 2019 11:59:42 +0800
Message-ID: <31D4FB07-B7E4-4A51-B191-44F92B229CB4@canonical.com>
References: <CAE_wzQ8Aep1FOONeCUxvjBFbgKcVRWP5mUuwQnDxzfemUw-eaA@mail.gmail.com>
 <a2952bc4-0ad0-c8a0-5a5b-13a279023455@redhat.com>
 <CAE_wzQ8sYcMVYLmnctw_UQuvn0B8U2CU2dNeg-9sh85AL_CfgQ@mail.gmail.com>
 <abe3eccb-1490-e088-1fd8-6af4dc1bd2ec@redhat.com> <LbI7kio--3-1@tutanota.com>
 <a58ebeb8-10fd-29d0-1562-4ed8d84f2239@redhat.com> <LbZjy9p--3-1@tutanota.com>
 <B7A141A3-613C-4EB8-8BB4-F845A0AC8F23@canonical.com>
 <LcKqhgD--3-1@tutanota.com>
 <385F448C-463D-4EF0-BCFB-8386D043F189@canonical.com>
 <LcVmBjG--3-1@tutanota.com> <b495a521-16b5-8005-16be-e0b899f954f7@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b495a521-16b5-8005-16be-e0b899f954f7@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: hotwater438@tutanota.com, Dmitry Torokhov <dtor@chromium.org>, Vladislav Dalechyn <vlad.dalechin@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Swboyd <swboyd@chromium.org>, Bigeasy <bigeasy@linutronix.de>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

at 19:42, Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
>
> On 15-04-19 13:36, hotwater438@tutanota.com wrote:
>> Sorry for the delay.
>> By applying this patch I get next results:
>> Five finger tap and two finger scroll issues disappear, but after  
>> suspend touchpad dies. Restarting module doesn't help.
>
> So bascally the same results as with the edge-triggered interrupt  
> patch/hack,
> right?
>
> Are you still using the edge-triggered interrupt patch, or just the new
> patch Kai-Heng Feng provided.
>
> To me it sounds like the patch Kai-Heng Feng provided at least removes
> the need for the edge-triggered interrupt patch/hack and what remains to
> be solved is the suspend/resume issues.

Great! I’ll send a patch to address this issue.

Kai-Heng

>
> Regards,
>
> Hans
>
>
>
>> Here's the log:
>> Apr 15 14:35:54 parrot sudo[3473]: h0tw4t3r : TTY=pts/1 ;  
>> PWD=/home/h0tw4t3r ; USER=root ; COMMAND=/sbin/rmmod i2c_hid
>> Apr 15 14:35:54 parrot sudo[3478]: h0tw4t3r : TTY=pts/1 ;  
>> PWD=/home/h0tw4t3r ; USER=root ; COMMAND=/sbin/modprobe i2c_hid
>> Apr 15 14:35:54 parrot kernel: i2c_hid i2c-ELAN1200:00: i2c-ELAN1200:00  
>> supply vdd not found, using dummy regulator
>> Apr 15 14:35:54 parrot kernel: i2c_hid i2c-ELAN1200:00: i2c-ELAN1200:00  
>> supply vddl not found, using dummy regulator
>> Could you please explain what this patch does?
>> Regards,
>> Vladislav.
>> Apr 13, 2019, 11:42 AM by kai.heng.feng@canonical.com:
>>     at 16:40, <hotwater438@tutanota.com <mailto:hotwater438@tutanota.com>> <hotwater438@tutanota.com <mailto:hotwater438@tutanota.com>> wrote:
>>         Hi.
>>         I've applied this patch, but still getting incomplete report messages.
>>     Does the patch fix the other two issues:
>>     - Five finger tap kill's module so you have to restart it;
>>     - Two finger scoll is working incorrect and sometimes even when you
>>     raised one of two finger still thinks that you are scrolling.
>>     Kai-Heng
>>         Regards,
>>         Vladislav
>>         Apr 11, 2019, 7:17 PM by kai.heng.feng@canonical.com <mailto:kai.heng.feng@canonical.com>:
>>         Hi,
>>         at 05:18, <hotwater438@tutanota.com <mailto:hotwater438@tutanota.com>> <hotwater438@tutanota.com <mailto:hotwater438@tutanota.com>> wrote:
>>         Hi.
>>         1) Run "cat /proc/interrupts | grep ELAN" , note down the value
>>         2) Very quickly/briefly touch the touchpad once
>>         3) Run "cat /proc/interrupts | grep ELAN" , note down the value again
>>         4) Subtract result from 1. from result from 3, this difference is
>>         the value we are interested in. E.g. my testing got 254 and 257, so
>>         a difference of 3.
>>         I've tested that, main diffs are 30, 24, 16 (the most frequent), 2 (the least frequent).
>>         I was using 4.19.13 kernel, because I use ParrotOS (which happens to be Debian distribution).
>>         But I've installed experimental 5.0.0 kernel and I can't say right now if suspend problem is resolved (i have to rebuild latest kernel with patch).
>>         Can you try below fix?
>>         This can solve what commit 1475af255e18 ("HID: i2c-hid: Ignore input report if there's no data present on Elan touchpanels”) tries to workaround.
>>         diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
>>         index c19a4c45f7bb..30e3664f1ae5 100644
>>         --- a/drivers/pinctrl/intel/pinctrl-intel.c
>>         +++ b/drivers/pinctrl/intel/pinctrl-intel.c
>>         @@ -957,6 +957,10 @@ static void intel_gpio_irq_mask_unmask(struct irq_data *d, bool mask)
>>         reg = community->regs + community->ie_offset + gpp * 4;
>>         raw_spin_lock_irqsave(&pctrl->lock, flags);
>>         +
>>         + if (!mask)
>>         + writel(BIT(gpp_offset), community->regs + community->is_offset + gpp * 4);
>>         +
>>         value = readl(reg);
>>         if (mask)
>>         value &= ~BIT(gpp_offset);
>>         Regards,
>>         Vladislav.
>>         Apr 3, 2019, 2:18 PM by hdegoede@redhat.com <mailto:hdegoede@redhat.com>:
>>         Hi,
>>         On 31-03-19 11:50, hotwater438@tutanota.com <mailto:hotwater438@tutanota.com> wrote:
>>         Hi. I've done everything you said, here are results:
>>         Vladislav can you check the output of /cat/interrupts on a kernel
>>         without the patch and while *not* using the touchpad; and check
>>         if the amount of touchpads-interrupts still keeps increasing in this
>>         case?
>>         IWI or IRQ work interrupts keep increasing with speed at least 3 interrupts/s.
>>         I'm really only interested in the touchpad related IRQs, so e.g. the line
>>         about "intel-gpio 129 ELAN1200:00", if you're seeing 3 interrupts/s on
>>         some others that is fine, so I take it the ELAN1200:00 interrupt count
>>         does not increase on an *unpatched* kernel, unless you use the touchpad?
>>         Also when I am moving touchpad IR-IO-APIC 14-fasteoi INT345D:00 get's triggered and increased.
>>         That is the GPIO controller interrupt, so that one increasing is normal.
>>         If I understand things correctly then this all means that the IRQ indeed
>>         is a normal level IRQ and Dmitry is likely correct that there is an
>>         pinctrl / gpiochip driver problem here.
>>         Can you try the following with an *unpatched* kernel? :
>>         1) Run "cat /proc/interrupts | grep ELAN" , note down the value
>>         2) Very quickly/briefly touch the touchpad once
>>         3) Run "cat /proc/interrupts | grep ELAN" , note down the value again
>>         4) Subtract result from 1. from result from 3, this difference is
>>         the value we are interested in. E.g. my testing got 254 and 257, so
>>         a difference of 3.
>>         The goal here is to get an as low as possible difference. Feel free
>>         to repeat this a couple of times.
>>         On an Apollo Lake laptop with an I2C hid mt touchpad I can get the
>>         amount of interrupts triggered for a single touch down to 3,
>>         given the huge interrupt counts of 130000+ reported in:
>>         https://bugzilla.redhat.com/show_bug.cgi?id=1543769
>>         I expect you to get a much bigger smallest possible difference
>>         between 2 "cat /proc/interrupts | grep ELAN" commands, note a
>>         difference of 0 means your touch did not register.
>>         Assuming you indeed see much more interrupts for a very quick
>>         touch + release, then we indeed have an interrupt handling problem
>>         we need to investigate further.
>>         I don't know if it's important or not, but for some reason these interrupts keep popping only on CPU2 (i have 4cpu processor).
>>         That does not matter.
>>         1) Suspending the machine by selecting suspend from a menu in your
>>         desktop environment, or by briefly pressing the power-button, do
>>         not close the lid
>>         2) As soon as the system starts suspending and while it is suspended, move
>>         your finger around the touchpad
>>         3) Wake the system up with the powerbutton while moving your finger around
>>         4) Check if the touchpad still works after this
>>         It works, but as it seems, looses edge. JournalCTL is being flooded with i2c_hid_get_input: incomplete report (16/65535)
>>         That is probably a different issue. If you loose the edge IRQ, then the touchpad
>>         would stop working without any messages. I believe that the suspend / resume
>>         issue may be fixed by:
>>         https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=52cf93e63ee672a92f349edc6ddad86ec8808fd8
>>         Does your kernel have this commit? (please always use the latest kernel while
>>         testing).
>>         Also a thing to notice, that after manually removing and modprobing i2c_hid module, it says next in journalctl:
>>         i2c_hid i2c-ELAN1200:00: i2c-ELAN1200:00 supply vdd not found, using dummy regulator
>>         i2c_hid i2c-ELAN1200:00: i2c-ELAN1200:00 supply vddl not found, using dummy regulator
>>         Those messages can safely be ignored.
>>         Regards,
>>         Hans
