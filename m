From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2 1/2] HID: wacom: Have wacom_{get,set}_report retry on
 -EAGAIN, not -EPIPE
Date: Thu, 21 May 2015 21:39:21 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1505212139030.13817@pobox.suse.cz>
References: <1431120302-13691-1-git-send-email-killertofu@gmail.com> <1432230272-3614-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50584 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932248AbbEUTj0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 21 May 2015 15:39:26 -0400
In-Reply-To: <1432230272-3614-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, linux-input@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>

On Thu, 21 May 2015, Jason Gerecke wrote:

> Retrying on -EPIPE makes very little sense since this typically indicates
> a problem that will not just disappear on its own. For instance, the USB
> documentation states that it will be sent if the endpoint is stalled or
> the device has disconnected. Instead, we should retry if -EAGAIN is
> received since this indicates a temporary error condition such as a busy
> bus.
> 
> In addition to adjusting the conditions we retry under, we also log an
> error on failure so that we can be aware of what's going on.
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>

I have applied the series to for-4.2/wacom. Thanks,

-- 
Jiri Kosina
SUSE Labs
