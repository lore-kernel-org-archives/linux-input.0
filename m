From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Supporting Battery Strength from my Bluetooth Mouse
Date: Mon, 21 Nov 2011 09:49:26 -0800
Message-ID: <4ECA8F26.1020109@goop.org>
References: <4EC75224.7070207@goop.org> <alpine.LNX.2.00.1111191212140.15187@pobox.suse.cz> <4EC820F8.4070900@goop.org> <alpine.LNX.2.00.1111201110480.15187@pobox.suse.cz> <4ECA7E7D.80207@goop.org> <20111121173650.GC2362@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from claw.goop.org ([74.207.240.146]:47280 "EHLO claw.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753714Ab1KURta (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Nov 2011 12:49:30 -0500
In-Reply-To: <20111121173650.GC2362@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, vojtech@ucw.cz, Przemo Firszt <przemo@firszt.eu>

On 11/21/2011 09:36 AM, Dmitry Torokhov wrote:
>>> That depends a bit on the type of the event (EV_KEY has to handle 
>>> auto-repeat for example, etc). See the switch in input_handle_event() 
>>> which contains the logic behind what is happening when 'duplicate' event 
>>> is coming through input core.
>> In this case, it will be EV_ABS/ABS_MISC which does have duplicates
>> suppressed.
> No, please do not try to route battery info through input subsystem;
> power_supply seems to be the proper interface for it.

I was just referring to doing that for debugging/investigation
purposes.  I found hidraw which resolves that concern anyway.

Thanks,
    J
