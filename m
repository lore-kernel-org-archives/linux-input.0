From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: ABS_MT_TOUCH_MAJOR metric
Date: Thu, 22 May 2014 21:46:09 +0200
Message-ID: <537E5401.9000109@euromail.se>
References: <537DD98C.5090800@cypress.com> <20140522172353.GA1984@core.coreip.homeip.net> <537E5027.9010705@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h21.telenor.se ([195.54.99.196]:53759 "EHLO
	smtprelay-h21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbaEVUBY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 May 2014 16:01:24 -0400
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-h21.telenor.se (Postfix) with ESMTP id DF1EEC345
	for <linux-input@vger.kernel.org>; Thu, 22 May 2014 21:41:08 +0200 (CEST)
In-Reply-To: <537E5027.9010705@cypress.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ferruh Yigit <fery@cypress.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Ferruh,

> I understand this works for Dmitry ABS_X, ABS_Y,
> touchscreen reports between 0..A, screen resolution is 0..B, a mapping
> can be done 0..A -> 0..B
> 
> But for ABS_MT_TOUCH_MAJOR how this scaling can be done,
> touchscreen reports between 0..A, do we know the min/max values for
> application side?

You are right to be confused here. The axes you refer to are, in a way,
meaningless because both TOUCH_MAJOR and TOUCH_MINOR (and the corresponding
WIDTH_MAJOR and WIDTH_MINOR) are assumed to be measured in surface coordinates,
i.e., of the same scale as ABS_X and ABS_Y.

Historically, these axes have had specific values anyways, as an indication of
how large a touch area can be a the specific device. This is how userland MT
applications interpret the data. Strictly speaking, this is incorrect, but
that's how it is.

Henrik

