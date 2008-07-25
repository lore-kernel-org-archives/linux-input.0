From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] bcm5974-0.58: name changes, open/close and	suspend/resume
 serialized
Date: Fri, 25 Jul 2008 20:25:29 +0200
Message-ID: <488A1A99.2070609@euromail.se>
References: <4888311E.9010005@euromail.se> <20080725154250.GA1861@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:38417 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755397AbYGYSZ4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Jul 2008 14:25:56 -0400
In-Reply-To: <20080725154250.GA1861@anvil.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, robfitz@273k.net, akpm@osdl.org, jikos@jikos.cz, vojtech@suse.cz, dmonakhov@openvz.org, johannes@sipsolutions.net

Hello Dmitry,
> 
> Thank you for the changes.  You don't have to track whether device is
> manually suspended or not - usb_submit_urb will fail and that is it.
> 

Perfect.

> Attached are 2 patches. First cleans suspend state tracking as it is not
> really needed and does some formatting and other minor changes and 2nd
> implements runtime pm for the device. Could you please try them and if
> everything still works I will apply the driver.

Patch 1:

  Looking good, just a few comments:

  * I notice that clamp_val is new since 2.6.24.3
  * Regarding the open-fails comment: is EACCES correct?

Patch 2:

  Perfect.

Thank you so much, Dmitry - it's a GO!

Henrik

