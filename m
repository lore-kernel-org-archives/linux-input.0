From: jan <vereecke.jan@skynet.be>
Subject: Re: [PATCH] Patch enabling Fn function keys for Laptop Asus G730
 (keyboard 0x1869)
Date: Thu, 5 Jul 2018 21:02:27 +0200
Message-ID: <dc860e3a-c837-5571-95f4-e62065f1a7f4@vereecke.mooo.com>
References: <alpine.LNX.2.21.1806141112440.11126@Hermes.vereecke.mooo.com>
 <nycvar.YFH.7.76.1806251519190.6203@cbobk.fhfr.pm>
Reply-To: vereecke.jan@skynet.be
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.1806251519190.6203@cbobk.fhfr.pm>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, vereecke.jan@skynet.be
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, benjamin.tissoires@redhat.com
List-Id: linux-input@vger.kernel.org

On 25/06/2018 15:20, Jiri Kosina wrote:
> On Thu, 14 Jun 2018, vereecke.jan@skynet.be wrote:
>
>> Attached is a patch enabling (most of) the Fn function keys for the Asus ROG
>> Strix GL730 Laptop. The keyboard identifies as a USB device 0x1869.
>>
>> This patch enables:
>>      volume/mute keys, ROG key, rew/play/ff,
>>      monitor and keyboard brightness keys,
>>      Touchpad toggle key,
>>      Calculator key
>>
>> 'Touchpad on/off' Key returns keycode 33, which is mapped to the 'p' key.
>> 'Display on/off' returns keycode 253, which is mapped in X11 to NoSymbol
>> 'Airplane Key' returns keycode 255, which is mapped in X11 to NoSymbol
>>
>> The following keys are not activated yet:
>>         Microphone Mute key, Fan key, Display Switch key
> Thanks a lot for the patch.
>
>> This patch is against the 4.17-rc7 kernel, for the x86 architecture
> This usually doesn't go to the changelog, it'd be unnecessary polution of
> the set-in-stone git changelog.
>
>> diffstat for this patch is:
>>   hid-asus.c   |    2 ++
>>   hid-ids.h    |    1 +
>>   hid-quirks.c |    1 +
>>   3 files changed, 4 insertions(+)
>>
>> To apply the patch, in the root of the kernel tree use:
>> patch -p1 < AsusGL703-Keyboard-Fn-keys.patch
> Neither does any of this.
>
> What is OTOH missing is your signoff.
>
> Could you please fix these up and resubmit (ideally with Subject: line
> also tailored to fit the subsystem customs, IOW something like "HID: asus:
> add support for ....").
>
> Thanks,
>
Thanks for your reply. However, I am confused. Pleas bear with me as 
this is the very first time that I submit a patch and I followed some 
guidance that I found on the internet (obviously not the correct one).

I suppose I just need to delete the parts of the email where you write 
"this doesn't go in the changelog".

I am not sure what my signoff should contain. Could you point me to a 
correct guide for this ?

Thanks.
