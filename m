From: Eric Piel <eric.piel@tremplin-utc.net>
Subject: Re: [PATCH] wistron-btns: Drop Acer Aspire 3020 & 5020 support
Date: Fri, 08 Feb 2008 11:20:13 +0100
Message-ID: <47AC2CDD.3010406@tremplin-utc.net>
References: <20080208015941.14737.95961.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:26542 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756528AbYBHKrs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Feb 2008 05:47:48 -0500
In-Reply-To: <20080208015941.14737.95961.stgit@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Carlos Corbacho wrote:
> With acer-wmi now merged, the last reason to keep support for the Acer
> Aspire 3020 & 5020 in wistron-btns is gone.
> 
> The keys do not need polling, and are already mapped in userspace by HAL.
> 
> The other functionality (mail LED, bluetooth and wireless) is already
> available in acer-wmi, and surpassed (we can read the status of all these
> devices, we can export the backlight, and acer-wmi can also work on
> x86-64 with the Aspire 5020, which wistron-btns cannot do).
> 
> Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
> CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> CC: Eric Piel <eric.piel@tremplin-utc.net>
It's great that acer-wmi finally arrived in the kernel :-)

Acked-by: Eric Piel <eric.piel@tremplin-utc.net>

Eric
