From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v3] HID: wacom: retrieve name from HID descriptor for
 generic devices
Date: Mon, 27 Apr 2015 11:09:21 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1504271108580.16113@pobox.suse.cz>
References: <1429914771-32172-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37659 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932547AbbD0JJX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Apr 2015 05:09:23 -0400
In-Reply-To: <1429914771-32172-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, killertofu@gmail.com, Ping Cheng <pingc@wacom.com>

On Fri, 24 Apr 2015, Ping Cheng wrote:

> HID generic devices share the same default name, "Wacom HID". This
> causes userland programs to show same device names for different
> devices, which would confuse end users with same device names for
> different devices too.
> 
> This patch uses name retrieved from HID descriptor, if a meaningful
> name is reported. Otherwise, affix its product ID to "Wacom HID".
> 
> Names from descriptor may contain extra whitespaces. To comfort
> readers' eyes, we removed those extra whitespaces too.
> 
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> Reviewed-by: Jason Gerecke <killertofu@gmail.com>

Applied to for-4.2/wacom.

-- 
Jiri Kosina
SUSE Labs
