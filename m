From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: multitouch: do not blindly set EV_KEY or EV_ABS
 bits
Date: Thu, 13 Jul 2017 16:51:22 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1707131650340.26362@cbobk.fhfr.pm>
References: <20170711170218.GA30175@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170711170218.GA30175@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Matthias Fend <Matthias.Fend@wolfvision.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 11 Jul 2017, Dmitry Torokhov wrote:

> Now that input core insists on having dev->absinfo when device claims to
> generate EV_ABS in its dev->evbit, we should not be blindly setting that
> bit.
> 
> The code in question might have been needed before input_set_abs_params()
> started setting EV_ABS in device's evbit, but not anymore, and is now
> breaking devices such as SMART SPNL-6075 Touchscreen.
> 
> Fixes: 6ecfe51b4082 ("Input: refuse to register absolute devices ...")
> Reported-by: Matthias Fend <Matthias.Fend@wolfvision.net>
> Tested-by: Matthias Fend <Matthias.Fend@wolfvision.net>
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> Jiri, Benjamin, I marked it for stable as it causes regressions in 4.12
> reported by users. Please take a look.

Thanks for a quick fix, Dmitry. Queued in for-4.13/upstream-fixes branch.

-- 
Jiri Kosina
SUSE Labs
