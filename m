From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] usb: hid: Do not bind to Microchip Pick16F1454
Date: Tue, 20 Jan 2015 20:14:38 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1501202014270.10817@pobox.suse.cz>
References: <1421772903-27746-1-git-send-email-kristian.evensen@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38322 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753069AbbATTOk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Jan 2015 14:14:40 -0500
In-Reply-To: <1421772903-27746-1-git-send-email-kristian.evensen@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kristian Evensen <kristian.evensen@gmail.com>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org

On Tue, 20 Jan 2015, Kristian Evensen wrote:

> The Microchip Pick16F1454 is exported as a HID device and is used by for example
> the Yepkit YKUSH three-port switchable USB hub. However, it is not an actual
> HID-device. On the Yepkit, it is used to power up/down the ports on the hub. The
> HID driver should ignore this device.
> 
> Signed-off-by: Kristian Evensen <kristian.evensen@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
