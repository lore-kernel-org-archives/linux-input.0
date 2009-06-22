From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] HID: hiddev, fix lock imbalance
Date: Mon, 22 Jun 2009 11:01:52 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0906221101290.7457@wotan.suse.de>
References: <1245446651-1652-1-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49717 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002AbZFVJBu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Jun 2009 05:01:50 -0400
In-Reply-To: <1245446651-1652-1-git-send-email-jirislaby@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 19 Jun 2009, Jiri Slaby wrote:

> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> ---
>  drivers/hid/usbhid/hiddev.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)

Applied, thanks a lot for spotting that.

-- 
Jiri Kosina
SUSE Labs
