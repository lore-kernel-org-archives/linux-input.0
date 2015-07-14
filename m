From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: atkbd - add LED triggers for keyboard state
Date: Mon, 13 Jul 2015 17:19:30 -0700
Message-ID: <20150714001930.GB7945@dtor-ws>
References: <1436827554-2186-1-git-send-email-Jason@zx2c4.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:34562 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242AbbGNATe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jul 2015 20:19:34 -0400
Content-Disposition: inline
In-Reply-To: <1436827554-2186-1-git-send-email-Jason@zx2c4.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Samuel Thibault <samuel.thibault@ens-lyon.org>

Hi Jason,

On Tue, Jul 14, 2015 at 12:45:54AM +0200, Jason A. Donenfeld wrote:
> Many new laptop keyboards aren't shipping with LEDs in the keys for
> caps lock, num lock, and scroll lock. They do, however, ship with many LEDs
> for specialized functions that mostly go non-utilized by any current
> Linux drivers. Having a caps lock LED is very helpful in early boot full
> disk encryption, where a fancy GUI is not available to show that caps
> lock is activated.
> 
> This patch wires in the caps, num, and scroll lock states of the
> keyboard into the generic LED trigger subsystem, so that integrators can
> have different LEDs activated on caps/num/scroll lock state changes.

atkbd is the wrong level to introduce this functionality, as you want
the same for all other kinds of keyboards. Moreover needed changes from
Samuel Thibault have been merged into 4.2.

Thanks.

-- 
Dmitry
