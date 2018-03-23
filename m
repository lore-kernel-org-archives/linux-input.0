From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 0/7] HID core and multitouch fixups
Date: Fri, 23 Mar 2018 14:55:36 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1803231455220.15778@cbobk.fhfr.pm>
References: <20180320110451.16582-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180320110451.16582-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 20 Mar 2018, Benjamin Tissoires wrote:

> Patches 1 and 2 are related to the Razer Blade Stealth that has some dead zone
> near the edges of the touchpad.
> Patches 3 was previously sent and reviewed by Dmitry and he suggested patch 4
> at the time.
> Patches 5..7 are cleanups I realized while trying to merge hid-multitouch
> into hid-core, so that other drivers could reuse the hid-mt logic (but it's
> not that easy I must confess).

I've split this into two logical sets, and applied. Thanks!

-- 
Jiri Kosina
SUSE Labs
