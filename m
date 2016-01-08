From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: Use correct report to query pen ID from
 INTUOSHT2 devices
Date: Fri, 8 Jan 2016 10:17:31 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1601081017210.3402@cbobk.fhfr.pm>
References: <1452115553-3129-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52728 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754370AbcAHJRd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 8 Jan 2016 04:17:33 -0500
In-Reply-To: <1452115553-3129-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Wed, 6 Jan 2016, Jason Gerecke wrote:

> Unlike other tablets which are compatible with the wacom_intuos_irq handler,
> INTUOSHT2 devices provide pen ID with report ID 8 instead of 5. To ensure
> wacom_intuos_schedule_prox_event works as intended for these tablets, we
> must be sure it uses the correct report ID in this case.
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>

Applied to for-4.5/wacom.

-- 
Jiri Kosina
SUSE Labs

