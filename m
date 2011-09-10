From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: [PATCH v4] HID: Add full support for Logitech Unifying receivers
Date: Sat, 10 Sep 2011 09:28:26 +0200
Message-ID: <20110910072826.GA1611@x4.trippels.de>
References: <1315638713-3731-1-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ud10.udmedia.de ([194.117.254.50]:52695 "EHLO
	mail.ud10.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754138Ab1IJH22 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 10 Sep 2011 03:28:28 -0400
Content-Disposition: inline
In-Reply-To: <1315638713-3731-1-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, rtitmuss@logitech.com, ogay@logitech.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nestor Lopez Casado <nlopezcasad@logitech.com>

On 2011.09.10 at 09:11 +0200, Benjamin Tissoires wrote:
> From: Nestor Lopez Casado <nlopezcasad@logitech.com>
> 
> From: Nestor Lopez Casado <nlopezcasad@logitech.com>
> 
> With this driver, all the devices paired to a single Unifying
> receiver are exposed to user processes in separated /input/dev
> nodes.
> 
> Keyboards with different layouts can be treated differently,
> Multiplayer games on single PC (like home theater PC) can
> differentiate input coming from different kbds paired to the
> same receiver.

Nice. Does this mean I will be able to use the thumb-button of my M705
mouse in the near future? 

(Someone asked the same question 1.5 years ago, but nothing happened
till then:
http://thread.gmane.org/gmane.linux.kernel.input/11791 )

-- 
Markus
