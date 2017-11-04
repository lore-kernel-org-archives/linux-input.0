From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 resend 0/1] Input: add support HiDeep touchscreen.
Date: Fri, 3 Nov 2017 17:35:52 -0700
Message-ID: <20171104003552.ve2elx6s4azzyd6q@dtor-ws>
References: <1509445077-19246-1-git-send-email-anthony.kim@hideep.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:44739 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751805AbdKDAf4 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 3 Nov 2017 20:35:56 -0400
Content-Disposition: inline
In-Reply-To: <1509445077-19246-1-git-send-email-anthony.kim@hideep.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anthony Kim <anthony.kim@hideep.com>
Cc: robh+dt@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dennis.hong@hideep.com

Hi Anthony,

On Tue, Oct 31, 2017 at 07:17:56PM +0900, Anthony Kim wrote:
> Hi,
> 
> I remake patch to base on dmitry's modified code.
> Please refer as follow.
> http://www.spinics.net/lists/linux-input/msg53724.html
> 
> That code is working well almost, but needed to some modified.
> 
> - v2
>   - Our fw binary data is little endian, but our IC protocol
>     for fw update use big endian. So it need to convert to big endian data
>     and I added about it.

I understand that _currently_ your firmware binary is little endian,
however it is easily remedied on your side. I do not understand why you
would want to encumber the kernel running on many devices to do that
conversion on fly.

Thanks.

-- 
Dmitry
