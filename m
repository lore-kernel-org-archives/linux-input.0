From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH v3] HID: hid-input: Fix accessing freed memory during
 device disconnect
Date: Tue, 4 Aug 2015 15:47:49 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1508041547250.27871@pobox.suse.cz>
References: <1438581450-20728-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438581450-20728-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, sre@kernel.org, linux-pm@vger.kernel.org, "H.J. Lu" <hjl.tools@gmail.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 3 Aug 2015, Krzysztof Kozlowski wrote:

> During unbinding the driver was dereferencing a pointer to memory
> already freed by power_supply_unregister().
> 
> Driver was freeing its internal description of battery through pointers
> stored in power_supply structure. However, because the core owns the
> power supply instance, after calling power_supply_unregister() this
> memory is freed and the driver cannot access these members.
> 
> Fix this by storing the pointer to internal description of battery in a
> local variable before calling power_supply_unregister(), so the pointer
> remains valid.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reported-by: H.J. Lu <hjl.tools@gmail.com>
> Fixes: 297d716f6260 ("power_supply: Change ownership from driver to core")
> Cc: <stable@vger.kernel.org>

Applied to for-4.2/upstream-fixes-devm-fixed, and thanks again Dmitry for 
catching my mistake.

-- 
Jiri Kosina
SUSE Labs
