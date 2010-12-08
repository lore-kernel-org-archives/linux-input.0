From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: add hid_hw_open/close/power() handlers
Date: Wed, 8 Dec 2010 14:35:50 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1012081435350.14806@pobox.suse.cz>
References: <20101208070248.GE4140@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:36127 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754800Ab0LHNfw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 8 Dec 2010 08:35:52 -0500
In-Reply-To: <20101208070248.GE4140@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>

On Tue, 7 Dec 2010, Dmitry Torokhov wrote:

> Instead of exposing the guts of hid->ll_driver relationship to HID
> sub-drivers provide these helpers to encapsulate the details.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

Makes sense. Applied, thank you Dmitry.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
