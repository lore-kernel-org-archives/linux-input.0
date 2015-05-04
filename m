From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/3] HID: wacom: Do not add suffix to name of devices
 with an unknown type
Date: Mon, 4 May 2015 10:02:15 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1505041001560.3081@pobox.suse.cz>
References: <1430441515-30122-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34153 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750798AbbEDICS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 4 May 2015 04:02:18 -0400
In-Reply-To: <1430441515-30122-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Ping Cheng <pinglinux@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>

On Thu, 30 Apr 2015, Jason Gerecke wrote:

> The naming logic currently assumes that all devices will be a pen, finger,
> or pad. Though this has historically been the case, the new HID_GENERIC
> catch-all may cause us to probe devices with Wacom's 056A VID which aren't
> any of these types (e.g. the "Cintiq 24HDT Monitor Control"). This patch
> updates the logic so that no suffix will be added to the device name if
> the device type is unknown.
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>

I have applied the series for for-4.2/wacom.

-- 
Jiri Kosina
SUSE Labs
