From: Pedro Vanzella <pedro@pedrovanzella.com>
Subject: Re: [Resubmit] Read battery voltage from Logitech Gaming mice
Date: Fri, 23 Aug 2019 10:22:14 -0400
Message-ID: <e6014a01-1094-9ec7-9b37-2abdf70e305f@pedrovanzella.com>
References: <20190822201849.28924-1-pedro@pedrovanzella.com>
 <CAO-hwJKQcTpmk8cVf-YmKu2awXv_53=qfpy2yfmy2rgMu_DEug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJKQcTpmk8cVf-YmKu2awXv_53=qfpy2yfmy2rgMu_DEug@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, =?UTF-8?Q?Filipe_La=c3=adns?= <lains@archlinux.org>, Jiri Kosina <jikos@kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Benjamin,

On 8/23/19 4:25 AM, Benjamin Tissoires wrote:
> Hi Pedro,
> 
> On Thu, Aug 22, 2019 at 10:19 PM Pedro Vanzella <pedro@pedrovanzella.com> wrote:
>>
>> Resumitting this after having rebased it against the latest changes.
> 
> thanks for resubmitting. Sorry I wasn't able to provide feedback on
> the last revision
> 

No worries, I know how these things are.

>>
>> The gaming line of Logitech devices doesn't use the old hidpp20
>> feature for battery level reporting. Instead, they report the
>> current voltage of the battery, in millivolts.
>>
>> This patch set handles this case by adding a quirk to the
>> devices we know to have this new feature, in both wired
>> and wireless mode.
> 
> So the quirk is in the end a bad idea after all. I had some chats with
> Filipe that made me realize this.

I actually resubmitted by Filipe's request, since the patches weren't 
applying cleanly anymore. The idea was to apply these patches and in the 
future refactor the code to use the feature discovery routines.

> Re-reading our previous exchanges also made me understood why I wasn't
> happy with the initial submission: for every request the code was
> checking both features 0x1000 and 0x1001 when we can remember this
> once and for all during hidpp_initialize_battery().

Yeah I wasn't too happy about this either, but since there was nothing 
prohibiting some device to have both features enabled, I thought this 
wasn't too horrible.

> 
> So I think we should remove the useless quirk in the end (bad idea
> from me, I concede), and instead during hidpp_initialize_battery() set
> the correct HIDPP_CAPABILITY_*.
> Not entirely sure if we should try to call 0x1000, or 0x1001 or if we
> should rely on the 0x0001 feature to know which feature is available,
> but this should be implementation detail.

I like the idea of calling 0x0001 once on device boot much better. I 
think we could easily just fetch the location for the features we know 
about and want to deal with once only. This also makes sure we support 
every single device that supports this feature, so that is a huge plus.

In fact, I think we should _not_ call 0x0001 on battery init, but only 
call battery init _after_ we called 0x0001 and discovered either 0x1000 
or 0x1001 (or the solar battery feature, or any other one that might 
crop up in the feature).

> 
>>
>> This version of the patch set is better split, as well as adding the
>> quirk to make sure we don't needlessly probe every device connected.
> 
> It is for sure easy to review, but doesn't make much sense in the end.
> I think we should squash all the patches together as you are just
> adding one feature in the driver, and it is a little bit disturbing to
> first add the quirk that has no use, then set up the structs when they
> are not used, and so on, so forth.

You're right. My first instinct was to send a single patch. As much as I 
tested this, I always feel like breaking the patch up post-facto will 
break a git bisect in the future and everyone will hate me :P

So we (you, me and Filipe) should probably come up with an action plan 
here. The way I see it there are two issues here: one is adding this 
feature, and the other is refactoring to use feature discovery for all 
features. There are advantages and disadvantages to doing one or another 
first and we might want to discuss that.

By merging this first (probably after I resubmit it as a single squashed 
patch) we get to test it a bit better and have a usable feature sooner. 
Plenty of people have been requesting this and there is plenty of stuff 
that can be built on top of it, but only once this is actually merged I 
think.

On the other hand, by first refactoring the rest of the code to use 
0x0001 we avoid some rework on this patch. It should be minor, as most 
functions here do all the heavy lifting after the initial feature 
discovery, and are thus mostly independent from how that is done.

I'm happy either way, so just let me know what you guys decide.

If you guys (or anyone else reading this on the public list, really) has 
any input - naming things being notoriosly hard, I'm actually happy with 
nitpicking - I'd appreciate it. On that note, come to think of it, I'm 
not 100% sure reporting the voltage in milivolts is the standard way. I 
looked through the docs, but found no solid guideline. It was either 
that or a float, so I think I made the right call here, but still.

- Pedro

> 
> Cheers,
> Benjamin
> 
>>
>>
