From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v3] HID: wacom: Improve generic name generation
Date: Thu, 20 Jul 2017 15:41:25 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1707201540560.4705@cbobk.fhfr.pm>
References: <20170628211921.5638-1-killertofu@gmail.com> <20170629141021.GG26073@mail.corp.redhat.com> <CANRwn3SndCWUdRyP54r7turG7u7-FiiTeR=czyCsE4h+fZh_8g@mail.gmail.com> <20170629160739.GH26073@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42134 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934128AbdGTNl1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 20 Jul 2017 09:41:27 -0400
In-Reply-To: <20170629160739.GH26073@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jason Gerecke <killertofu@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Thu, 29 Jun 2017, Benjamin Tissoires wrote:

> OTOH, I would think having a more generic approach would be fine:
> bool inline bool hid_is_using_driver(struct hid_device *hdev,
> 		struct hid_ll_driver *driver)
> {
> 	return dev->ll_driver == driver;
> }
> 
> And we can start adding the various extern definitions of the
> ll_drivers in hid.h too...
> 
> How does that sound? Jiri?

Yeah, I find it slightly ugly, but at least it's generic :)

-- 
Jiri Kosina
SUSE Labs

