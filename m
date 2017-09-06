From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: bits shifted too much for 9th and 10th
 buttons
Date: Wed, 6 Sep 2017 10:47:03 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1709061046510.4077@jbgna.fhfr.qr>
References: <20170831225003.5247-1-ping.cheng@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52986 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750832AbdIFIrE (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 6 Sep 2017 04:47:04 -0400
In-Reply-To: <20170831225003.5247-1-ping.cheng@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <ping.cheng@wacom.com>

On Thu, 31 Aug 2017, Ping Cheng wrote:

> Cintiq 12 has 10 expresskey buttons. The bit shift for the last
> two buttons were off by 5.
> 
> Fixes: c7f0522 ("HID: wacom: Slim down wacom_intuos_pad processing")
> 
> Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
> Tested-by: Matthieu Robin <matthieu@macolu.org>

Applied to for-4.14/upstream-fixes.

-- 
Jiri Kosina
SUSE Labs

