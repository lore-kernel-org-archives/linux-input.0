From: Anisha Kaul <born.rebel.83@gmail.com>
Subject: Re: fftest: Upload effects[0]: Function not implemented
Date: Wed, 18 Jan 2012 10:27:57 +0530
Message-ID: <CAM1yFZ-JBN+kWYdVG3BtuXnXck+oR9ftgm3u9EreOHy+CszMTQ@mail.gmail.com>
References: <CAM1yFZ8A8oHhZ9m7=69mekAPZQhpaSvKk8bVqZiDTtCeYLAhGw@mail.gmail.com>
	<c0a085d97e81f211fc647da982c450ca.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:57069 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757072Ab2ARE55 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Jan 2012 23:57:57 -0500
Received: by obcva7 with SMTP id va7so6711384obc.19
        for <linux-input@vger.kernel.org>; Tue, 17 Jan 2012 20:57:57 -0800 (PST)
In-Reply-To: <c0a085d97e81f211fc647da982c450ca.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: linux-input@vger.kernel.org

On 18 January 2012 03:58,  <simon@mungewell.org> wrote:
> Do you have the appropriate FF module built and loading in your kernel, it
> was recently moved to be enabled with 'LOGIWHEELS_FF'

Thanks very much Simon. That was very helpful. I replaced the
LOGITECH_FF with LOGIWHEELS_FF in the
/usr/src/linux-2.6.34-12/drivers/hid/Kconfig,
set 'default y' and then did modprobe hid and modprobe hid-logitech.
The fftest worked with constant force.

Thanks again.
-Anisha
