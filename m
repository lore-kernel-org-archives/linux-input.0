From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 0/2] HID: cp2112: fix sleep-while-atomic regression
Date: Mon, 30 Jan 2017 13:45:32 +0100
Message-ID: <20170130124532.GA27061@mail.corp.redhat.com>
References: <20170130102235.3691-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50586 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752771AbdA3MqR (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 30 Jan 2017 07:46:17 -0500
Content-Disposition: inline
In-Reply-To: <20170130102235.3691-1-johan@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Jan 30 2017 or thereabouts, Johan Hovold wrote:
> These patches fix a sleep-while-atomic and an error-handling issue
> introduced by a patch that went into 4.9.
> 
> Note that this series has only been compile tested.

Tested the series, and:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thanks for spotting that!

Cheers,
Benjamin

> 
> Johan
> 
> 
> Johan Hovold (2):
>   HID: cp2112: fix sleep-while-atomic
>   HID: cp2112: fix gpio-callback error handling
> 
>  drivers/hid/hid-cp2112.c | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
> 
> -- 
> 2.10.2
> 
