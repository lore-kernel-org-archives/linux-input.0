From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: Add custom driver for Lenovo ThinkPad Compact
 Bluetooth Keyboard
Date: Tue, 20 May 2014 16:47:05 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1405201644230.1615@pobox.suse.cz>
References: <1395786407-11273-1-git-send-email-jm@lentin.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55497 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750808AbaETOrH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 20 May 2014 10:47:07 -0400
In-Reply-To: <1395786407-11273-1-git-send-email-jm@lentin.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jamie Lentin <jm@lentin.co.uk>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 25 Mar 2014, Jamie Lentin wrote:

> This keyboard requires some custom mappings for all keys to be
> available, and the Fn-lock toggle needs to be controlled in software.
> 
> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
> ---
> I assume that Linux users want Fn-Lock enabled by default, so they can
> get at the function keys. If this is an incorrect assumption then can
> change it---so long as there's some way of me leaving it enabled :)
> 
> Tested with and applies cleanly to 3.13.6.
> 
>  drivers/hid/Kconfig                   |  10 ++
>  drivers/hid/Makefile                  |   1 +
>  drivers/hid/hid-core.c                |   3 +
>  drivers/hid/hid-ids.h                 |   1 +
>  drivers/hid/hid-lenovo-tpcompactkbd.c | 191 ++++++++++++++++++++++++++++++++++
>  5 files changed, 206 insertions(+)

Jamie,

thanks for the driver.

I think it'd make more sense if this could be folded into hid-lenovo-tpkbd 
driver. Could you please do that and resubmit?

-- 
Jiri Kosina
SUSE Labs
