From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Threaded interrupts for synaptic touchscreen in HTC dream
Date: Wed, 22 Jul 2009 17:57:56 +0100
Message-ID: <20090722165756.GB21186@rakim.wolfsonmicro.main>
References: <5d5443650907210530x4aaa03d6gd47ef5f79a3ef8a4@mail.gmail.com>
 <20090721124933.GA5668@rakim.wolfsonmicro.main>
 <20090721160436.GD4352@dtor-d630.eng.vmware.com>
 <alpine.LFD.2.00.0907212225030.2813@localhost.localdomain>
 <20090721222547.GA1948@opensource.wolfsonmicro.com>
 <alpine.LFD.2.00.0907221022190.2813@localhost.localdomain>
 <20090722121800.GD21171@rakim.wolfsonmicro.main>
 <alpine.LFD.2.00.0907221427380.2813@localhost.localdomain>
 <20090722155811.GA2775@dtor-d630.eng.vmware.com>
 <alpine.LFD.2.00.0907221830410.2813@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:39342 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752163AbZGVQ55 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jul 2009 12:57:57 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0907221830410.2813@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Trilok Soni <soni.trilok@gmail.com>, Pavel Machek <pavel@ucw.cz>, Arve Hj?nnev?g <arve@android.com>, kernel list <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, linux-input@vger.kernel.org, Andrew Morton <akpm@osdl.org>, linux-i2c@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>, m.szyprowski@samsung.com, t.fujak@samsung.com, kyungmin.park@samsung.com, David Brownell <david-b@pacbell.net>, Peter Zijlstra <peterz@infradead.org>, Daniel Ribeiro <drwyrm@gmail.com>

On Wed, Jul 22, 2009 at 06:40:21PM +0200, Thomas Gleixner wrote:

> If the platform maintainer sets the wrong handler or the wrong
> platform data then it's not the driver writers problem.

It becomes the driver writer's problem as soon as the people writing the
machine integration start e-mailing saying that the driver is buggy
because they've not set this stuff up for the driver, it not being
something that they'd expect to have to do for any other interrupt in
their system.

This isn't such an issue in the PC world there's relatively few people
doing the platform development but in the embedded space that's not the
case - there are vastly more people doing platform development since
essentially everyone building a new device has to do some.
