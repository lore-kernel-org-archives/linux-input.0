From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: wacom: Simplify check for presence of single-finger
 touch
Date: Thu, 23 Apr 2015 10:06:21 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1504231006120.3695@pobox.suse.cz>
References: <1429143752-5431-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38708 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755878AbbDWIGX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Apr 2015 04:06:23 -0400
In-Reply-To: <1429143752-5431-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Ping Cheng <pinglinux@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>

On Wed, 15 Apr 2015, Jason Gerecke wrote:

> To determine if a touch is present in the single-touch case, we can
> simply check if the BTN_TOUCH key is active or not. This will work for
> both HID_GENERIC and other device types.
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>

Applied to for-4.2/wacom.

-- 
Jiri Kosina
SUSE Labs
