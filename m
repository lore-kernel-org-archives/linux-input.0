From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RESEND PATCH] Support Xbox One controllers in xpad driver.
Date: Sun, 17 Aug 2014 09:20:22 -0700
Message-ID: <20140817162022.GA17367@core.coreip.homeip.net>
References: <1407509169-6849-1-git-send-email-ted@mielczarek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:60540 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbaHQV44 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Aug 2014 17:56:56 -0400
Content-Disposition: inline
In-Reply-To: <1407509169-6849-1-git-send-email-ted@mielczarek.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ted Mielczarek <ted@mielczarek.org>
Cc: linux-input@vger.kernel.org, paul.gortmaker@windriver.com, hor27@gmail.com, petr@scssoft.com, magissia@magissia.com, linux-kernel@vger.kernel.org

On Fri, Aug 08, 2014 at 10:46:09AM -0400, Ted Mielczarek wrote:
> Xbox One controllers require an initialization message to start sending data,
> so xpad_init_output becomes a required function. The Xbox One controller does
> not have LEDs like the Xbox 360 controller, so that functionality is not
> implemented. The format of messages controlling rumble is currently
> undocumented, so rumble support is not yet implemented.
> 
> The only thing I'm not certain about in this patch is the check against bInterfaceNumber in xpad_probe. The Xbox One controller advertises three interfaces with the same interface class, subclass and protocol, and I couldn't see any way to match just the first one using usb_device_id.
> 
> Signed-off-by: Ted Mielczarek <ted@mielczarek.org>

Applied, thank you.

-- 
Dmitry
