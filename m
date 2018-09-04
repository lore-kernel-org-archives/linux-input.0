From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 1/4] HID: multitouch: fix Elan panels with 2 input modes
 declaration
Date: Tue, 4 Sep 2018 21:31:09 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1809042130260.15880@cbobk.fhfr.pm>
References: <20180904133115.5111-1-benjamin.tissoires@redhat.com> <20180904133115.5111-2-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180904133115.5111-2-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 4 Sep 2018, Benjamin Tissoires wrote:

> When implementing commit 7f81c8db5489 ("HID: multitouch: simplify
> the settings of the various features"), I wrongly removed a test
> that made sure we never try to set the second InputMode feature
> to something else than 0.
> 
> This broke badly some recent Elan panels that now forget to send the
> click button in some area of the touchpad.
> 
> Fixes 7f81c8db5489

Please make sure that the 'Fixes:' tag is always in proper format. There 
are tools depending on that :)

I'll fix that up manually.

Thanks!

-- 
Jiri Kosina
SUSE Labs
