From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [Patch-V2 1/6] INPUT: xpad: Add minimal support for Logitech
 G920 Wheel
Date: Thu, 19 Nov 2015 14:50:51 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1511191449130.20111@pobox.suse.cz>
References: <1447345535-2912-1-git-send-email-simon@mungewell.org> <1447345535-2912-2-git-send-email-simon@mungewell.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447345535-2912-2-git-send-email-simon@mungewell.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Edwin <Edwin@Velds.nl>, =?ISO-8859-15?Q?Michal_Mal=FD?= <madcatxster@devoid-pointer.net>, elias vanderstuyft <elias.vds@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

On Thu, 12 Nov 2015, Simon Wood wrote:

> When plugged in the Logitech G920 wheel starts with USBID 046d:c261
> and behaviors as a vendor specific class. If a 'magic' byte sequence
> is sent the wheel will detach and reconnect as a HID device with the
> USBID 046d:c262.
> 
> Signed-off-by: Simon Wood <simon@mungewell.org>

Adding Dmitry to CC.

Dmitry, I am planning to take this through my tree together with the rest 
of the actual HID support for that device if you Ack this.

Thanks,

-- 
Jiri Kosina
SUSE Labs
