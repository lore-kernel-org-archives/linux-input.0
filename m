From: Kai Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] HID: i2c-hid: Disable runtime PM on Goodix touchpad
Date: Wed, 16 Jan 2019 16:21:21 +0800
Message-ID: <663EE74C-02E8-49DB-A197-2022AFE2D863@canonical.com>
References: <20190114084734.3362-1-kai.heng.feng@canonical.com>
 <nycvar.YFH.7.76.1901141217550.6626@cbobk.fhfr.pm>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.1901141217550.6626@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org



> On Jan 14, 2019, at 19:18, Jiri Kosina <jikos@kernel.org> wrote:
> 
> On Mon, 14 Jan 2019, Kai-Heng Feng wrote:
> 
>> A Goodix touchpad doesn't work. Touching the touchpad can trigger IRQ
>> but there's no input event from HID subsystem.
>> 
>> Turns out it reports some invalid data:
>> [   22.136630] i2c_hid i2c-DELL091F:00: input: 0b 00 01 00 00 00 00 00 00 00 00
>> 
>> After some trial and error, it's another device that doesn't work well
>> with ON/SLEEP commands. Disable runtime PM to fix the issue.
> 
> Thanks, I've now applied the patch to for-5.0/upstream-fixes. I am 
> wondering though we are we seeing these at all - do other OSes not do the 
> runtime PM on i2c at all?

According to the vendor, Windows does use ON/SLEEP, but infrequently.

We can use pm_runtime_use_autosuspend() to reduce the frequency of
ON/SLEEP commands, but it’s just papering over the touchpad firmware
bug.

Kai-Heng

> 
> -- 
> Jiri Kosina
> SUSE Labs
> 
