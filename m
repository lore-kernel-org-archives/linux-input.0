From: Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH v2] Input: add i2c/smbus driver for elan touchpad
Date: Fri, 3 Oct 2014 14:30:16 -0700
Message-ID: <CANLzEkutVdtF8cWmXMF9STyD6x9JUZJ9xH0R8VneG5h8vTy32Q@mail.gmail.com>
References: <1389064083-11018-1-git-send-email-dusonlin@emc.com.tw>
	<20141003210357.GB4987@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:54771 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbaJCVaR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Oct 2014 17:30:17 -0400
Received: by mail-vc0-f169.google.com with SMTP id hy4so1271349vcb.0
        for <linux-input@vger.kernel.org>; Fri, 03 Oct 2014 14:30:16 -0700 (PDT)
In-Reply-To: <20141003210357.GB4987@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Duson Lin <dusonlin@emc.com.tw>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, agnescheng@chromium.org, phoenix@emc.com.tw, "Jeff.Chuang" <jeff.chuang@emc.com.tw>, devicetree@vger.kernel.org

On Fri, Oct 3, 2014 at 2:03 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Input: driver for Elan I2C/SMbus touchpad
>
> From: Duson Lin <dusonlin@emc.com.tw>
>
> This driver supports Elan I2C/SMbous touchpads found in some laptops and

s/SMbous/SMBus

> also in many Chromebooks.
>
> Signed-off-by: Duson Lin <dusonlin@emc.com.tw>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Benson Leung <bleung@chromium.org>


-- 
Benson Leung
Software Engineer, Chrom* OS
bleung@chromium.org
