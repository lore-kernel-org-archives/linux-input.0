From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] input: bcm5974 turn wellspring mode off if failed to
 	start traffic
Date: Wed, 02 Jun 2010 11:27:45 +0200
Message-ID: <4C062411.10409@euromail.se>
References: <1275421559-7980-1-git-send-email-sunmoon1997@gmail.com>	<20100602073513.GG3713@core.coreip.homeip.net> <AANLkTil4cysRYD9Ofx9vnuU7B4z8yw1fYOJ5VF7A4d-P@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:56756 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755202Ab0FBJa1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 2 Jun 2010 05:30:27 -0400
In-Reply-To: <AANLkTil4cysRYD9Ofx9vnuU7B4z8yw1fYOJ5VF7A4d-P@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Luo Jinghua <sunmoon1997@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Luo Jinghua wrote:
[...]
> So the error code is the ENOSPC.

Interesting. A couple of years back, there were a few reports on strange usb
behavior on Macbooks that turned out to be a hardware problem, a bad internal
usb connector. Could that be the case here?

Since ENOSPC is pretty rare, narrowing it down code-wise seems possible. It
could for instance be this path happening:

usb_submit_urb
  usb_hcd_submit_urb
     hcd->driver->urb_enqueue
       ehci_urb_enqueue
         intr_submit
           qh_schedule
             fail

Henrik

