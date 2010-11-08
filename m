From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: ir-core and default IR maps
Date: Mon, 08 Nov 2010 11:09:59 -0200
Message-ID: <4CD7F6A7.8040206@redhat.com>
References: <AANLkTikfeu4DnV8E7rKahUdu2k_d08BOFZjLzBMRA2o+@mail.gmail.com>	<20101107060147.GC3823@core.coreip.homeip.net> <AANLkTinbTw26wTvbUVJU+sEGyH0DCt4WvmfO2_nvcLjR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52386 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752160Ab0KHNKG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 8 Nov 2010 08:10:06 -0500
In-Reply-To: <AANLkTinbTw26wTvbUVJU+sEGyH0DCt4WvmfO2_nvcLjR@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Jarod Wilson <jarod@redhat.com>

Em 07-11-2010 12:36, jonsmirl@gmail.com escreveu:
> On Sun, Nov 7, 2010 at 1:01 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> On Sat, Nov 06, 2010 at 06:08:57PM -0400, jonsmirl@gmail.com wrote:
>>> I thought about this some more and I think the default maps should
>>> stay in the drivers. The maps are marked __init so they don't take any
>>> room after they are loaded. This is an important piece and plug and
>>> play and we should keep it. Only the keymaps for default remote
>>> controls that ship with the specific hardware should be included in
>>> the driver. All other keymaps are in user space.
>>>
>>
>> Plug and play does not have to be implemented in kernel and udev is
>> perfectly capable doing it in userspace for us. Embedded products that
>> absolutely not want to ship udev and want to limit themselves to a
>> single vendor-supplied remote will have to adjust their startup scripts
>> to load the proper keymap.
> 
> I agree that it doesn't have to be implemented in the kernel. This is
> an ease of use decision, not a requirement.
> 
> For user space support either the end user has to be aware that after
> he buys the MSMCE he also has to install a user space package to make
> it work, or the distros always have to install the package.

IMO, the best solution is to have the package at distros. People need it
anyway, if they want to use webcams, as libv4l (part of v4l-utils) is a
requirement to decode webcam video streams (as most webcams don't use some
proprietary formats, and video applications rely on libv4l to decode those
unusual protocols).

This of course means that distro media packages like mplayer, vlc, lirc,
xine, etc should now require v4l-utils.

> For the kernel side I only see a maintenance issue. All of the keycode
> support is marked _init and vaporizes after boot so there is no
> run-time impact.

Unfortunately, I think that marking as _init won't work, as a device may be
removed/replugged.

> Another solution could be for the distros to add a distro specific
> default udev action that installs the package if the user starts using
> IR. This has to be distro specific since they all install things
> differently. What we need is a hardware triggered package install
> mechanism paralleling what happens with loadmodule. On windows it pops
> up and says - search for a driver - we don't have that on any Linux
> distribution I've used.

It would be an interesting idea, although this is not specific to IR devices.

Yet, I think that, if distros cover the usual cases (e. g. making sure that
v4l-utils will be installed to the media applications), this will cover all
the common cases.

> If we don't have something like this the user plugs the new device in
> and it doesn't work. Then they have to Google until they figure out
> they need to load user space drivers for their specific distro.
> 
>>
>> Keymap in the kernel are needed for devices that are required to boot
>> (keyboards) - and even then it might be only basic keymap, not the full
>> multimedia goodness with 300+ distinct keys. I am not accepting any new
>> mappings for AT keyboard driver and I believe both I and Jiri would like
>> to delete bunch of HID sub-drivers that only do key remapping.
>>
>> Attempting to keep keymaps in several places will likely cause them to
>> diverge, makes user confused where changes should be applied and who is
>> the authoritative source is, that is why it makes sense to remove them
>> from the kernel.

Agreed.

Also, new remote keymap additions happen all the time. By keeping them at kernel
level, this means that an user will need to wait for the next kernel cycle to be
completed, and for the distro to backport those patches.

IMO, having it at an userspace package makes easier for them to use a new keyboard
map.

Cheers,
Mauro
