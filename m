From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] input: touchscreen: add driver for Zeitec ZET6223
Date: Fri, 9 Sep 2016 14:06:54 -0500
Message-ID: <CAL_JsqJH2U3neOxeuDg=5gEXpzC5PvfEUnpykvFN_8Sd5NgXpQ@mail.gmail.com>
References: <20160909185836.2708-1-jelle@vdwaa.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754231AbcIITHR (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 9 Sep 2016 15:07:17 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 506B0203B7
        for <linux-input@vger.kernel.org>; Fri,  9 Sep 2016 19:07:16 +0000 (UTC)
Received: from mail-yw0-f169.google.com (mail-yw0-f169.google.com [209.85.161.169])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45F9E203B1
        for <linux-input@vger.kernel.org>; Fri,  9 Sep 2016 19:07:15 +0000 (UTC)
Received: by mail-yw0-f169.google.com with SMTP id l8so52806837ywb.0
        for <linux-input@vger.kernel.org>; Fri, 09 Sep 2016 12:07:15 -0700 (PDT)
In-Reply-To: <20160909185836.2708-1-jelle@vdwaa.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jelle van der Waa <jelle@vdwaa.nl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Fri, Sep 9, 2016 at 1:58 PM, Jelle van der Waa <jelle@vdwaa.nl> wrote:
> This is a basic driver for the Zeitec ZET6223 I2C touchscreen controllers.
> The driver does not support firmware loading, which is not required for
> all tablets which contain this chip.
>
> Signed-off-by: Jelle van der Waa <jelle@vdwaa.nl>
> ---
>  .../bindings/input/touchscreen/zet6223.txt         |  33 ++++
>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +

Please send bindings to the DT list.

>  drivers/input/touchscreen/Kconfig                  |  11 ++
>  drivers/input/touchscreen/Makefile                 |   1 +
>  drivers/input/touchscreen/zet6223.c                | 190 +++++++++++++++++++++
>  5 files changed, 236 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/zet6223.txt
>  create mode 100644 drivers/input/touchscreen/zet6223.c
