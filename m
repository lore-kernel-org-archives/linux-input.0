From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] hid: Add mapping for special keys on compaq ku 0133
 keyboard
Date: Tue, 12 Aug 2014 16:35:30 -0700
Message-ID: <20140812233530.GA9498@core.coreip.homeip.net>
References: <1407885290-3067-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:54166 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbaHLXfd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Aug 2014 19:35:33 -0400
Received: by mail-pa0-f41.google.com with SMTP id rd3so13931624pab.0
        for <linux-input@vger.kernel.org>; Tue, 12 Aug 2014 16:35:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1407885290-3067-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-input@vger.kernel.org

On Wed, Aug 13, 2014 at 01:14:50AM +0200, Hans de Goede wrote:
> The compaq ku 0133 keyboard has 8 special keys at the top:
> http://lackof.org/taggart/hacking/keyboard/cpqwireless.jpg
> 
> 3 of these use standard HID usage codes from the consumer page, the 5
> others use part of the reserved 0x07 - 0x1f range.
> 
> This commit adds mapping for this keyboard for these reserved codes, making
> the other 5 keys work.

Can't we just load the proper keymap through udev without writing yet another
kernel driver?

Thanks.

-- 
Dmitry
