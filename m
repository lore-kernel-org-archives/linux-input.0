From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH] Prevent the NULL dereferencing
Date: Wed, 6 Apr 2011 20:47:12 +0800
Message-ID: <BANLkTi=m+mmnResbhBKZ+7oeR7RtvrTvWw@mail.gmail.com>
References: <1301997495-20876-1-git-send-email-shubhrajyoti@ti.com> <4D9AEE22.3050602@ti.com>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45803 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755763Ab1DFMrc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Apr 2011 08:47:32 -0400
Received: by vws1 with SMTP id 1so1036743vws.19
        for <linux-input@vger.kernel.org>; Wed, 06 Apr 2011 05:47:32 -0700 (PDT)
In-Reply-To: <4D9AEE22.3050602@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shubhrajyoti <shubhrajyoti@ti.com>
Cc: linux-input@vger.kernel.org, Shubhrajyoti D <a0393217@india.ti.com>

2011/4/5 Shubhrajyoti <shubhrajyoti@ti.com>:
> On Tuesday 05 April 2011 03:28 PM, shubhrajyoti@ti.com wrote:
>>
>> From: Shubhrajyoti D<a0393217@india.ti.com>
>>
>>
>> Signed-off-by: Shubhrajyoti D<a0393217@india.ti.com>
>
> Axel's patch added changes to prevent NULL access if pdata is NULL adding a
> check for keymap_data.
>>

Acked-by: Axel Lin <axel.lin@gmail.com>
