From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: generic: Recognize WACOM_HID_WD_PEN as a
 type of pen collection
Date: Fri, 10 Nov 2017 09:45:33 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1711100943350.32604@cbobk.fhfr.pm>
References: <20171018152713.22633-1-killertofu@gmail.com> <nycvar.YFH.7.76.1710191021420.9294@jbgna.fhfr.qr> <CANRwn3T4nvxMGxExtw+QG4msZnd1BUsEH51YCFVuv2j7ob97Ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43752 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750850AbdKJIpf (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 10 Nov 2017 03:45:35 -0500
In-Reply-To: <CANRwn3T4nvxMGxExtw+QG4msZnd1BUsEH51YCFVuv2j7ob97Ag@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Thu, 9 Nov 2017, Jason Gerecke wrote:

> Was this branch ever sent to Linus? I don't see any mention of it (or 
> this patch) in the 4.14-rc8 history...

I take the blame here; last few weeks were a bit crazy for me, and this 
slipped through cracks.

I'll be submitting the whole lot for stable, so that it gets included 
everywhere properly.

-- 
Jiri Kosina
SUSE Labs

