From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: [PATCH v2] OMAP3: Keypad: Fix failure exit path in probe
Date: Tue, 21 Sep 2010 16:34:20 +0300
Message-ID: <1285076060.14206.3.camel@chotu>
References: <1285069770-4261-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:22490 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234Ab0IUNen (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Sep 2010 09:34:43 -0400
In-Reply-To: <1285069770-4261-1-git-send-email-manjugk@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "ext G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dtor@mail.ru>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>

Hi Manjunath,

On Tue, 2010-09-21 at 13:49 +0200, ext G, Manjunath Kondaiah wrote:
> The failure exit paths seems to be wrong in probe function.
> This patch corrects exit failure paths for error handling
> cases.

https://patchwork.kernel.org/patch/160551/
Any comments on this?

Cheers,
Ameya.

