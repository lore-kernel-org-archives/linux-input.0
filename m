From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 2/2] input: keyboard: MCS5080: support shutdown.
Date: Mon, 13 Dec 2010 01:01:22 -0800
Message-ID: <20101213090121.GG21401@core.coreip.homeip.net>
References: <4CE617CD.2090006@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f170.google.com ([209.85.214.170]:43036 "EHLO
	mail-iw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756782Ab0LMJJO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Dec 2010 04:09:14 -0500
Received: by iwn6 with SMTP id 6so8835950iwn.1
        for <linux-input@vger.kernel.org>; Mon, 13 Dec 2010 01:09:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CE617CD.2090006@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Kim, HeungJun" <riverful.kim@samsung.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>

On Fri, Nov 19, 2010 at 03:23:09PM +0900, Kim, HeungJun wrote:
> This patch supports shutdown functions for mcs5080 touchkey
> driver.
> 

Rarely a device needs shutdown method; normally it is enough to simply
cut power off. Why this device needs it?

Thanks.

-- 
Dmitry
