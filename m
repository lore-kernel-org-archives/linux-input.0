From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH] cap11xx: add LED support
Date: Wed, 10 Jun 2015 00:40:24 +0200
Message-ID: <55776B58.9080102@zonque.org>
References: <1433821584-20102-1-git-send-email-mranostay@gmail.com> <557678D6.1020804@zonque.org> <20150609171254.GF6338@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:57059 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751955AbbFIWk0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Jun 2015 18:40:26 -0400
In-Reply-To: <20150609171254.GF6338@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Matt Ranostay <mranostay@gmail.com>, linux-input@vger.kernel.org

On 06/09/2015 07:12 PM, Dmitry Torokhov wrote:
> On Tue, Jun 09, 2015 at 07:25:42AM +0200, Daniel Mack wrote:

>> Use the .brightness_set_sync callback, so you don't have to dance around
>> with the workers at all.
> 
> Umm, how will it help? You still can't sleep in set_brightness().
> brightness_set_sync() just says that the driver guarantees that the LED
> state will be set (or error returned) when the function returns.

Hmm, right. I was mislead by this comment in include/linux/leds.h:

   /*
    * Set LED brightness level immediately - it can block the caller for
    * the time required for accessing a LED device register.
    */

But I in fact don't see any wrapper logic that magically uses a worker
when called from interrupt context.


Thanks for the heads-up!
Daniel
