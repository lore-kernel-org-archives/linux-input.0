From: Chris Healy <cphealy@gmail.com>
Subject: Re: [PATCH 3/3] Input: synaptics-rmi4 - enable IRQ operation in F34 V7
Date: Mon, 27 Mar 2017 19:19:21 -0700
Message-ID: <CAFXsbZr_2Ub_5KidTea6amN7jKp9=wZh42CftvtjDOKNOUH=-A@mail.gmail.com>
References: <1490403540-31425-1-git-send-email-nick@shmanahar.org> <1490403540-31425-4-git-send-email-nick@shmanahar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:36514 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752853AbdC1CTX (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 27 Mar 2017 22:19:23 -0400
Received: by mail-it0-f66.google.com with SMTP id 190so804634itm.3
        for <linux-input@vger.kernel.org>; Mon, 27 Mar 2017 19:19:22 -0700 (PDT)
In-Reply-To: <1490403540-31425-4-git-send-email-nick@shmanahar.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-input@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>

On Fri, Mar 24, 2017 at 5:59 PM, Nick Dyer <nick@shmanahar.org> wrote:
> The polled firmware update proved unreliable when testing on S7817. Use
> attention to signal commands are complete.
>
> Signed-off-by: Nick Dyer <nick@shmanahar.org>
> ---
>  drivers/input/rmi4/rmi_f34.c   |  27 +++++++---
>  drivers/input/rmi4/rmi_f34.h   |   7 +--
>  drivers/input/rmi4/rmi_f34v7.c | 114 ++++++++++++++++++++++-------------------
>  3 files changed, 81 insertions(+), 67 deletions(-)
>
> diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
> index 425fe14..a37efca 100644
> --- a/drivers/input/rmi4/rmi_f34.c
> +++ b/drivers/input/rmi4/rmi_f34.c

Tested FW update on S7317 HW with no reliability issues.

Tested-by: Chris Healy <cphealy@gmail.com>
