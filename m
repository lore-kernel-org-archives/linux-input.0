From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Bug#594089: keyboard-configuration: caps lock keycode problem
Date: Sun, 24 Oct 2010 21:50:03 -0700
Message-ID: <20101025045003.GA1438@core.coreip.homeip.net>
References: <20100823154353.2805.13525.reportbug@tom.tse>
 <20100903235540.GA9149@const>
 <4C866913.3030201@triadsys.com>
 <4C8E6861.1070502@triadsys.com>
 <20101024144150.GV24091@const.famille.thibault.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:40587 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992Ab0JYEuS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Oct 2010 00:50:18 -0400
Content-Disposition: inline
In-Reply-To: <20101024144150.GV24091@const.famille.thibault.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Thibault <sthibault@debian.org>, Tom Vier <tom@triadsys.com>, 594089@bugs.debian.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Oct 24, 2010 at 04:41:51PM +0200, Samuel Thibault wrote:
> The short story is: Tom's keyboard sends all that when he presses caps
> lock:
> 
> press: 0x3a 0xe0 0x66
> repeat: 0x3a
> release: 0xba 0xe0 0xe6
> 
> 0xe0 0x66 happens to be the "favorites" key on his keyboard with
> internet navigation keys.  I thus believe there's a bug in his keyboard
> that needs to be filtered at the kernel level.
> 
> The long story can be read on http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=594089

Hmm, the question is whether the real "favorites" key send the same
usage and the fake one after caps lock. Any chance Tom could locate
evtest utility and see what MSC_SCAN events being emitted?

Thanks.

-- 
Dmitry
