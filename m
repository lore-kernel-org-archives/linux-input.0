From: Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH 16/18] Input: elan_i2c - simplify function return logic
Date: Fri, 2 Oct 2015 09:46:19 -0700
Message-ID: <CANLzEkuNn5Psw8qSw_FyD3uaA8rXA-KvzPFivC5L1_XeH1WxOw@mail.gmail.com>
References: <1443793229-22363-1-git-send-email-javier@osg.samsung.com>
	<1443793229-22363-17-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:34494 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbbJBQqU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Oct 2015 12:46:20 -0400
Received: by iow1 with SMTP id 1so89131441iow.1
        for <linux-input@vger.kernel.org>; Fri, 02 Oct 2015 09:46:20 -0700 (PDT)
In-Reply-To: <1443793229-22363-17-git-send-email-javier@osg.samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Duson Lin <dusonlin@emc.com.tw>

On Fri, Oct 2, 2015 at 6:40 AM, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
> The invoked function already returns zero on success or a negative
> errno code so there is no need to open code the logic in the caller.
>
> This also fixes the following make coccicheck warning:
>
> drivers/input/mouse/elan_i2c_smbus.c:402:1-6: WARNING: end returns can be simplified
>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Reviewed-by: Benson Leung <bleung@chromium.org>


-- 
Benson Leung
Software Engineer, Chrom* OS
bleung@chromium.org
