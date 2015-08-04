From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH 1/3] HID: wacom: Use calculated pkglen for wireless touch
 interface
Date: Tue, 4 Aug 2015 15:40:59 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1508041540460.27871@pobox.suse.cz>
References: <1438622225-6718-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52707 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756284AbbHDNlA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Aug 2015 09:41:00 -0400
In-Reply-To: <1438622225-6718-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Aaron Skomra <skomra@gmail.com>, Ping Cheng <pinglinux@gmail.com>, linux-input@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>

On Mon, 3 Aug 2015, Jason Gerecke wrote:

> Commit 01c846f introduced the 'wacom_compute_pktlen' function which
> automatically determines the correct value for an interface's pkglen
> by scanning the HID descriptor. This function returns the correct
> value for the wireless receiver's touch interface, removing the need
> for us to set it manually here.
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>

I have applied the series to for-4.3/wacom.

Thanks,

-- 
Jiri Kosina
SUSE Labs
