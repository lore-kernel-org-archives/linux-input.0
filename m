From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] HID: logitech-hidpp: prefix the name with Logitech
Date: Fri, 19 Dec 2014 11:53:40 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1412191153150.1680@pobox.suse.cz>
References: <1418337599-10239-1-git-send-email-benjamin.tissoires@redhat.com> <alpine.LNX.2.00.1412171037200.1680@pobox.suse.cz> <20141217152837.GA16047@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57389 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752450AbaLSKxm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Dec 2014 05:53:42 -0500
In-Reply-To: <20141217152837.GA16047@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Peter Wu <peter@lekensteyn.nl>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 17 Dec 2014, Benjamin Tissoires wrote:

> Thanks for applying most of the patches (2 are missing, I'll raise them
> in your inbox :-P )
> 
> Regarding this one, I was wondering if we could not force it into 3.19,
> or at least add a stable@ tag. I had requested this in the first
> submission, and the rationale was to not change a third time the name of
> the device (from "Logitech Unifying Device. Wireless PID:XXXX" to
> "[TMK]XXX" to "Logitech [TMK]XXX").
> 
> Userspace would be grateful to have a reliable name.

Fair enough. I've cherry-picked it from for-3.20/logitech into 
for-3.19/upstream-fixes as well.

Thanks,

-- 
Jiri Kosina
SUSE Labs
