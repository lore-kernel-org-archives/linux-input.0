From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] Input: Add Acer Aspire 5710 to nomux blacklist
Date: Fri, 11 Jul 2014 09:10:56 +0200
Message-ID: <53BF8E00.8030102@redhat.com>
References: <alpine.LNX.2.00.1406251139070.15939@pobox.suse.cz> <20140709165438.GC10364@core.coreip.homeip.net> <20140709174821.GA30912@suse.cz> <20140709193830.GE10364@core.coreip.homeip.net> <53BE4180.4030907@redhat.com> <20140710084551.GA26864@suse.cz> <53BEAF57.30409@redhat.com> <20140710211113.GB37059@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:17668 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751154AbaGKHLD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Jul 2014 03:11:03 -0400
In-Reply-To: <20140710211113.GB37059@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

Hi,

On 07/10/2014 11:11 PM, Dmitry Torokhov wrote:

<snip>

>>> I'm not aware of any current machines using active multiplexing for
>>> that. There are basically two touchpad manufacturers: Synaptics and
>>> ALPS.
>>
>> And elantech
>>
>>> Synaptics has a nearly transparent passthrough mode and
>>> touchpoints are connected through that. ALPS basically manufactures a
>>> touchpad+touchpoint combo device and thus doesn't need a fully
>>> transparent passthrough.
>>
>> Elantech now a days also produces a combo like alps.
> 
> They still wire it up internally and route all data through AUX port and
> not use active MUX for that.

Right, that is what I was trying to say with "like alps", sorry if that
was not clear. This was not meant as an argument against changing the
nomux default, just meant to complete the list.

<offtopic>

BTW while completing the list, there now is a new player called Focaltech,
used at least in the Asus X450 and Asus X550. These new devices don't
even work in mouse emulation mode unless psmouse.proto=bare is used.

I'm working on a pnp-id based patch to detect this and switch to
psmouse.proto=bare before we upset them (no idea about the native protocol)

Although native support would be better of course, so if anyone has a
contact at Focaltech that would be great.

But for some reason my patch ain't working. I'll send it upstream as soon
as I've worked out the kinks, this is being tracked here:
https://bugzilla.redhat.com/show_bug.cgi?id=1110011

</offtopic>

<snip>

>> One of the nice things about Linux is that in general we've pretty
>> decent support for older hardware, so if we decide to flip the nomux
>> default, I think we should really do so based on some BIOS cut-off
>> date, so as to not break older model laptops.
> 
> I think historically IBM and HPs had working MUX support while other's
> did might advertise support and fail miserably when we would try
> activating it.
> 
> Given that now majority of mice are USB even if we select wrong default
> on some older box I think it would be acceptable as opposed to a newer
> box not having touchpad at all...

I'm still not 100% sure if having some curt-off date would not be better,
but if you prefer just flipping the default everywhere lets go for that.

<semi-random-related-idea>

I guess that for anything except really really old boxes, the ps/2
will be part of the superio chip. super-io chips are relatively
easy to identify / probe in a safe manner. So do you know if the
ps/2 muxing is usually part of the super-io, or if it is an
extra chip?

If it is part of the superio then building a whitelist based on
superio ids may be an idea (once we get whitelist requests).

</semi-random-related-idea>

Regards,

Hans
