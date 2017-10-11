From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: usbhid: Convert timers to use timer_setup()
Date: Wed, 11 Oct 2017 15:22:40 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1710111522200.14384@jbgna.fhfr.qr>
References: <20171005005324.GA23752@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44878 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752006AbdJKNWm (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 11 Oct 2017 09:22:42 -0400
In-Reply-To: <20171005005324.GA23752@beast>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>

On Wed, 4 Oct 2017, Kees Cook wrote:

> In preparation for unconditionally passing the struct timer_list pointer to
> all timer callbacks, switch to using the new timer_setup() and from_timer()
> to pass the timer pointer explicitly. Adds pointer back to hid_device for
> multitouch.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

