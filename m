From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Remove HID ignore quirk for MGE UPS devices
Date: Tue, 19 Aug 2008 14:46:23 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0808191445560.18058@jikos.suse.cz>
References: <1218798061.14646.13.camel@hughsie-work>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:37907 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753178AbYHSMqZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Aug 2008 08:46:25 -0400
In-Reply-To: <1218798061.14646.13.camel@hughsie-work>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Hughes <rhughes@redhat.com>
Cc: linux-input <linux-input@vger.kernel.org>, Arnaud Quette <aquette.dev@gmail.com>, David Zeuthen <davidz@redhat.com>, "kay.sievers" <kay.sievers@vrfy.org>

On Fri, 15 Aug 2008, Richard Hughes wrote:

> With the ignore quirk in place a user would have to configure NUT before the
> UPS could be used, as NUT uses it's own internal USB matching framework
> to match against the USB devices, do low level control messages on the
> device and then parse the HID tables all in userspace.
> This is not needed, as allowing the device to be claimed as a usbhid device
> allows it to be used like any other USB UPS device. The devices correctly
> advertise the power device page which can be queried for the device state.

Applied, thanks Richard.

-- 
Jiri Kosina
SUSE Labs
