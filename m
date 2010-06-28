From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH v2] input: qt602240 - Add ATMEL QT602240 touchscreen driver
Date: Mon, 28 Jun 2010 15:24:09 +0200
Message-ID: <4C28A279.2080100@euromail.se>
References: <1277430882-3685-1-git-send-email-jy0922.shim@samsung.com> <4C24B86E.1030407@euromail.se> <4C283048.1090601@samsung.com> <4C285124.1050201@euromail.se> <4C285AB1.7030301@samsung.com> <4C285E85.6080008@euromail.se> <4C2865D0.7020605@samsung.com> <4C28689A.60701@euromail.se> <4C2872B2.1030405@samsung.com> <4C2877F3.8020003@euromail.se> <4C2883A9.5060305@samsung.com> <4C28944A.4050501@euromail.se> <4C289C62.5090403@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:33969 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751535Ab0F1NZA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Jun 2010 09:25:00 -0400
In-Reply-To: <4C289C62.5090403@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, kyungmin.park@samsung.com

Joonyoung Shim wrote:
[...]
> What is the full set of anonymous contacts? It needs the description of
> case sending event for a finger going away.

I disagree. Protocol A deals with devices that do not necessarily know what
going away means. There is a whole new protocol devoted to your kind of
hardware, type B, and using protocol A is simply not encouraged.

Thanks,
Henrik
