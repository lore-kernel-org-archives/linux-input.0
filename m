From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] HID: waltop: Extend barrel button fix
Date: Mon, 21 May 2012 13:22:59 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1205211322490.22314@pobox.suse.cz>
References: <1337538216-7406-1-git-send-email-spbnick@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48197 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751107Ab2EULXH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 21 May 2012 07:23:07 -0400
In-Reply-To: <1337538216-7406-1-git-send-email-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, DIGImend-users <digimend-users@lists.sourceforge.net>, "Eduardo H. Silva" <hoboprimate@gmail.com>

On Sun, 20 May 2012, Nikolai Kondrashov wrote:

> Extend Waltop barrel button fix to all models: ignore reported pressure when a
> barrel button is pressed, because it is rarely correct. Report zero pressure in
> such cases instead.
> 
> Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
