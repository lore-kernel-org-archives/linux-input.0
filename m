From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] Input: i8042 - Fix KBD port cannot wake up system from
 suspend-to-idle
Date: Tue, 17 Apr 2018 14:48:56 +0800
Message-ID: <9F493625-24C6-4FBD-9179-5C74C8CE441D@canonical.com>
References: <20180411085905.22272-1-kai.heng.feng@canonical.com>
 <20180413215746.GA27465@dtor-ws>
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180413215746.GA27465@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

at 5:57 AM, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Wed, Apr 11, 2018 at 04:59:05PM +0800, Kai-Heng Feng wrote:
>> Commit f13b2065de81 ("Input: i8042 - allow KBD and AUX ports to wake up
>> from suspend-to-idle") make system in s2idle can be woken up by i8042
>> keyboard, but it's disabled by default.
>>
>> In commit 3e6e15a862a0 ("Input: enable remote wakeup for PNP i8042
>> keyboard ports") states that "Keyboard ports are always supposed to be
>> wakeup-enabled", it should be enabled by default. Keyboard wakeup from
>> s2idles is also the default behavior for other OSes.
>>
>> But right now we can't wake up the system by keyboard, from s2idle.
>>
>> In i8042_probe(), device_set_wakeup_enable(), which gets called by
>> i8042_pnp_kbd_probe(), runs before device_set_wakeup_capable(), which
>> gets called by i8042_register_ports(). So device_set_wakeup_enable()
>> doesn't really enable wakeup for keyboard.
>
> You are talking about 2 different devices here, one representing PNP and
> another KBD serio port. Unfortunately there is not really a link between
> the 2.

Thanks for the clarification. I can see the difference now.

Enable wakeup for the serio device is what we want here.

So does the device_set_wakeup_enable() in i8042_pnp_kbd_probe() need  
another device_set_wakeup_capable()?
Otherwise I think device_set_wakeup_enable() here never works.

>
>> We can enable keyboard wakeup in i8042_register_ports() directly.
>
> No, the world is not all x86, what makes sense for x86 does not
> necessarily work for other architectures. We need to come up with a way
> for tying PNP devices and i8042 ports for x86 case.

Maybe wrap it around with "#ifdef CONFIG_X86"? I can see there are several  
occurrences in the i8042.c.

Kai-Heng

>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>>  drivers/input/serio/i8042-x86ia64io.h | 3 ---
>>  drivers/input/serio/i8042.c           | 4 ++++
>>  2 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/input/serio/i8042-x86ia64io.h  
>> b/drivers/input/serio/i8042-x86ia64io.h
>> index b353d494ad40..e3def9195c2a 100644
>> --- a/drivers/input/serio/i8042-x86ia64io.h
>> +++ b/drivers/input/serio/i8042-x86ia64io.h
>> @@ -925,9 +925,6 @@ static int i8042_pnp_kbd_probe(struct pnp_dev *dev,  
>> const struct pnp_device_id *
>>  	i8042_pnp_id_to_string(dev->id, i8042_kbd_firmware_id,
>>  			       sizeof(i8042_kbd_firmware_id));
>>
>> -	/* Keyboard ports are always supposed to be wakeup-enabled */
>> -	device_set_wakeup_enable(&dev->dev, true);
>> -
>>  	i8042_pnp_kbd_devices++;
>>  	return 0;
>>  }
>> diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
>> index 824f4c1c1f31..21a16b757931 100644
>> --- a/drivers/input/serio/i8042.c
>> +++ b/drivers/input/serio/i8042.c
>> @@ -1400,6 +1400,10 @@ static void __init i8042_register_ports(void)
>>  				i8042_ports[i].irq);
>>  			serio_register_port(serio);
>>  			device_set_wakeup_capable(&serio->dev, true);
>> +
>> +			/* Keyboard ports are always supposed to be wakeup-enabled */
>> +			if (i == I8042_KBD_PORT_NO)
>> +				device_wakeup_enable(&serio->dev);
>>  		}
>>  	}
>>  }
>> -- 
>> 2.17.0
>
> Thanks.
>
> -- 
> Dmitry
