From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH] HID: wacom: remove the extra Pen interface for Wacom
 Bamboo PAD
Date: Mon, 29 Jun 2015 14:26:15 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1506291425410.10183@pobox.suse.cz>
References: <1434657524-5374-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:47308 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264AbbF2M0U (ORCPT
	<rfc822;groupwise-linux-input@vger.kernel.org:0:0>);
	Mon, 29 Jun 2015 08:26:20 -0400
In-Reply-To: <1434657524-5374-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jason Gerecke <killertofu@gmail.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 18 Jun 2015, Benjamin Tissoires wrote:

> As mentioned in the comment in the code, both the pen and touch data
> come from the interface tagged as BAMBOO_PAD. The driver re-routes the
> events for the Pen to the generic HID interface and keeps the ones for
> the touch through this current interface.
> 
> Clearing the WACOM_DEVICETYPE_PEN bit removes the extra unused interface
> and makes the Bamboo PAD to behave like in 4.1.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Could you please be a little bit more specific about which commit this is 
a bugfix for?

Thanks a lot.

-- 
Jiri Kosina
SUSE Labs
