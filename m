From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Synchronizing evdev readers and drivers?
Date: Fri, 3 Dec 2010 12:42:41 +0000
Message-ID: <20101203124240.GH3182@sirena.org.uk>
References: <AANLkTik8X-Xe9fvYUtRObRBP1PyedOu+zwb1SKKf+kgy@mail.gmail.com> <20101202212223.GA9864@core.coreip.homeip.net> <AANLkTi=vc0b5Zcy=TuVq3=6yZ8eHCEwLQ0hkkk-x-AyZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:43365 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932466Ab0LCMmn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Dec 2010 07:42:43 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=vc0b5Zcy=TuVq3=6yZ8eHCEwLQ0hkkk-x-AyZ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Thu, Dec 02, 2010 at 03:34:20PM -0600, Bill Gatliff wrote:

> I have noticed that several Android ports (among others) call read on
> /dev/input/eventX inside of a delayed loop--- as if they want to pace
> the rate of incoming events themselves.  In fact, in those ports the
> length of each delay is controlled by how often Android applications
> a.k.a. Activities want events streamed to them.

The sysfs interface offered by polldev is *mostly* doing the same thing
(providing user space control of the sample rate) - see "Input:
input-polldev - add sysfs interface for controlling poll interval".
Implementing the same interface for other input devices seems like a
reasonable approach to the problem?  It would mean that if the hardware
is capable of autonomously controlling the rate at which it generates
samples the application would be able to take advantage of that.

A callback on read seems like it's a bit limited as it's more work for
the application (handling the latency introduced by waking up from your
delay and doing the read is faff) and requires polling in the hardware
too.
