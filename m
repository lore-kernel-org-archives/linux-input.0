From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid input - force feedback support for (old) Logitech
 RumblePad gamepad
Date: Mon, 4 Oct 2010 15:40:41 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1010041540220.29535@pobox.suse.cz>
References: <4CA707E1.8050504@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:36504 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753872Ab0JDNkn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 4 Oct 2010 09:40:43 -0400
In-Reply-To: <4CA707E1.8050504@web.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hendrik Iben <Hendrik_Iben@web.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 2 Oct 2010, Hendrik Iben wrote:

> Hi Jiri,
> 
> I implemented a force feedback driver for an old (~year 2000, corded) 
> Logitech RumblePad by sniffing on USB traffic. In the end I realized 
> that it uses the same protocol that is used for the Rumblepad 2 device. 
> So adding support was as easy as adding the new device id to the 
> existing hid parts. This patch was made against kernel 2.6.35 and tested 
> on 2.6.32 and 2.6.33. Please note that the old device is really spelled 
> RumblePad while the new devices are called Rumblepad... I don't know 
> anybody else with this pad to test this but as there were no code 
> changes necessary I believe this patch should be easy to integrate.

Thanks for doing the work Hendrik. I have queued the patch.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
