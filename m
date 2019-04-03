From: Aaron Ma <aaron.ma@canonical.com>
Subject: Re: [PATCH 1/2] Input: synaptics-rmi4 - clear irqs before set irqs
Date: Wed, 3 Apr 2019 21:58:55 +0800
Message-ID: <9321df87-5bc5-0c75-2815-f8602ecf9d86@canonical.com>
References: <20190220164200.31044-1-aaron.ma@canonical.com>
 <17cd420ea32a9787c56ba25e36e7661541c2f65f.camel@synaptics.com>
 <a0f21198-5715-8858-8368-51e43092181e@canonical.com>
 <acd07f4d-1602-46c5-c486-c917f1868b59@canonical.com>
 <f4f7265d9ad06726bb2ef12ab6b7529d2fb06165.camel@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f4f7265d9ad06726bb2ef12ab6b7529d2fb06165.camel@synaptics.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christopher Heiny <Cheiny@synaptics.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org



On 4/3/19 12:16 AM, Christopher Heiny wrote:
> On Thu, 2019-03-28 at 14:02 +0800, Aaron Ma wrote:
>> Hi Dmitry and Chiristopher:
>>
>> Do you have any suggestion about these 2 patches?
>>
>> Many users confirmed that they fixed issues of Trackpoint/Touchpad
>> after S3.
>>
>> Will you consider them be accepted?
> Hi Aaron,
> 
> Sorry - I thought I'd replied on the NO SLEEP portion of these patches,
> but looking back I don't find the draft or the sent email.  Sorry about
> that.  I'll summarize here what I wrote last month.
> 
> This isn't so much a "fix" as a "hacky workaround" for the issue.  From
> the descriptions in the bug you linked in your original patch
> submission, it appears that the root cause is somewhere in SMBus system
> (could be SMBus driver, SMBus hardware, or the devices on the SMBus
> (touch devices or other devices) - it's hard to tell with the info
> available), where the SMBus is failing to come online correctly coming
> out of S3 state.  Anyway, this patch doesn't fix the root cause, but
> merely works around it.

Users confirmed the 1st patch that clear irq status fixed their multiple
issues on Touchpad and Trackpoint.
I think it is a fix.

NO SLEEP patch was tried to give users a choice a fix touchpad issues
that I didn't reproduce.
If you don't like this export, we can drop it now as users confirmed 1st
patch works.

> 
> Setting the NO SLEEP bit will force the touch sensor to remain in a
> high power consumption state while the rest of the system is in S3. 
> While not a lot of power compared to things like the CPU, display, and
> others, it is still non-trivial and will result in shorter time-on-
> battery capability.

Verified on s2idle and S3 and system running idle mode. no difference on
power consumption of whole system with or without set 1 to nosleep.

> 
> If you have access to the power pin(s) for the touch sensor(s)/styk(s),
> it might be interesting to try turning power off on entering S3, and
> restoring it on exit.  That's very hacky, and has the side effect of
> slightly delaying touchpad readiness on exit from S3.  Plus you'll need
> to restore touch sensor configuration settings on exit.  But it
> definitely reduces power consumption.
> 
> 
> Separately, I am still concerned about the possibility of dropped touch
> events in the IRQ clearing.  I'm not convinced that the code is safe
> (as you mentioned in your reply to my earlier comment), so I'll have to
> study the implementation more carefully.

Sure, take your time, if you have any questions let me know please.

Thanks,
Aaron

> 
> 					Cheers,
> 						Chris
> 
> 
> 
>> Thanks,
>> Aaron
> 
