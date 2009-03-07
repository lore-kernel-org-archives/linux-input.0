From: Richard Hughes <hughsient@gmail.com>
Subject: Re: suspend / hibernate nomenclature
Date: Sat, 7 Mar 2009 20:25:27 +0000
Message-ID: <15e53e180903071225h47bcdbaj83986b50f06135c3@mail.gmail.com>
References: <1235992429.3858.58.camel@hughsie-work.lan>
	 <20090307154842.GA3947@srcf.ucam.org>
	 <20090307164151.GB24668@khazad-dum.debian.net>
	 <20090307164840.GA4800@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f176.google.com ([209.85.220.176]:33583 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756087AbZCGUZc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 7 Mar 2009 15:25:32 -0500
In-Reply-To: <20090307164840.GA4800@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi <linux-acpi@vger.kernel.org>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input <linux-input@vger.kernel.org>, Matthias Clasen <mclasen@redhat.com>

On Sat, Mar 7, 2009 at 4:48 PM, Matthew Garrett <mjg@redhat.com> wrote:
> On Sat, Mar 07, 2009 at 01:41:51PM -0300, Henrique de Moraes Holschuh wrote:
>
>> All machines with a standard crappy PeeCee keyboard with the moon key
>> have a KEY_SLEEP key, and you can plug a PeeCee USB keyboard in just
>> about anything nowadays... including on thinkpads, which have a key
>> that is specific for S4, and one that is specific for S3 in their
>> internal keyboards.
>
> And is this really common enough that it's worth breaking existing
> userland?

Xorg and evdev already does the right thing, we have XF86Hibernate
now. All I have to do is patch HAL to check the kernel version and
then everything in userspace we care about should just work. We have
to sort out the insane mappings sooner or later, and what I've put in
linux-next seems to be the right way of dong this, rather than the way
things used to be (suspend -> hibernate, sleep->suspend,
standby->sleep). I'm fed up of debugging why sleep buttons don't work
right in userspace when the kernel isn't sure what button to emit.

Richard.
