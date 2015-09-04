From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 0/2] HID: logitech-hidpp: allow to disable tap to click
 on the K400
Date: Fri, 4 Sep 2015 14:50:19 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1509041450100.30132@pobox.suse.cz>
References: <1441285710-21276-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441285710-21276-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Nestor Lopez Casado <nlopezcasad@logitech.com>, simon@mungewell.org, BALATON Zoltan <balaton@eik.bme.hu>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 3 Sep 2015, Benjamin Tissoires wrote:

> Hi guys,
> 
> This series adds a new parameter for the K400 owners. This keyboard has an
> embedded touchpad which defaults to report tap to click. It can be annoying
> given that there are physical buttons, and we can just disable that from the
> host by using the feature 0x6010.
> 
> The first patch might conflict with Simon's current work in progress, so
> that's why Simon is CC-ed to it.

Now in for-4.4/logitech. Thanks,

-- 
Jiri Kosina
SUSE Labs
