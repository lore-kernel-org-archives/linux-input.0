From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: Add new driver for non-compliant Xin-Mo devices.
Date: Mon, 29 Jul 2013 11:51:55 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1307291151370.18809@pobox.suse.cz>
References: <1374945602-11894-1-git-send-email-oscherler@ithink.ch> <1374945602-11894-2-git-send-email-oscherler@ithink.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58227 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751075Ab3G2Jv6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Jul 2013 05:51:58 -0400
In-Reply-To: <1374945602-11894-2-git-send-email-oscherler@ithink.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Olivier Scherler <oscherler@ithink.ch>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Sat, 27 Jul 2013, oscherler@ithink.ch wrote:

> From: Olivier Scherler <oscherler@ithink.ch>
> 
> The driver currently only supports the Dual Arcade controller.
> It fixes the negative axis event values (the devices sends -2) to match the
> logical axis minimum of the HID report descriptor (the report announces -1).
> It is needed because hid-input discards out of bounds values.

Applied, thanks Olivier.

-- 
Jiri Kosina
SUSE Labs
