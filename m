From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] Add support for One by Wacom (CTL-472 / CTL-672)
Date: Tue, 23 Jan 2018 15:44:01 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1801231543210.11852@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1710111524210.14384@jbgna.fhfr.qr> <20171226235018.5522-1-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50997 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751565AbeAWOoE (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 23 Jan 2018 09:44:04 -0500
In-Reply-To: <20171226235018.5522-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Mx Jing <jingmingxuan@outlook.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Tue, 26 Dec 2017, Jason Gerecke wrote:

> Adds support for the second-generation "One by Wacom" tablets. These
> devices are similar to the last generation, but a slightly different size
> and reporting a higher number of pressure levels.

Please don't forget to put proper prefixes in the patch title ("HID: 
wacom", as usual) next time.

Applied to for-4.16/wacom, thanks.

-- 
Jiri Kosina
SUSE Labs

