From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: Add fuzz factor to distance and tilt axes
Date: Tue, 3 May 2016 11:57:28 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1605031157150.27942@cbobk.fhfr.pm>
References: <CANRwn3SMQ2mtCHQw3YKt6dt+KvNpe0yzxVMGvNRNstzwT9um4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41624 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755791AbcECJ52 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 3 May 2016 05:57:28 -0400
In-Reply-To: <CANRwn3SMQ2mtCHQw3YKt6dt+KvNpe0yzxVMGvNRNstzwT9um4w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Mon, 25 Apr 2016, Jason Gerecke wrote:

> The fuzz present on the distance and tilt axes is noticable when a puck is
> present, and userspace (specifically libinput) would like the ability to
> filter out the noise. To facilitate this, we assign a fuzz value of '1'
> for the distance and tilt axes. This is large enough to cover most of the
> natural variation in distance value as the puck is moved around, and
> enough to cover the jitter in rotation (reported through tilt axes) when
> the puck is left alone.

Applied to for-4.7/wacom.

-- 
Jiri Kosina
SUSE Labs

