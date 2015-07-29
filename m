From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH] HID: hid-input: Fix accessing freed memory during driver
 unbind
Date: Wed, 29 Jul 2015 15:07:04 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507291506500.925@pobox.suse.cz>
References: <1438042590-17719-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1438042590-17719-1-git-send-email-k.kozlowski@samsung.com>
Sender: stable-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, sre@kernel.org, linux-pm@vger.kernel.org, "H.J. Lu" <hjl.tools@gmail.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 28 Jul 2015, Krzysztof Kozlowski wrote:

> During unbinding the driver was dereferencing a pointer to memory
> already freed by power_supply_unregister().
> 
> Driver was freeing its internal description of battery through pointers
> stored in power_supply structure. However, because the core owns the
> power supply instance, after calling power_supply_unregister() the
> driver cannot access these members.
> 
> Fix this by using resource-managed allocations so internal data will be
> freed by pointers stored in resource-managed core.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reported-by: H.J. Lu <hjl.tools@gmail.com>
> Fixes: 297d716f6260 ("power_supply: Change ownership from driver to core")
> Cc: <stable@vger.kernel.org>

Applied to for-4.2/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs
