From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH] Input: tegra-kbc: fix inverted reset logic
Date: Tue, 16 Aug 2016 16:46:31 +0530
Message-ID: <57B2F60F.2000506@nvidia.com>
References: <1471316363-19378-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19931 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753273AbcHPLdD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Aug 2016 07:33:03 -0400
In-Reply-To: <1471316363-19378-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Rakesh Iyer <riyer@nvidia.com>, linux-tegra@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>


On Tuesday 16 August 2016 08:29 AM, Masahiro Yamada wrote:
> Commit fe6b0dfaba68 ("Input: tegra-kbc - use reset framework")
> accidentally converted _deassert to _assert, so there is no code
> to wake up this hardware.
>
> Fixes: fe6b0dfaba68 ("Input: tegra-kbc - use reset framework")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
