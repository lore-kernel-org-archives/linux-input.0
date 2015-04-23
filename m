From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH v2] Input - mt: Fix input_mt_get_slot_by_key
Date: Thu, 23 Apr 2015 19:10:55 +0200
Message-ID: <5539279F.4050400@bitmath.org>
References: <1427741655-4142-1-git-send-email-benjamin.tissoires@redhat.com>	<20150406163349.GD36770@dtor-ws>	<alpine.LNX.2.00.1504071517260.30181@pobox.suse.cz> <CAKdAkRROn=tCuSDmCqsugPAFBsTa5jEZsOEoTBCAFUrheM2X8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailrelay1.public.one.com ([91.198.169.124]:20983 "EHLO
	mailrelay1.public.one.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030272AbbDWRKv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Apr 2015 13:10:51 -0400
In-Reply-To: <CAKdAkRROn=tCuSDmCqsugPAFBsTa5jEZsOEoTBCAFUrheM2X8Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

> "Creation, replacement and destruction of contacts is achieved by
> modifying the ABS_MT_TRACKING_ID of the associated slot.  A
> non-negative tracking id is interpreted as a contact, and the value -1
> denotes an unused slot.  A tracking id not previously present is
> considered new, and a tracking id no longer present is considered
> removed."
> 
> If some userspace is confused with missing -1 tracking ID for that
> slot, that userspace should be fixed.

I agree. Some userland applications work with add/remove out of convenience, and
cannot handle the more compressed notation the kernel slot handling allows.
Fixing those applications will be a good thing.

Unfortunately the patch already appeared in Linus' tree...

Henrik

