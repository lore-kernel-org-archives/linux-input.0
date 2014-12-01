From: Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH] driver: input: touchscreen: add Raydium i2c touchscreen driver
Date: Mon, 1 Dec 2014 13:03:53 -0800
Message-ID: <CANLzEkshTf0ef-WWN64L55md4L+qsu0LTSR_KV1Ab8CVvgG9oA@mail.gmail.com>
References: <1417429031-4576-1-git-send-email-jeffrey.lin@rad-ic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:38718 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932158AbaLAVDx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 1 Dec 2014 16:03:53 -0500
Received: by mail-ob0-f182.google.com with SMTP id wo20so1466704obc.27
        for <linux-input@vger.kernel.org>; Mon, 01 Dec 2014 13:03:53 -0800 (PST)
In-Reply-To: <1417429031-4576-1-git-send-email-jeffrey.lin@rad-ic.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "jeffrey.lin" <yajohn@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, shc_work@mail.ru, lee.jones@linaro.org, charliemooney@chromium.org, KP.li@rad-ic.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "jeffrey.lin" <jeffrey.lin@rad-ic.com>

On Mon, Dec 1, 2014 at 2:17 AM, jeffrey.lin <yajohn@gmail.com> wrote:
> From: "jeffrey.lin" <jeffrey.lin@rad-ic.com>
>
> This patch is porting Raydium I2C touch driver. Developer can enable
> raydium touch driver by modifying define "CONFIG_TOUCHSCREEN_RM_TS".
>
> Change-Id: I5f33cfdf0e895de6e7d535c11dd4b3ce8b49fa48

Once again, please remove this bit of Gerrit change-id from your patch
submissions in the future.

> Signed-off-by: jeffrey.lin@rad-ic.com




-- 
Benson Leung
Software Engineer, Chrom* OS
bleung@chromium.org
