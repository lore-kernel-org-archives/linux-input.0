From: Sundar R IYER <sundar.iyer@stericsson.com>
Subject: RE: [PATCH 13/20] mfd/tc3589x: add suspend/resume support
Date: Fri, 10 Dec 2010 05:32:46 +0100
Message-ID: <33A307AF30D7BF4F811B1568FE7A9B18047C7D4282@EXDCVYMBSTM006.EQ1STM.local>
References: <1291388753-14662-1-git-send-email-sundar.iyer@stericsson.com>
 <1291388753-14662-14-git-send-email-sundar.iyer@stericsson.com>
 <20101209170356.GY8884@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:40482 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752464Ab0LJEd3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 9 Dec 2010 23:33:29 -0500
In-Reply-To: <20101209170356.GY8884@sortiz-mobl>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Sam,

>-----Original Message-----
>
>SIMPLE_DEV_PM_OPS or UNIVERSAL_DEV_PM_OPS may be useful and save
>one ifdef
>here.

Sure, better.

And thanx for ack'ing all those patches; I will repost with your Acked-bys and rebased.

Cheers!


