From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 7/8] greybus: hid: remove custom locking from
 gb_hid_open/close
Date: Wed, 7 Jun 2017 09:56:28 +0200
Message-ID: <20170607075628.GA10779@kroah.com>
References: <20170607065938.33332-1-dmitry.torokhov@gmail.com>
 <20170607065938.33332-8-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:46318 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751008AbdFGH4e (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Jun 2017 03:56:34 -0400
Content-Disposition: inline
In-Reply-To: <20170607065938.33332-8-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jun 06, 2017 at 11:59:37PM -0700, Dmitry Torokhov wrote:
> Now that HID core enforces serialization of transport driver open/close
> calls we can remove custom locking from greybus hid driver.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/staging/greybus/hid.c | 43 ++++++++++++++-----------------------------
>  1 file changed, 14 insertions(+), 29 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
