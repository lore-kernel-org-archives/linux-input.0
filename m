From: Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH v2] Input: add i2c/smbus driver for elan touchpad
Date: Thu, 6 Feb 2014 16:10:07 -0800
Message-ID: <CANLzEktFwEfvn52V7Up_PthnJzR3f-ni_0-_krpmx=jZJfo=EA@mail.gmail.com>
References: <1387338410-5930-1-git-send-email-dusonlin@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f178.google.com ([209.85.220.178]:38294 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077AbaBGAKI (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Feb 2014 19:10:08 -0500
Received: by mail-vc0-f178.google.com with SMTP id ik5so2060937vcb.37
        for <linux-input@vger.kernel.org>; Thu, 06 Feb 2014 16:10:07 -0800 (PST)
In-Reply-To: <1387338410-5930-1-git-send-email-dusonlin@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Duson Lin <dusonlin@emc.com.tw>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, agnescheng@chromium.org, phoenix@emc.com.tw

On Tue, Dec 17, 2013 at 7:46 PM, Duson Lin <dusonlin@emc.com.tw> wrote:
> This driver adds support for elan i2c/smbus touchpad found on some laptops PC
>
> Signed-off-by: Duson Lin <dusonlin@emc.com.tw>
Reviewed-by: Benson Leung <bleung@chromium.org>

Hi Dmitry,

This driver has been posted for a little while now. I've reviewed it,
and it is consistent with the cyapa.c driver that I submitted. Could
you take another look at this?

Thanks,
-- 
Benson Leung
Software Engineer, Chrom* OS
bleung@chromium.org
