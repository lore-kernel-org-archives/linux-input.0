From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Threaded interrupts for synaptic touchscreen in HTC dream
Date: Tue, 21 Jul 2009 13:30:34 +0100
Message-ID: <20090721123033.GE13286@sirena.org.uk>
References: <20090714100634.GA4054@elf.ucw.cz> <5d5443650907140320w334864f4uc1ee13ed32fdb874@mail.gmail.com> <20090715133627.GA2538@elf.ucw.cz> <5d5443650907151033w36008b71pe4b32bcea9489b75@mail.gmail.com> <20090721105924.GK4133@elf.ucw.cz> <20090721113642.GC13286@sirena.org.uk> <5d5443650907210518i6ee4df1evdc04d9ae9453707c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:35822 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754006AbZGUMal (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jul 2009 08:30:41 -0400
Content-Disposition: inline
In-Reply-To: <5d5443650907210518i6ee4df1evdc04d9ae9453707c@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Arve Hj?nnev?g <arve@android.com>, kernel list <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, dmitry.torokhov@gmail.com, dtor@mail.ru, linux-input@vger.kernel.org, Andrew Morton <akpm@osdl.org>, linux-i2c@vger.kernel.org

On Tue, Jul 21, 2009 at 05:48:40PM +0530, Trilok Soni wrote:

> I think threaded irqs are used in USB drivers too, I can't locate the
> patches link for that.

The only user of any kind I can see in -next is dm355evm_keys which
relies on the IRQ it uses being configured edge triggered so that it
doesn't need to disable the interrupt to silence the hard IRQ.
