From: Jinsung Yang <jsgood.yang@samsung.com>
Subject: RE: [PATCH 03/03] [INPUT][KEYBOARD] Add new keypad driver for s3c
 series SoCs
Date: Mon, 07 Sep 2009 20:32:19 +0900
Message-ID: <002c01ca2fae$dc327630$94976290$%yang@samsung.com>
References: <00b101ca2e30$84135d90$8c3a18b0$%yang@samsung.com>
 <4AA49C53.3030400@samsung.com> <20090907063341.GT3962@prithivi.gnumonks.org>
 <4AA4B6E9.2070603@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:45455 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbZIGL3k (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Sep 2009 07:29:40 -0400
Received: from epmmp1 (mailout2.samsung.com [203.254.224.25])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0KPL008JEMLHY8@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Mon, 07 Sep 2009 20:29:41 +0900 (KST)
Received: from JSGOODMAIN ([12.23.109.106])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0KPL00EMQMLH9Q@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Mon, 07 Sep 2009 20:29:41 +0900 (KST)
In-reply-to: <4AA4B6E9.2070603@samsung.com>
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Joonyoung Shim' <jy0922.shim@samsung.com>, 'Harald Welte' <laforge@gnumonks.org>
Cc: linux-input@vger.kernel.org, ben-linux@fluff.org, =?utf-8?B?JyLquYDqsr3snbwvQVDqsJzrsJztjIAoU1lTLkxTSSkvRTMo7IKs7JuQ?= =?utf-8?B?KS/sgrzshLHsoITsnpAiJw==?= <ki0351.kim@samsung.com>, =?utf-8?B?JyIn6rmA6rWt7KeEL0FQ6rCc67Cc7YyAKFNZUy5MU0kpL0U1KOyxheyehCk=?= =?utf-8?B?L+yCvOyEseyghOyekCciJw==?= <kgene.kim@samsung.com>, dmitry.torokhov@gmail.com, kyungmin.park@samsung.com, jh80.chung@samsung.com

Hi, Mr.Shim

> >    submitted mainline.  This is what Jinsun was starting, and which he
> >    will continue until it is included mainline.
> >
> 
> The keypad of s3c64xx and s5pc1xx is same almost, so we need to submit
> the well-defined driver from the first.

I have some questions:
1) Could you explain to us what is the 'well-defined' driver?
2) Did you test your keypad driver at s3c6410 based platform?
3) There is no architecture codes for s5pc1xx series, why did you send keypad driver first for s5pc1xx before architecture codes?

Best Regards
--
Jinsung, Yang <jsgood.yang@samsung.com>
AP Development Team
System LSI, Semiconductor Business
SAMSUNG Electronics Co., LTD


