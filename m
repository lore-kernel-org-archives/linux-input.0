From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: Add quirk for CH Products Fighterstick
Date: Tue, 21 Feb 2012 11:59:51 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1202211158090.31150@pobox.suse.cz>
References: <4F3A80DC.4090203@iki.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51107 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754552Ab2BUK7w (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Feb 2012 05:59:52 -0500
In-Reply-To: <4F3A80DC.4090203@iki.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ville Ranki <ville.ranki@iki.fi>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

On Tue, 14 Feb 2012, Ville Ranki wrote:

> CH Fighterstick requires HID_QUIRK_NOGET as many other
> CH devices do. This patch adds device id for Fighterstick
> and adds necessary line to HID quirk list.

Your patch has been damaged by your e-mail client (line wrapped). I have 
fixed that up manually and applied, but please keep that in mind for your 
future patch submissions.

Thanks,

-- 
Jiri Kosina
SUSE Labs
