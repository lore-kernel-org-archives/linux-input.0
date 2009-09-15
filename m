From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH v3] input/keyboard: new OpenCores Keyboard Controller
	driver
Date: Tue, 15 Sep 2009 12:39:04 -0400
Message-ID: <8bd0f97a0909150939u1cd7787dw412b733d168e27d6@mail.gmail.com>
References: <1252911864-19233-1-git-send-email-vapier@gentoo.org>
	<1252950003-9451-1-git-send-email-vapier@gentoo.org> <200909141049.50705.dmitry.torokhov@gmail.com>
	<8bd0f97a0909141102l5fa309f4ua1bedd0f1ac99295@mail.gmail.com>
	<4AAE8908.1000104@hvsistemas.es> <20090915055224.GD1132@core.coreip.homeip.net>
	<8bd0f97a0909150416j444999e4sfcb6ad77146a97d7@mail.gmail.com>
	<20090915162349.GA29241@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.211.174]:57896 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754629AbZIOQjV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Sep 2009 12:39:21 -0400
In-Reply-To: <20090915162349.GA29241@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Javier Herrero <jherrero@hvsistemas.es>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Bryan Wu <cooloney@kernel.org>

On Tue, Sep 15, 2009 at 12:23, Dmitry Torokhov wrote:
> On Tue, Sep 15, 2009 at 07:16:25AM -0400, Mike Frysinger wrote:
>> On Tue, Sep 15, 2009 at 01:52, Dmitry Torokhov wrote:
>> > OK, below is what I have now... One concern though - don't we need to do
>> > request_mem_region/ioremap for the addr_res?
>>
>> i think so ... these operations are nops on a Blackfin CPU which is
>> probably why it "just works".
>
> Surely request_mem_region is not a nop? I think even if uoremap is a nop
> we need to convert the driver since it does not have to be on a
> Blackfin, does it?

i wasnt suggesting we not add these calls.  i was just stating why
they hadnt already been added -- things work fine on a Blackfin system
w/out ioremap calls because we're a no-mmu system.

>> the input layer can handle input even if it's not registered ?
>
> The device can survive input events as soon as it was allocated with
> input_allocate_device() but of course the event will not get anywhere.
> This is a property that I intend to keep since it is very convenient.

that's fine, i was just curious
-mike
