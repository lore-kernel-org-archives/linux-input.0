From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH] HID: wacom: Enable pad device for older Bamboo Touch
 tablets
Date: Wed, 8 Jul 2015 11:41:51 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507081141300.10183@pobox.suse.cz>
References: <1435780860-3647-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:45723 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934071AbbGHJly (ORCPT
	<rfc822;groupwise-linux-input@vger.kernel.org:0:0>);
	Wed, 8 Jul 2015 05:41:54 -0400
In-Reply-To: <1435780860-3647-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, linux-input@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>

On Wed, 1 Jul 2015, Jason Gerecke wrote:

> Commit 862cf55 neglected to set the WACOM_DEVICETYPE_PAD flag for older
> two-finger Bamboo Touch tablets. Not only does this result in the pad
> device not appearing when such a tablet is plugged in, but also causes a
> segfault when 'wacom_bpt_touch' tries to send pad events. This patch
> adds the flag to resolve these issues.
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>

Applied to for-4.2/upstream-fixes.

-- 
Jiri Kosina
SUSE Labs
