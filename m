From: lirc@bartelmus.de (Christoph Bartelmus)
Subject: Re: [RFC] What are the goals for the architecture of an in-kernel IR 	system?
Date: 29 Nov 2009 12:24:00 +0100
Message-ID: <BDodb$iHqgB@lirc>
References: <4B11881B.7000204@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:61961 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937AbZK2MHB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Nov 2009 07:07:01 -0500
In-Reply-To: <4B11881B.7000204@s5r6.in-berlin.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: stefanr@s5r6.in-berlin.de
Cc: awalls@radix.net, dmitry.torokhov@gmail.com, j@jannau.net, jarod@redhat.com, jarod@wilsonet.com, jonsmirl@gmail.com, khc@pm.waw.pl, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, maximlevitsky@gmail.com, mchehab@redhat.com, superm1@ubuntu.com

Hi Stefan,

on 28 Nov 09 at 21:29, Stefan Richter wrote:
> Jon Smirl wrote:
>> On Sat, Nov 28, 2009 at 2:45 PM, Stefan Richter
>> <stefanr@s5r6.in-berlin.de> wrote:
>>> Jon Smirl wrote:
>>>> Also, how do you create the devices for each remote? You would need to
>>>> create these devices before being able to do EVIOCSKEYCODE to them.
>>> The input subsystem creates devices on behalf of input drivers.  (Kernel
>>> drivers, that is.  Userspace drivers are per se not affected.)
>>
>> We have one IR receiver device and multiple remotes. How does the
>> input system know how many devices to create corresponding to how many
>> remotes you have?

> If several remotes are to be used on the same receiver, then they
> necessarily need to generate different scancodes, don't they?  Otherwise
> the input driver wouldn't be able to route their events to the
> respective subdevice.

Consider this case:
Two remotes use different protocols. The scancodes after decoding happen  
to overlap.
Just using the scancodes you cannot distinguish between the remotes.  
You'll need to add the protocol information to be able to solve this which  
complicates the setup.

In LIRC this is solved by having protocol parameters and scancode mapping  
in one place.

Christoph
