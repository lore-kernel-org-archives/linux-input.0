From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: HID regression: Quanta touchscreen, device ID: 0408:3008
Date: Mon, 23 Apr 2012 16:26:33 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1204231625260.1856@pobox.suse.cz>
References: <CACVXFVPTMPGRcvgdBd9Z=rsPCUGdmyoejU208Wy=c3c38U-ZkQ@mail.gmail.com> <alpine.LNX.2.00.1204231542030.1856@pobox.suse.cz> <CACVXFVMK6W4opVx_ZF94oz2ZZaN5=a6U7HkEvMTT8BYs=ojEGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36950 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751675Ab2DWO0f (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Apr 2012 10:26:35 -0400
In-Reply-To: <CACVXFVMK6W4opVx_ZF94oz2ZZaN5=a6U7HkEvMTT8BYs=ojEGA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@enac.fr>

On Mon, 23 Apr 2012, Ming Lei wrote:

> > So if there are patches that need to be applied (likely device ID
> > additions as far as I understand this monster launchpad bug entry), please
> > point me directly to the respective patches or send me a little bit more
> > details (VID/PID/protocol needed), and I'll queue the patches.
> 
> Sorry, I have not any patches which can make the Quanta touchscreen(0408:3008)
> working well, also no any device ID addition patch is need for the device.
> 
> You can understand my email as a regression report for the Quanta touchscreen
> device, since it works well on 3.0 kernel, but double click stops working
> on 3.4-rc2.

Support for 0x3008 PID has been added by Benjamin only in v3.3-rc1 (commit 
5e7ea11f6), so I am not really sure about the level of support you are 
talking about in 3.0 kernel?

Was it perhaps supported by some out of tree driver?

-- 
Jiri Kosina
SUSE Labs
