From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/6] ARM: pxa remove irq_to_gpio from eeti_ts driver
Date: Wed, 8 Aug 2012 14:38:04 +0000
Message-ID: <201208081438.04931.arnd@arndb.de>
References: <1344430493-5304-1-git-send-email-arnd@arndb.de> <201208081419.17181.arnd@arndb.de> <50227615.1090907@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:53582 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727Ab2HHOiN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Aug 2012 10:38:13 -0400
In-Reply-To: <50227615.1090907@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, linux-arm-kernel@lists.infradead.org, arm@kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sven Neumann <s.neumann@raumfeld.com>, linux-input@vger.kernel.org

On Wednesday 08 August 2012, Daniel Mack wrote:
> > 
> > I've taken your patch instead now, 
> 
> Will that go to some other tree than linux-input now?

I have it in the arm-soc tree for now, but I don't really care
which tree it goes through, as long as it does. I've kept a
version of this patch in one branch with random fixes that
I try to clear out now.

Other than that, I'm fine with whatever Dmitry prefers.

	Arnd
