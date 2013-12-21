From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 7/9] Input: pixcir_i2c_ts: Implement Type B Multi Touch
 reporting
Date: Sat, 21 Dec 2013 21:02:56 +0100
Message-ID: <52B5F3F0.30203@euromail.se>
References: <1387358480-8313-1-git-send-email-rogerq@ti.com> <1387358480-8313-8-git-send-email-rogerq@ti.com> <20131218141841.GE28504@core.coreip.homeip.net> <52B288ED.80904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h21.telenor.se ([195.54.99.196]:56793 "EHLO
	smtprelay-h21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755612Ab3LUUBH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Dec 2013 15:01:07 -0500
In-Reply-To: <52B288ED.80904@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: jcbian@pixcir.com.cn, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

Hi Roger,

> It seems the controller the original driver was written for does not report
> touch ID and just reports 2 touch co-ordinates. I'm not sure how this fits into
> Type B reporting model.

Look in drivers/input/mouse/cypress_ps2.c for an example of how to deal with
anonymous touch coordinates.

Thanks,
Henrik

