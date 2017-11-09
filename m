From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: sony: Fix SHANWAN pad rumbling on USB
Date: Thu, 9 Nov 2017 13:32:11 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1711091331580.32604@cbobk.fhfr.pm>
References: <20171107142447.11810-1-hadess@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52708 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754299AbdKIMcN (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 9 Nov 2017 07:32:13 -0500
In-Reply-To: <20171107142447.11810-1-hadess@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Szymon Janc <szymon.janc@codecoup.pl>

On Tue, 7 Nov 2017, Bastien Nocera wrote:

> The SHANWAN PS3 clone joypad will start its rumble motors as soon as
> it is plugged in via USB. As the additional USB interrupt does nothing on
> the original PS3 Sixaxis joypads, and makes a number of other
> clone joypads actually start sending data, disable that call for
> the SHANWAN so the rumble motors aren't started on plug.
> 
> Signed-off-by: Bastien Nocera <hadess@hadess.net>

Applied to for-4.15/sony.

-- 
Jiri Kosina
SUSE Labs

