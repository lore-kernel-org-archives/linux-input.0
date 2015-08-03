From: Carlo Caione <carlo@caione.org>
Subject: Re: [linux-sunxi] [PATCH] Input: axp20x-pek: Add module alias
Date: Mon, 3 Aug 2015 09:56:09 +0200
Message-ID: <CAOQ7t2Zv7wSba0BGypf5_h74Jzf5eDDRuX1wmt7NTfw5RKansQ@mail.gmail.com>
References: <1438588080-15477-1-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:35891 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbbHCH4L (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Aug 2015 03:56:11 -0400
In-Reply-To: <1438588080-15477-1-git-send-email-wens@csie.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org, "linux-sunxi@googlegroups.com" <linux-sunxi@googlegroups.com>, Carlo Caione <carlo@caione.org>, Hans de Goede <hdegoede@redhat.com>

On Mon, Aug 3, 2015 at 9:48 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> Add a proper module alias so the driver can be autoloaded when the
> parent axp20x mfd driver registers its cells.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Carlo Caione <carlo@caione.org>

Thanks,

-- 
Carlo Caione
