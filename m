From: Jason Wessel <jason.wessel@windriver.com>
Subject: Re: [Nouveau] [PATCH] drm/nouveau/kms: Implement
 KDB debug hooks for nouveau KMS.
Date: Fri, 24 Sep 2010 15:58:27 -0500
Message-ID: <4C9D10F3.10105@windriver.com>
References: <m3iq9yqd7w.fsf@pullcord.laptop.org>
	<4C5ACF3F.8050409@windriver.com>
	<m3hbj0fju3.fsf_-_@pullcord.laptop.org>
	<m3aaoimqrp.fsf_-_@pullcord.laptop.org>
	<1283335002.2741.5.camel@maxim-laptop>
	<4C7E3A73.5070503@windriver.com>
	<1283424363.2736.1.camel@maxim-laptop>
	<1285119735.5949.5.camel@maxim-laptop>
	<1285164198.3159.8.camel@maxim-laptop>
	<1285164387.3159.10.camel@maxim-laptop>
	<1285175225.2960.10.camel@maxim-laptop>
	<1285361406.4509.0.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kgdb-bugreport-bounces@lists.sourceforge.net>
In-Reply-To: <1285361406.4509.0.camel@maxim-laptop>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport>,
	<mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kgdb-bugreport>
List-Post: <mailto:kgdb-bugreport@lists.sourceforge.net>
List-Help: <mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport>,
	<mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=subscribe>
Errors-To: kgdb-bugreport-bounces@lists.sourceforge.net
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: David Airlie <airlied@linux.ie>, kgdb-bugreport@lists.sourceforge.net, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On 09/24/2010 03:50 PM, Maxim Levitsky wrote:
>   
>> [Dropped nouveau list, because this is offtopic there]
>>
>> I pretty much got to the bottom of this.
>> There are 2 separate issues:
>>
>>
>> 1. SysRq handler is now a input 'filter', which means that it can 'eat'
>> input events, so they don't show up on input bus.
>> It does so while sysrq key is down.
>> So sysrq and 'g' events never reach the kernel kbd driver and therefore
>> the hack to release them doesn't work.
>>
>> 2. The kbd_clear_keys_helper injects the keyup events alright, but it
>> doesn't inject SYN events, and therefore X evdev driver doesn't pick
>> these injected events untill next SYN event. 
>>
>> This patch makes key release work in expense of showing sysrq key to userspace, which isn't that good,
>> because now Alt+SysRQ causes a screen capture by default.
>> In my opinion the sysrq filter should stay.
>> We should just make kdb hook into atkbd and do the key release there.
>> This should both result in cleaner/more robust code, and make this issue disappear.
>> I'll look at doing that.
>>
>>
>> diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
>> index 0c6c641..7df6af5 100644
>> --- a/drivers/char/keyboard.c
>> +++ b/drivers/char/keyboard.c
>> @@ -368,6 +368,7 @@ static int kbd_clear_keys_helper(struct input_handle *handle, void *data)
>>  {
>>  	unsigned int *keycode = data;
>>  	input_inject_event(handle, EV_KEY, *keycode, 0);
>> +	input_inject_event(handle, EV_SYN, SYN_REPORT, 0);
>>  	return 0;
>>  }
>>  
>> diff --git a/drivers/char/sysrq.c b/drivers/char/sysrq.c
>> index ef31bb8..db1eb12 100644
>> --- a/drivers/char/sysrq.c
>> +++ b/drivers/char/sysrq.c
>> @@ -601,7 +601,7 @@ static bool sysrq_filter(struct input_handle *handle, unsigned int type,
>>  	}
>>  
>>  out:
>> -	return sysrq_down;
>> +	return 0;
>>  }
>>  
>>  static int sysrq_connect(struct input_handler *handler,
>>
>>
>> Best regards,
>> 	Maxim Levitsky
>>
>>     

Hi Maxim,

Is it the case that this patch takes care of masking the sysrq event
from user space?

Originally before it became an input filter I had a patch to the
keyboard.c to completely consume the keypress of the sysrq-g.

I have been less than successful at getting the keyboard changes
upstreamed, and I was probably going to ping AKPM, because on that front
I had not received any kind of response either (linux-input that is).

Certainly I can carry your patch in my branch until we can determine a
final upstream design.

Thanks,
Jason.

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
