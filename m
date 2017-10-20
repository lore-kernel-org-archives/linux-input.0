From: David Strobach <lalochcz@gmail.com>
Subject: Re: [PATCH] HID: hid-kensington: add alternative button mapping
Date: Fri, 20 Oct 2017 15:15:05 +0200
Message-ID: <7902363.ov3IumQSfm@str>
References: <2082258.qPnAmo2zZ4@str>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:43221 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751018AbdJTNPJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 20 Oct 2017 09:15:09 -0400
Received: by mail-wm0-f54.google.com with SMTP id m72so592474wmc.0
        for <linux-input@vger.kernel.org>; Fri, 20 Oct 2017 06:15:09 -0700 (PDT)
Received: from str.localnet (a155.dkm.cz. [62.24.65.155])
        by smtp.gmail.com with ESMTPSA id h21sm2033620wrf.47.2017.10.20.06.15.06
        for <linux-input@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Oct 2017 06:15:07 -0700 (PDT)
In-Reply-To: <2082258.qPnAmo2zZ4@str>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

On 20/10/2017 14:41:33 CEST David Strobach wrote:
> The current mapping of the proprietary Kensington Slimblade buttons
> is as follows:
>  +---+---+
> 
>  | 2 | 8 |
> 
>  +---X---+
> 
>  | 1 | 3 |
> 
>  +---+---+
> 
> This modification adds an alternative button mapping for users,
> who prefer to use middle mouse button emulation (buttons 1+3) in
> order to get one extra button at the top right. The alternative
> button mapping is:
>  +---+---+
> 
>  | 9 | 8 |
> 
>  +---X---+
> 
>  | 1 | 3 |
> 
>  +---+---+

Ouch, it's actually
  +---+---+
  | 8 | 9 |
  +---X---+
  | 1 | 3 |
  +---+---+

Cheers
David

