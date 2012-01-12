From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH] HID: usbhid: fix dead lock between open and disconect
Date: Thu, 12 Jan 2012 18:33:15 +0800
Message-ID: <CACVXFVP5V88_cTcpDYnsTy-M9aCaZ5Yneo=yVfB4+2_YjjWFFQ@mail.gmail.com>
References: <1326361342-4141-1-git-send-email-tom.leiming@gmail.com>
	<201201121054.50083.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56713 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860Ab2ALKdQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Jan 2012 05:33:16 -0500
In-Reply-To: <201201121054.50083.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@suse.de>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

Hi,

On Thu, Jan 12, 2012 at 5:54 PM, Oliver Neukum <oneukum@suse.de> wrote:

> you should however hold the lock while you unset hiddev->exist

The patch doesn't change the rule.

> and you should unset hiddev->exist before you call usb_deregister_dev().

The lock is not hold before reading hiddev->exist and writing list->hiddev->open
in hiddev_open, so I choose to put usb_deregister_dev before unsetting
hiddev->exist in hiddev_disconnect to avoid possible race.


thanks,
-- 
Ming Lei
