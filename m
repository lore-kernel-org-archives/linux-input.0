From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: wacom - add touch_arbitration parameter to wacom
 module
Date: Wed, 10 Aug 2016 11:47:11 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1608101146580.22028@cbobk.fhfr.pm>
References: <1470778736-24721-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40951 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935247AbcHJSdo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Aug 2016 14:33:44 -0400
In-Reply-To: <1470778736-24721-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, peter.hutterer@who-t.net, benjamin.tissoires@redhat.com, Ping Cheng <pingc@wacom.com>

On Tue, 9 Aug 2016, Ping Cheng wrote:

> Touch arbitration is always on in wacom.ko. However, there are
> touch enabled applications use both pen and touch simultaneously.
> We should provide an option for userland to decide if they want
> arbitration on or off.
> 
> This patch sets default touch_arbitration to on since most userland
> apps are not ready to process pen and touch events simultaneously.
> In the future, when userland is ready to accept pen and touch events
> together, we will switch default touch_arbitration to off.
> 
> Tested-by: Peter Hutterer <peter.hutterer@who-t.net>
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
> v2: changed inline touch_state() to report_touch_events() and use struct
> wacom_wac as input for both report_touch_events and delay_pen_events, as
> suggested by Benjamin.

Applied to for-4.9/wacom. Thanks,

-- 
Jiri Kosina
SUSE Labs

