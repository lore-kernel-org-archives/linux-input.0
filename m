From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 1/2] Input: zforce_ts: Delete an error message for a failed memory allocation in zforce_parse_dt()
Date: Sat, 20 Jan 2018 21:26:57 +0100
Message-ID: <4286739.AIUNhEQfUE@phil>
References: <e36553b1-3221-7944-59bd-6bb9358c488f@users.sourceforge.net> <2f111be7-11cd-d4a5-3c42-92290c1597d2@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:46490 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756615AbeATU2a (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 20 Jan 2018 15:28:30 -0500
In-Reply-To: <2f111be7-11cd-d4a5-3c42-92290c1597d2@users.sourceforge.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

Am Samstag, 20. Januar 2018, 21:18:45 CET schrieb SF Markus Elfring:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 20 Jan 2018 20:36:33 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

if it helps
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
