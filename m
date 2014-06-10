From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: usbhid: remove unneeded initialization of
 quirks_param[]
Date: Tue, 10 Jun 2014 14:33:28 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1406101433190.9378@pobox.suse.cz>
References: <1401996051-7951-1-git-send-email-minipli@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57039 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752308AbaFJMda (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Jun 2014 08:33:30 -0400
In-Reply-To: <1401996051-7951-1-git-send-email-minipli@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mathias Krause <minipli@googlemail.com>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Thu, 5 Jun 2014, Mathias Krause wrote:

> The quirks_param array is located in the BSS, no need to explicitly
> initialize it with NULL.
> 
> Signed-off-by: Mathias Krause <minipli@googlemail.com>
> ---
>  drivers/hid/usbhid/hid-core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
