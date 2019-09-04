From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: modify quirks of i2c-hid driver for weida's
 devices
Date: Wed, 4 Sep 2019 14:32:39 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1909041432310.31470@cbobk.fhfr.pm>
References: <1567151910-3819-1-git-send-email-hn.chen@weidahitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1567151910-3819-1-git-send-email-hn.chen@weidahitech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hn.chen@weidahitech.com
Cc: linux-input@vger.kernel.org, benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com
List-Id: linux-input@vger.kernel.org

On Fri, 30 Aug 2019, hn.chen@weidahitech.com wrote:

> From: HungNien Chen <hn.chen@weidahitech.com>
> 
> This 'SET_PWR_WAKEUP_DEV' quirk only works for weida's devices with pid
> 0xC300 & 0xC301. Some weida's devices with other pids also need this quirk
> now. Use 'HID_ANY_ID' instead of 0xC300 to make all of weida's devices can be
> fixed on the power on issue. This modification should be safe since devices
> without power on issue will send the power on command only once.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
