From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 2/2] input: mousedev: Emulate right and middle buttons
 for single-button touchpads
Date: Wed, 10 Sep 2008 16:51:52 +0200
Message-ID: <48C7DF08.4060208@euromail.se>
References: <48C0893C.6060901@euromail.se> <20080910125228.GA25221@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:49794 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751293AbYIJOwF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Sep 2008 10:52:05 -0400
In-Reply-To: <20080910125228.GA25221@anvil.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: akpm@osdl.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Greetings Dmitry,

> On Fri, Sep 05, 2008 at 03:19:56AM +0200, Henrik Rydberg wrote:
>> On most linux-based systems, the right and middle buttons are used
>> extensively. On computers lacking either of those buttons, such as
>> the Apple Macbooks, emulation is needed. This patch adds emulation
>> of the missing buttons via two-fingers-and-click and three-fingers-
>> and-click operations, which has recently become standard, both in
>> MacOS and in the Xorg synaptics driver.
>>
> 
> The standard way of emulating right and middle button presses for
> "button-deficient" devices is to use Macintosh emulation
> (MAC_EMUMOUSEBTN) that works not only for touchpads but for regular mice
> as well.

I have a hard time believing that in five years from now, people will
still consider pressing a key on the keyboard the standard way to
emulate a right click. Nevertheless, I can see the point in moving
away from user-land decisions in the kernel. I will not pursue this one
further, although it is a rather neat piece of functionality.

> Overall I don't think we should enhance mousedev for scenarios where
> proper solution is to install Synaptics X driver. This also goes for
> your other patch improving tapping in mousedev.

Regarding the tapping patch; it is addressing the correctness of
already implemented functionality. I can see nothing wrong with that.

Henrik
