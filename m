From: Bastian Blank <waldi@debian.org>
Subject: Re: [PATCH 5/7] Input: wacom - Convert remaining ids, part two
Date: Mon, 11 Jan 2010 23:24:48 +0100
Message-ID: <20100111222448.GA7959@wavehammer.waldi.eu.org>
References: <20100107182553.GA11236@wavehammer.waldi.eu.org> <20100107182953.GA12985@wavehammer.waldi.eu.org> <6753EB6004AFF34FAA275742C104F952016A1329@wacom-nt10.wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wavehammer.waldi.eu.org ([82.139.201.20]:40516 "EHLO
	wavehammer.waldi.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566Ab0AKWYv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jan 2010 17:24:51 -0500
Content-Disposition: inline
In-Reply-To: <6753EB6004AFF34FAA275742C104F952016A1329@wacom-nt10.wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pingc@wacom.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jason Childs <oblivian@users.sourceforge.net>

Please fix your MUA, it should break lines to below 80 characters.

On Mon, Jan 11, 2010 at 01:22:31PM -0800, Ping Cheng wrote:
> Can we only move the struct wacom_features definition to wacom_sys.c
> and leave the device specific wacom_features in wacom_wac.c?

The driver is so small. I don't see any reason to split that at all.

>                                                               Also
> leave the actual wacom_ids [] in wacom_wac.c as well since they are
> wacom specific stuff.

No, this are USB id mappings, Linux specific ones.

>                        We'd like to keep wacom specific stuff in
> wacom_wac.c/h, which hopefully can be shared among kernel releases.

The two parts are not properly seperated, none of them can stand on its
own. How exactly do you want to do that?

> BTW, the testing, led by Jason, got very positive feedbacks. There is
> no crash reported with your patch applied.

Why should there be any crashs? It is a simple restructuring.

While we are at it, why does this driver need this amount of hardcoding
of the values in the kernel anyway?

Bastian

-- 
Schshschshchsch.
		-- The Gorn, "Arena", stardate 3046.2
