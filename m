From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH] Input: atmel_mxt_ts - split config update a bit
Date: Thu, 24 Jul 2014 16:34:18 +0100
Message-ID: <53D1277A.2020006@itdev.co.uk>
References: <20140723232954.GA13095@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:23073 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759114AbaGXPeV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Jul 2014 11:34:21 -0400
In-Reply-To: <20140723232954.GA13095@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Yufeng Shen <miletus@chromium.org>, Benson Leung <bleung@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, linux-kernel@vger.kernel.org

On 24/07/14 00:29, Dmitry Torokhov wrote:
> Let's split config update code a bit so it is hopefully a bit easier to
> read. Also, the firmware update callback should be the entity releasing
> firmware blob, not lower layers.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks, this is obviously sensible. I will bring this into my patch series
and test it.
