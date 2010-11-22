From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC][PATCH] Input: ct82c710 - remove a redundant
 serio_register_port()
Date: Sun, 21 Nov 2010 22:24:21 -0800
Message-ID: <20101122062421.GA31175@core.coreip.homeip.net>
References: <1290406007.6941.15.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37120 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141Ab0KVGYa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Nov 2010 01:24:30 -0500
Content-Disposition: inline
In-Reply-To: <1290406007.6941.15.camel@mola>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Vojtech Pavlik <vojtech@ucw.cz>

On Mon, Nov 22, 2010 at 02:06:47PM +0800, Axel Lin wrote:
> We already call serio_register_port() in ct82c710_probe(),
> thus remove a redundant serio_register_port() in ct82c710_init().
> 
> Looks like this bug is introduced by 
> 916d83cfe5da1cda454d8b0ae233f06b58bd7f91
> "Input: ct82c710 - convert to the new platform device interface"
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> I don't have this hardware handy, I appreciate if someone can test this patch.
> 

I doubt anyone has; maybe I should start pruning older drivers...

BTW, the fix is obviously correct so I'll apply it and your other two
patches as well. Thanks Axel.

-- 
Dmitry
