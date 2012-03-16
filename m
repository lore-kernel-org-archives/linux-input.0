From: "John Stoffel" <john@stoffel.org>
Subject: Re: Building BarGraph with LED subsystem
Date: Fri, 16 Mar 2012 12:54:19 -0400
Message-ID: <20323.28731.474538.955921@quad.stoffel.home>
References: <1b29a178dd288b0f17608b5815ca77a5.squirrel@mungewell.org>
	<20323.25792.171143.809563@quad.stoffel.home>
	<f04eb1355e17dbe4ce7bbdd47da0056e.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from Mycroft.westnet.com ([216.187.52.7]:60907 "EHLO
	mycroft.westnet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032027Ab2CPQyY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Mar 2012 12:54:24 -0400
In-Reply-To: <f04eb1355e17dbe4ce7bbdd47da0056e.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: John Stoffel <john@stoffel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

>>>>> "simon" == simon  <simon@mungewell.org> writes:

>> While making the kernel more complex... esp for a feature which is of
>> such limited use.

simon> Is the concept of a bargraph of LEDs really a 'limited use'? I
simon> can think of several uses... I mean isn't flashing or a heart
simon> beat just as limited ;-)

Yes, it's a limited use.  Are 10% of linux users going to have this
hardware and use it?  

>> Do it all in userland, it's easier, you can use floating point
>> math, etc.  And to test changes, you don't have to recompile a
>> module and unload/reload it, etc.

simon> For my application a user-land stub would do math to work out
simon> threshold values and push current value (in the right format)
simon> into the LED subsystem.

simon> Once kernel framework is provided it should not need
simon> re-compilation on a case by case basis.

If the kernel only provides a way to set the brightness of individual
LEDs, why can't you do the rest in userspace?  What if the user wants
to have the LEDs run right to left, or visa versa?  

Doing it in userspace means that you can do it however you want with
just a simple change.  Putting this stuff into the kernel means you
can't make changes without being much more invasive.

As an analogy, if you put a dimmer on your dining room lights, where
is the switch?  In the living room (user space) or down in the
electrical box (kernel space) hooked up by strings to move the switch
up and down?  It's a crappy example, but it gets the idea across.

John
