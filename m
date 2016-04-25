From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] hid: thingm: remove not needed error message
Date: Mon, 25 Apr 2016 11:31:40 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1604251131290.27368@cbobk.fhfr.pm>
References: <5717CB61.3080603@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55115 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753617AbcDYJbl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Apr 2016 05:31:41 -0400
In-Reply-To: <5717CB61.3080603@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Wed, 20 Apr 2016, Heiner Kallweit wrote:

> LED core takes care of handling failed calls to thingm_let_set.
> - print error message in set_brightness_delayed or
> - pass error to caller in led_set_brightness_sync
> Also the error message here doesn't provide any hint what actually
> went wrong. Therefore remove it.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

