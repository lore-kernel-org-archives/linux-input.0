From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: usbhid: fix out-of-bounds bug
Date: Wed, 11 Oct 2017 15:06:00 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1710111505490.14384@jbgna.fhfr.qr>
References: <CAL6iAaJQZ4JB6udi3UFyGM0uYYE4NECZ5fK8ujb+ANfwe9tYDw@mail.gmail.com> <1506593790-19865-1-git-send-email-climbbb.kim@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43335 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752117AbdJKNGC (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 11 Oct 2017 09:06:02 -0400
In-Reply-To: <1506593790-19865-1-git-send-email-climbbb.kim@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaejoong Kim <climbbb.kim@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrey Konovalov <andreyknvl@google.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, USB list <linux-usb@vger.kernel.org>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, syzkaller <syzkaller@googlegroups.com>

On Thu, 28 Sep 2017, Jaejoong Kim wrote:

> The hid descriptor identifies the length and type of subordinate
> descriptors for a device. If the received hid descriptor is smaller than
> the size of the struct hid_descriptor, it is possible to cause
> out-of-bounds.
> 
> In addition, if bNumDescriptors of the hid descriptor have an incorrect
> value, this can also cause out-of-bounds while approaching hdesc->desc[n].
> 
> So check the size of hid descriptor and bNumDescriptors.

Applied to for-4.14/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs

