From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2 7/7] HID: wacom: Add battery presence indicator to
 wireless tablets
Date: Wed, 11 Mar 2015 13:53:11 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1503111352550.24876@pobox.suse.cz>
References: <1425671264-4944-14-git-send-email-killertofu@gmail.com> <1426094741-15270-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46541 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751710AbbCKRxN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Mar 2015 13:53:13 -0400
In-Reply-To: <1426094741-15270-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, pinglinux@gmail.com, benjamin.tissoires@redhat.com

On Wed, 11 Mar 2015, Jason Gerecke wrote:

> Declares the POWER_SUPPLY_PROP_PRESENT property to provide userspace
> with a way to determine if the battery on a wireless tablet is plugged
> in. Although current wireless tablets do not explicitly report this
> information, it can be inferred from other state information. In
> particular, a battery is assumed to be present if any of the following
> are true: a non-zero battery level reported, the battery is reported as
> charging, or the tablet is operating wirelessly.
> 
> Note: The last condition above may not strictly hold for the Graphire
> Wireless (it charges from a DC barrel jack instead of a USB port), but I
> do not know what is reported in the no-battery condition.
> 
> Signed-off-by: Jason Gerecke <killertofu@gmail.com>

Applied to for-4.1/wacom.

-- 
Jiri Kosina
SUSE Labs
