From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: usbhid: enable NO_INIT_REPORTS quirk for Semico
 USB Keykoard2
Date: Thu, 10 Mar 2016 18:22:48 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1603101821111.3656@cbobk.fhfr.pm>
References: <62d658ca26c60f0f1ab9d4bb6f4e2687e8bf05c1.1457629721.git.bristot@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59786 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753844AbcCJRWu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Mar 2016 12:22:50 -0500
In-Reply-To: <62d658ca26c60f0f1ab9d4bb6f4e2687e8bf05c1.1457629721.git.bristot@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, Torez Smith <torez@redhat.com>

On Thu, 10 Mar 2016, Daniel Bristot de Oliveira wrote:

> The device which identifies itself as a "USB Keykoard" (no typo)

Yeah, Semico is apparently very careful and perfectionist about their 
hardware. This is a second device from them that has typo in the 
descriptor :)

One more, and we'll probably apply the quirk to all devices from these 
guys that we identify to be of a keyboard type.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

