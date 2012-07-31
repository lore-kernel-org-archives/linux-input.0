From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH 0/7] HID: picoLCD updates
Date: Tue, 31 Jul 2012 09:59:09 +0200
Message-ID: <20120731095909.08d60f70@pluto.restena.lu>
References: <20120730213656.0a9f6d30@neptune.home>
	<CANq1E4Tb1Er+O54rN3OteMXqeXAXDr4Z-dvY+RQxZW_NdAfifw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay.restena.lu ([158.64.1.62]:48474 "EHLO
	smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754656Ab2GaH7M (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Jul 2012 03:59:12 -0400
In-Reply-To: <CANq1E4Tb1Er+O54rN3OteMXqeXAXDr4Z-dvY+RQxZW_NdAfifw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Jaya Kumar <jayalk@intworks.biz>, linux-fbdev@vger.kernel.org

Hi David,

On Tue, 31 Jul 2012 09:26:07 David Herrmann wrote:
> This is not directly related to this patchset, but did you fix the
> locking issue with hid-core? It is still on my todo-list but I haven't
> gotten around fixing it, yet. However, I plan on fixing it this
> summer, but if picolcd does not require it, it's probably not worth
> the work.

I worked around it with patch 6/7 as in disabling the version check.

The other probing steps don't expect a response from the hardware, thus
are not affected.

But it would definitely be helpful to be able to revert that one.
Understanding and fixing the FB-related misbehavior on quick bind/unbind
seems more important though.


Not related with this, getting a return value from
usbhid_submit_report() as in -EAGAIN or -ENODEV would help in order
to avoid the ugly 
  hid-picolcd 0003:04D8:C002.0003: usb_submit_urb(out) failed: -19
lines in kernel log and stopping interaction with hardware when it's
gone already or giving it time to consume its queue when there is lots
of data being sent.


Regards,
Bruno
