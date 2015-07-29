From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HID: hid-input: Fix accessing freed memory during driver
 unbind
Date: Wed, 29 Jul 2015 10:46:19 -0700
Message-ID: <20150729174619.GC23178@dtor-ws>
References: <1438042590-17719-1-git-send-email-k.kozlowski@samsung.com>
 <alpine.LNX.2.00.1507291506500.925@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1507291506500.925@pobox.suse.cz>
Sender: stable-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, sre@kernel.org, linux-pm@vger.kernel.org, "H.J. Lu" <hjl.tools@gmail.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Jul 29, 2015 at 03:07:04PM +0200, Jiri Kosina wrote:
> On Tue, 28 Jul 2015, Krzysztof Kozlowski wrote:
> 
> > During unbinding the driver was dereferencing a pointer to memory
> > already freed by power_supply_unregister().
> > 
> > Driver was freeing its internal description of battery through pointers
> > stored in power_supply structure. However, because the core owns the
> > power supply instance, after calling power_supply_unregister() the
> > driver cannot access these members.
> > 
> > Fix this by using resource-managed allocations so internal data will be
> > freed by pointers stored in resource-managed core.
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Reported-by: H.J. Lu <hjl.tools@gmail.com>
> > Fixes: 297d716f6260 ("power_supply: Change ownership from driver to core")
> > Cc: <stable@vger.kernel.org>
> 
> Applied to for-4.2/upstream-fixes, thanks.

Wait, what guarantees do we have that this is only called in probe()
paths? Don't we allow hid_hw_start() be deferred to open() calls?

In general we need to be careful with devm* conversions in core code.

Thanks.

-- 
Dmitry
