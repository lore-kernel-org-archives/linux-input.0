From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 2/2] input: bcm5974-0.61: New default mouse driver mode
Date: Tue, 02 Sep 2008 20:23:38 +0200
Message-ID: <48BD84AA.2030005@euromail.se>
References: <48BC4BC3.1080903@euromail.se> <20080902085209.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:37926 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751360AbYIBSXs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Sep 2008 14:23:48 -0400
In-Reply-To: <20080902085209.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: akpm@osdl.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> Hi Henrik,
> 
> On Mon, Sep 01, 2008 at 10:08:35PM +0200, Henrik Rydberg wrote:
>> Currently, the Apple bcm5974 driver only mimics a synaptics touchpad, not a mouse.
>> This creates unnecessary complications on systems where the synaptics driver is absent
>> or not configured, such as in a completely new system, or a text console.
> 
> Mousedev should provide a reasonable emulation of standard mouse
> giving user chance to configure the system properly. There is no need
> to task the driver to provide such emulation and therefore I will not
> apply this patch.
> 

I see, this is what puzzled me. Currently mousedev does not work with
bcm5974, but given the statement that it should, it was not hard finding
the reason; the ABS_X/Y messages get stuck in mousedev because bcm5974 does
not fire BTN_TOUCH events. I will send a fix for it shortly. I take it the
first clean-up patch is being applied.

> 
>> * Two-finger scroll emulates a mouse wheel.
>>
>> * Three-finger swipe emulates a horizontal mouse wheel.
>>
>> * Multi-finger clicks emulate the middle and right mouse buttons.
>>
> 
> The kenel driver should only do as little translation as possible,
> allowing userspace to decide how to implement more fancy features.

One could argue that those features are basic rather than fancy; virtually
every mouse of today provides equivalent functionality, and multitouch
features are here to stay. It is also discouraging in particular to
first-time apple users, having to spend a lot of time configuring their
system, only to be able to right-click or scroll using the trackpad.
Could it be something for the mousedev driver, perhaps?


Many thanks,
Henrik

