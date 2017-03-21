From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: Accutouch: Add driver for ELO Accutouch 2216 USB
 Touchscreens
Date: Tue, 21 Mar 2017 15:04:30 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1703211504180.31814@cbobk.fhfr.pm>
References: <1487081876-9743-1-git-send-email-martyn.welch@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1487081876-9743-1-git-send-email-martyn.welch@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Martyn Welch <martyn.welch@collabora.co.uk>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 14 Feb 2017, Martyn Welch wrote:

> The Accutouch 2216 is reporting BTN_LEFT/BTN_MOUSE rather than BTM_TOUCH
> in it's capabilities, which is what user space expects a touchscreen
> device to report. This is causing udev to consider the device to be a
> "VMware's USB mouse" rather than as a touchscreen, which results in a
> mouse cursor being displayed in Weston.
> 
> This patch adds a special driver for the device to correct the
> capabilities reported.

Applied to for-4.12/accutouch. Thanks,

-- 
Jiri Kosina
SUSE Labs
