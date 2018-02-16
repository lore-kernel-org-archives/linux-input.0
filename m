From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] input: Add driver for USB ELAN Touchpad
Date: Fri, 16 Feb 2018 13:24:48 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1802161324310.13621@cbobk.fhfr.pm>
References: <20180113233349.2480-1-neko@nya.ai>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49898 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966351AbeBPMYv (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 16 Feb 2018 07:24:51 -0500
In-Reply-To: <20180113233349.2480-1-neko@nya.ai>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexandrov Stansilav <neko@nya.ai>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com

On Sun, 14 Jan 2018, Alexandrov Stansilav wrote:

> This is driver for usb touchpad found on HP Pavilion x2 10-p0xx
> laptop. On this device keyboard and touchpad connected as a single
> usb device with two interfaces: keyboard, which exposes ordinary keys
> and second interface is touchpad which also contains FlightMode button and
> audio mute led (which physically placed on keyboard for some reason).
> 
> Initially, this touchpad works in mouse emulation mode, this driver will
> switch it to touchpad mode, which can track 5 fingers and can report
> coordinates for two of them.
> 
> Signed-off-by: Alexandrov Stansilav <neko@nya.ai>
> ---
>  drivers/hid/Kconfig      |   8 +
>  drivers/hid/Makefile     |   1 +
>  drivers/hid/hid-elan.c   | 421 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/hid/hid-ids.h    |   1 +
>  drivers/hid/hid-quirks.c |   3 +
>  5 files changed, 434 insertions(+)
>  create mode 100644 drivers/hid/hid-elan.c

Applied to for-4.17/hid-elan. Thanks,

-- 
Jiri Kosina
SUSE Labs

