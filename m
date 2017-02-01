From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] Input: refuse to register absolute devices without
 absinfo
Date: Wed, 1 Feb 2017 12:07:22 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1702011207100.25515@cbobk.fhfr.pm>
References: <20170131231515.GA37218@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49294 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751319AbdBALHZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 1 Feb 2017 06:07:25 -0500
In-Reply-To: <20170131231515.GA37218@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org

On Tue, 31 Jan 2017, Dmitry Torokhov wrote:

> If device is supposed to send absolute events (i.e. EV_ABS bit is set in
> dev->evbit) but dev->absinfo is not allocated, then the driver has done
> something wrong, and we should not register such device. Otherwise we'll
> crash later, when driver tries to send absolute event.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Jiri Kosina <jkosina@suse.cz>

Thanks.

-- 
Jiri Kosina
SUSE Labs

