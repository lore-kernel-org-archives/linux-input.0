From: Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH] driver: input: touchscreen: add Raydium i2c touchscreen driver
Date: Wed, 19 Nov 2014 10:05:43 -0800
Message-ID: <CANLzEkuJaAk4fNamTQuDn1ALyWZVE1d3sz9qdDB+zykOgXEctg@mail.gmail.com>
References: <1416411048-23526-1-git-send-email-jeffrey.lin@rad-ic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:52103 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754658AbaKSSFo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Nov 2014 13:05:44 -0500
Received: by mail-ob0-f172.google.com with SMTP id wn1so882692obc.17
        for <linux-input@vger.kernel.org>; Wed, 19 Nov 2014 10:05:44 -0800 (PST)
In-Reply-To: <1416411048-23526-1-git-send-email-jeffrey.lin@rad-ic.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "jeffrey.lin" <yajohn@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, dh.herrmann@gmail.com, charliemooney@chromium.org, floe@butterbrot.org, jeffrey.lin@rad-ic.com, roger.yang@rad-ic.com, KP.li@rad-ic.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "jeffrey.lin" <jeffrey.lin@gmail.com>

Hi Jeffrey,

On Wed, Nov 19, 2014 at 7:30 AM, jeffrey.lin <yajohn@gmail.com> wrote:
> From: "jeffrey.lin" <jeffrey.lin@gmail.com>
>
> this patch is porting Raydium I2C touch driver. Developer can enable
> raydium touch driver by modifying define "CONFIG_TOUCHSCREEN_RM_TS".
>
> BUG: None
> TEST: built and test with peppy
These two lines serve no purpose in the upstream kernel. Please remove them.

>
> Signed-off-by: jeffrey.lin@rad-ic.com
> Change-Id: I05d54e5ef29249d2a6eae97222c90bed11e839f9
The Change-Id: line is an artifact of the gerrit code review system.
Please remove it before sending patches upstream.




-- 
Benson Leung
Software Engineer, Chrom* OS
bleung@chromium.org
