From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: cp2112: prevent sleeping function called from
 invalid context
Date: Mon, 19 Aug 2019 14:13:35 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1908191413200.27147@cbobk.fhfr.pm>
References: <20190812160444.10402-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190812160444.10402-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: David Barksdale <dbarksdale@uplogix.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 12 Aug 2019, Benjamin Tissoires wrote:

> When calling request_threaded_irq() with a CP2112, the function
> cp2112_gpio_irq_startup() is called in a IRQ context.
> 
> Therefore we can not sleep, and we can not call
> cp2112_gpio_direction_input() there.
> 
> Move the call to cp2112_gpio_direction_input() earlier to have a working
> driver.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Pushed out to for-5.3/upstream-fixes.

-- 
Jiri Kosina
SUSE Labs
