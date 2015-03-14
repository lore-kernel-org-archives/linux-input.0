From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Fun with sony motion controllers: navigation controller
Date: Sat, 14 Mar 2015 20:47:25 +0100
Message-ID: <20150314194725.GA3819@amd>
References: <20150314191917.GA3680@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46212 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbbCNTr2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 Mar 2015 15:47:28 -0400
Content-Disposition: inline
In-Reply-To: <20150314191917.GA3680@amd>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: vojtech@suse.cz, mike-@cinci.rr.com, jslaby@suse.cz, dave@thedillows.org, jikos@suse.cz, colin.leitner@gmail.com, frank.praznik@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

Hi!

> After oopsing kernel with ps/3 peripherals, I decided to play some
> more.
> 
> First "sony motion controller" (part of ps/3 move without the

I meant "navigation controller".

I enabled CONFIG_HID_SONY_FF, and fftest now works with the other
controller, but not work this one:

Setting master gain to 75% ... OK
Uploading effect #0 (Periodic sinusoidal) ... OK (id 0)
Uploading effect #1 (Constant) ... Error: Invalid argument
Uploading effect #2 (Spring) ... Error: Invalid argument
Uploading effect #3 (Damper) ... Error: Invalid argument
Uploading effect #4 (Strong rumble, with heavy motor) ... OK (id 1)
Uploading effect #5 (Weak rumble, with light motor) ... OK (id 2)
Enter effect number, -1 to exit
5

I can enter the effect numbers, but nothing happens.

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
