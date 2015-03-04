From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: map telephony usage page
Date: Wed, 4 Mar 2015 23:33:15 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1503042332490.26925@pobox.suse.cz>
References: <20150304221026.GA11485@dtor-ws>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58159 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753026AbbCDWdR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Mar 2015 17:33:17 -0500
In-Reply-To: <20150304221026.GA11485@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Reilly Grant <reillyg@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 4 Mar 2015, Dmitry Torokhov wrote:

> Currently HID code maps usages from telephony page into BTN_0, BTN_1, etc
> keys which get interpreted by mousedev and userspace as left/right/middle
> button clicks, which is not really helpful.
> 
> This change adds mappings for usages that have corresponding input event
> definitions, and leaves the rest unmapped. This can be changed when
> there are userspace consumers for more telephony usages.

Makes sense. Applied to for-4.1/upstream, thanks Dmitry.

-- 
Jiri Kosina
SUSE Labs
