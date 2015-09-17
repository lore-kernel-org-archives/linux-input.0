From: Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH] elan_i2c - Don't require known iap version
Date: Thu, 17 Sep 2015 07:18:02 -0600
Message-ID: <CAD8Lp44FPcjwrMq626Avkh=9erjmeoWyzmUC0zWHdNsSQZsNsw@mail.gmail.com>
References: <1442437369-23192-1-git-send-email-drake@endlessm.com>
	<001b01d0f0e7$77be3490$673a9db0$@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:34230 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806AbbIQNSE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Sep 2015 09:18:04 -0400
Received: by wicfx3 with SMTP id fx3so23445384wic.1
        for <linux-input@vger.kernel.org>; Thu, 17 Sep 2015 06:18:02 -0700 (PDT)
In-Reply-To: <001b01d0f0e7$77be3490$673a9db0$@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: DusonLin <dusonlin@emc.com.tw>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>, linux-input@vger.kernel.org

Hi,

On Wed, Sep 16, 2015 at 7:23 PM, DusonLin <dusonlin@emc.com.tw> wrote:
> [Duson] I think it's better to change here " dev_err(dev,"

What do you prefer? dev_warn?

Thanks
Daniel
