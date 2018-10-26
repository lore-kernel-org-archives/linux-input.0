From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: i2c-hid: Add a small delay after sleep command
 for Raydium touchpanel
Date: Fri, 26 Oct 2018 17:09:40 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1810261709310.23511@cbobk.fhfr.pm>
References: <20181005044629.26286-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181005044629.26286-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: benjamin.tissoires@redhat.com, hdegoede@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 5 Oct 2018, Kai-Heng Feng wrote:

> Raydium touchpanel (2386:4B33) sometimes does not work in desktop session
> although it works in display manager.
> 
> During user logging, the display manager exits, close the HID device,
> then the device gets runtime suspended and powered off. The desktop
> session begins shortly after, opens the HID device, then the device gets
> runtime resumed and powered on.
> 
> If the trasition from display manager to desktop sesesion is fast, the
> touchpanel cannot switch from powered off to powered on in short
> timeframe. So add a small delay to workaround the issue.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
> - Use quirk to only match affected touchpanel
> - Only delay the next power on if the time hasn't elapsed

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
