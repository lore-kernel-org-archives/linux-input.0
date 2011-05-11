From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH] touchscreen: check kzalloc memory for data first
Date: Wed, 11 May 2011 12:03:43 +0900
Message-ID: <4DC9FC8F.7020305@samsung.com>
References: <BANLkTi=yWrPiz9Wp0H46at4NVfMSJ8n1uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:47548 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838Ab1EKDDx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 May 2011 23:03:53 -0400
In-reply-to: <BANLkTi=yWrPiz9Wp0H46at4NVfMSJ8n1uw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Steven Liu <lingjiujianke@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, liuqi@thunderst.com

Hi, Steven.

On 2011-05-11 =EC=98=A4=EC=A0=84 11:23, Steven Liu wrote:
> Hi Joonyoung Shim ,
>
>              Can this patch be fixed in?
>
>
> if kzalloc memroy for data was faild, it will multi free data
> memory space. so check the data memory first, is it kzalloc faild
> for data, it should goto end and do nothing.
>

Hmm, I don't think this patch needs. If you see the codes, there is no
multi free data memory, just free data and input_dev. This both free
are no problem because when the pointer is NULL, no operation is
perfomed in the free function.

Thanks.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
