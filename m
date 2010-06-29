From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH v2] input: qt602240 - Add ATMEL QT602240 touchscreen	driver
Date: Tue, 29 Jun 2010 12:33:35 +0900
Message-ID: <4C29698F.9010409@samsung.com>
References: <1277430882-3685-1-git-send-email-jy0922.shim@samsung.com>
 <4C24B86E.1030407@euromail.se> <4C283048.1090601@samsung.com>
 <4C285124.1050201@euromail.se> <4C285AB1.7030301@samsung.com>
 <4C285E85.6080008@euromail.se> <4C2865D0.7020605@samsung.com>
 <4C28689A.60701@euromail.se> <4C2872B2.1030405@samsung.com>
 <4C2877F3.8020003@euromail.se> <4C2883A9.5060305@samsung.com>
 <4C28944A.4050501@euromail.se> <4C289C62.5090403@samsung.com>
 <4C28A279.2080100@euromail.se>
 <AANLkTimf-ku6PcfjVWmH0NwtBBxBGH7NWxC2NK6BPGmJ@mail.gmail.com>
 <AANLkTikNh-LTClIgXGAIEkegLCmWNnN2Zk05XhZWOumb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:16214 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320Ab0F2Ddi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Jun 2010 23:33:38 -0400
Received: from epmmp2 (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L4R00EYAB80IM60@mailout4.samsung.com> for
 linux-input@vger.kernel.org; Tue, 29 Jun 2010 12:33:36 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L4R00KEGB80PJ@mmp2.samsung.com> for
 linux-input@vger.kernel.org; Tue, 29 Jun 2010 12:33:36 +0900 (KST)
In-reply-to: <AANLkTikNh-LTClIgXGAIEkegLCmWNnN2Zk05XhZWOumb@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Murphy <murpdj72@gmail.com>
Cc: Joonyoung Shim <dofmind@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, kyungmin.park@samsung.com

Hi,

On 6/28/2010 11:26 PM, Dan Murphy wrote:
> I don't see any error handling from the IC here.
> 
> Generally this IC should give a few error messages if a X/Y line is broken,
> the chip goes into reset, or the chip is missed configured.
> 

The configuration error can occur and if the chip detect it, we get
messages from message object in interrupt handler and can see it. If 
needs, i can add error print.

> This is a bad situation here
> +       /* Read dummy message to make high CHG pin */
> +       do {
> +               ret = qt602240_read_object(data, QT602240_GEN_MESSAGE, 0);
> +               if (ret < 0)
> +                       return ret;
> +       } while (ret != 0xff);
> 
> The chip may have an error and constantly send you the message which means
> you will never get out of this loop.  This can be bad as your probe or
> load_fw may never return.
> 

Hmm, this chip reports always 0xff value if the message is nothing, but
i will add count to prevent unlikely loop.

Thanks.
