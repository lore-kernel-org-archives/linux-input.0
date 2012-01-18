From: simon@mungewell.org
Subject: Re: fftest: Force feedback doesn't work in native mode
Date: Wed, 18 Jan 2012 11:39:00 -0500
Message-ID: <2a8f304621a47c9b8468f5aa0ae7f4c5.squirrel@mungewell.org>
References: <CAM1yFZ8_VEhsY9qe6Rt_8Ojb89CUUMskQdGDv5GomEVGNBDvxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:37090 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757976Ab2ARQjB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Jan 2012 11:39:01 -0500
In-Reply-To: <CAM1yFZ8_VEhsY9qe6Rt_8Ojb89CUUMskQdGDv5GomEVGNBDvxQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anisha Kaul <born.rebel.83@gmail.com>
Cc: linux-input@vger.kernel.org

> On 18 January 2012 03:58,  <simon@mungewell.org> wrote:
>> Do you have the appropriate FF module built and loading in your kernel,
>> it
>> was recently moved to be enabled with 'LOGIWHEELS_FF' and is supported
>> by
>> the code in 'drivers/hid/hid-lg4ff.c'
>
> And also, I don't have "hid-lg4ff.c" in this
> "linux-dopx:/usr/src/linux-2.6.34-12/drivers/hid" path. I have
> "hid-lg3ff.c" etc.
> Is it responsible for the force feedback not working in the native mode?
> Will I have to compile the kernel or something? :( :(
>
> Ah, or simply download that file and put its name in the respective
> Makefile? Not sure.

If you don't have it then it is probably easiest grabbing a more recent
pre-built kernel from your distribution. I suspect that SuSE has somewhere
for getting 'leading edge' kernels.

'hid-lg4ff' was improved by Michal back in August to include support for
all Logitech wheel and run them in the native mode (to get 900' rotation
etc).

A change log is here:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=history;f=drivers/hid/hid-lg4ff.c;h=6ecc9e2204409c1451e90086a4edd7f0639cdb01;hb=ccb19d263fd1c9e34948e2158c53eacbff369344

Simon

