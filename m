From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH,v2] usbhid: Add a quirk for raphnet multi-gamepad
 adapters
Date: Mon, 27 Apr 2015 11:04:02 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1504271103530.16113@pobox.suse.cz>
References: <20150425203032.GA24785@yggdrasil2.lan.raphnet.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37394 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932196AbbD0JEE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Apr 2015 05:04:04 -0400
In-Reply-To: <20150425203032.GA24785@yggdrasil2.lan.raphnet.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Raphael Assenat <raph@raphnet.net>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Sat, 25 Apr 2015, Raphael Assenat wrote:

> The raphnet.net 4nes4snes and 2nes2snes multi-joystick adapters use a
> single HID report descriptor with one report ID per controller. This
> has the effect that the inputs of otherwise independent game controllers
> get packed in one large joystick device.
> 
> With this patch each controller gets its own /dev/input/jsX device, 
> which is more natural and less confusing than having all inputs going
> to the same place.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
