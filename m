From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] HID: add support for Huion 580 tablet
Date: Tue, 28 May 2013 14:31:09 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1305281430240.3914@pobox.suse.cz>
References: <alpine.LNX.2.00.1305281019530.3914@pobox.suse.cz> <1369743915-19954-1-git-send-email-martin.rusko@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38786 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933827Ab3E1MbL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 28 May 2013 08:31:11 -0400
In-Reply-To: <1369743915-19954-1-git-send-email-martin.rusko@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Martin Rusko <martin.rusko@gmail.com>
Cc: linux-input@vger.kernel.org, Nikolai Kondrashov <spbnick@gmail.com>

On Tue, 28 May 2013, Martin Rusko wrote:

> Add hid-huion.c with support for Huion 580 tablet, which is simple
> 8x5" tablet with 4000LPI resolution and 2048 levels pressure-sensitive
> pen manufactured by the Chinese company Huion.
> 
> The driver fixes incorrect report descriptor sent by the device,
> performs custom initialization required to switch the tablet into
> its native resolution mode and inverts the in-range bit.
> 
> Signed-off-by: Martin Rusko <martin.rusko@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
