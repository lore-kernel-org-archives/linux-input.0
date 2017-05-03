From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: Have wacom_tpc_irq guard against possible
 NULL dereference
Date: Wed, 3 May 2017 11:26:25 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1705031125060.12121@cbobk.fhfr.pm>
References: <20170412203123.GA3915@mwanda> <20170425182956.15406-1-killertofu@gmail.com> <CAF8JNh+31UjTFzAEDGHACw7DhFMrTBGxgm=_ZoxP-8UAiq18vg@mail.gmail.com> <CANRwn3RdKs-NeuWD9=KBKKi_uJ_YQ9Mhd2OrvCegupZDhUvtcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47141 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751661AbdECJ02 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 3 May 2017 05:26:28 -0400
In-Reply-To: <CANRwn3RdKs-NeuWD9=KBKKi_uJ_YQ9Mhd2OrvCegupZDhUvtcQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Ping Cheng <pinglinux@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Tue, 2 May 2017, Jason Gerecke wrote:

> Just making sure this doesn't get lost in the cracks.

I will definitely be picking it up for 4.12-rc.

I believe you wanted to add Fixes: tag and -stable inclusion anotation as 
well.

Thanks,

-- 
Jiri Kosina
SUSE Labs

