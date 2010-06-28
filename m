From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH v2] input: qt602240 - Add ATMEL QT602240 touchscreen driver
Date: Mon, 28 Jun 2010 20:12:41 +0900
Message-ID: <4C2883A9.5060305@samsung.com>
References: <1277430882-3685-1-git-send-email-jy0922.shim@samsung.com>
 <4C24B86E.1030407@euromail.se> <4C283048.1090601@samsung.com>
 <4C285124.1050201@euromail.se> <4C285AB1.7030301@samsung.com>
 <4C285E85.6080008@euromail.se> <4C2865D0.7020605@samsung.com>
 <4C28689A.60701@euromail.se> <4C2872B2.1030405@samsung.com>
 <4C2877F3.8020003@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:27700 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182Ab0F1LMn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Jun 2010 07:12:43 -0400
Received: from epmmp1 (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L4Q00FW11T6TR50@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Mon, 28 Jun 2010 20:12:42 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L4Q00E1U1T6J0@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Mon, 28 Jun 2010 20:12:42 +0900 (KST)
In-reply-to: <4C2877F3.8020003@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, kyungmin.park@samsung.com

On 6/28/2010 7:22 PM, Henrik Rydberg wrote:
> Joonyoung Shim wrote:
> [...]
>> Do you mean to report the coordinates of contact __remaining__? You told 
>> me at first, "The position should be the position where the finger left
>> the surface", so i am confusing.
> 
> The two comments do not apply to the same situation. The latter comment was made
> in the context of a tracking-capable device which sends one last event for a
> finger going away. Transformed to the stateless type A protocol, that results in
> (touch = 0, x = last value, y = last value). 
> The former comment was in the
> general context of the type A protocol, which has no notion of anything going
> away. After you lift a finger and look at the state, what you see is the
> remaining set of fingers.
> 

OK, i see, but i think it needs to add the latter comment on MT protocol 
document to prevent some confusion.

