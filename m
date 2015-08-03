From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2] HID: hid-input: Fix accessing freed memory during
 device disconnect
Date: Mon, 03 Aug 2015 13:57:55 +0900
Message-ID: <55BEF4D3.7050903@samsung.com>
References: <1438560081-23055-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1438560081-23055-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, sre@kernel.org, linux-pm@vger.kernel.org, "H.J. Lu" <hjl.tools@gmail.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 03.08.2015 09:01, Krzysztof Kozlowski wrote:
> During unbinding the driver was dereferencing a pointer to memory
> already freed by power_supply_unregister().
>=20
> Driver was freeing its internal description of battery through pointe=
rs
> stored in power_supply structure. However, because the core owns the
> power supply instance, after calling power_supply_unregister() this
> memory is freed and the driver cannot access these members.
>=20
> Fix this by storing the pointer to internal description of battery in=
 a
> local variable before calling power_supply_unregister(), so the point=
er
> remains valid.
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reported-by: H.J. Lu <hjl.tools@gmail.com>
> Fixes: 297d716f6260 ("power_supply: Change ownership from driver to c=
ore")
> Cc: <stable@vger.kernel.org>
>=20
> ---
> Changes since v1:
> 1. Re-work idea, use local variable instead of devm-like functions
>    (pointed out by Dmitry Torokhov).
> 2. Adjusted subject and commit message.

I missed the warning:
drivers/hid/hid-input.c:470:11: warning: assignment discards =91const=92
qualifier from pointer target type

I'll fix this and send v3.

Best regards,
Krzysztof
