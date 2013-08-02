From: Duan Fugang-B38611 <B38611@freescale.com>
Subject: RE: [PATCH 25/35] Input: touchscreen: use dev_get_platdata()
Date: Fri, 2 Aug 2013 23:31:11 +0000
Message-ID: <9848F2DB572E5649BA045B288BE08FBE015EB706@039-SN2MPN1-023.039d.mgd.msft.net>
References: <005401ce8cfc$f70d1500$e5273f00$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-db8lp0189.outbound.messaging.microsoft.com ([213.199.154.189]:18041
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751978Ab3HBXbU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 2 Aug 2013 19:31:20 -0400
In-Reply-To: <005401ce8cfc$f70d1500$e5273f00$@samsung.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>, 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Dmitry Torokhov' <dtor@mail.ru>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

From: linux-input-owner@vger.kernel.org [mailto:linux-input-owner@vger.kernel.org] On Behalf Of Jingoo Han
Data: Tuesday, July 30, 2013 4:16 PM

> Use the wrapper function for retrieving the platform data instead of
> accessing dev->platform_data directly.

The serial patches look good. But for the serial patch set, it is better to submit one patch summary for them.
Acked-by: Fugang Duan <B38611@freescale.com>

