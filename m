From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: i2c-hid: Disable runtime PM on Goodix touchpad
Date: Mon, 14 Jan 2019 12:18:37 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1901141217550.6626@cbobk.fhfr.pm>
References: <20190114084734.3362-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114084734.3362-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 14 Jan 2019, Kai-Heng Feng wrote:

> A Goodix touchpad doesn't work. Touching the touchpad can trigger IRQ
> but there's no input event from HID subsystem.
> 
> Turns out it reports some invalid data:
> [   22.136630] i2c_hid i2c-DELL091F:00: input: 0b 00 01 00 00 00 00 00 00 00 00
> 
> After some trial and error, it's another device that doesn't work well
> with ON/SLEEP commands. Disable runtime PM to fix the issue.

Thanks, I've now applied the patch to for-5.0/upstream-fixes. I am 
wondering though we are we seeing these at all - do other OSes not do the 
runtime PM on i2c at all?

-- 
Jiri Kosina
SUSE Labs
