From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: microsoft: Add ID for MS Wireless Comfort
 Keyboard
Date: Wed, 16 Mar 2016 11:21:31 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1603161121190.3656@cbobk.fhfr.pm>
References: <1457715444-18097-1-git-send-email-slava@bacher09.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40002 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965962AbcCPKVd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2016 06:21:33 -0400
In-Reply-To: <1457715444-18097-1-git-send-email-slava@bacher09.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Slava Bacherikov <slava@bacher09.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 11 Mar 2016, Slava Bacherikov wrote:

> Microsoft Wireless Comfort Keyboard has vendor specific My Favorites
> 1-5 keys. Linux already supports this buttons on other MS keyboards by
> MS_ERGONOMY quirk. So apply MS_ERGONOMY quirk to USB PID 0x00e3
> (Microsoft Wireless Optical Desktop Receiver 3.0A). After this
> My Favorites 1..5 keys will be reported as KEY_F14..KEY_F15 events.

Applied to for-4.6/upstream.

-- 
Jiri Kosina
SUSE Labs

