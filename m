From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 0/4] HID: logitech-hidpp: fixes for error conditions
Date: Thu, 11 Dec 2014 23:11:18 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1412112310360.6679@pobox.suse.cz>
References: <1418302280-14794-1-git-send-email-peter@lekensteyn.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1418302280-14794-1-git-send-email-peter@lekensteyn.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Wu <peter@lekensteyn.nl>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 11 Dec 2014, Peter Wu wrote:

> Hi Jiri,
> 
> Here are four patches intended for the 3.19 stream and are based on
> jikos/hid (for-next, v3.18-rc4-144-gd9372ee).
> 
> * The first is actually from Benjamin Tissoires, but modified to remove
>   a now unneeded goto.
> * The second one depends on the first (it could work without, but there
>   will be a context mismatch).
> * The third one can be applied independently of the others and is needed
>   to avoid a possible buffer overread.
> * The fourth and final patch fixes an unbalanced hid_device_io_start().
> 
> Tested by booting with three paired USB devices (QEMU + USB
> passthrough), two of them are powered off and one M525 is active. evbug
> registers mouse events.
> 

Good stuff, thanks!

Applied.

-- 
Jiri Kosina
SUSE Labs
