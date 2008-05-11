From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 9/9] HID: add compat support
Date: Mon, 12 May 2008 01:18:58 +0200
Message-ID: <1210547938.16390.37.camel@violet.holtmann.net>
References: <1210536043-19812-1-git-send-email-jirislaby@gmail.com>
	 <1210536043-19812-2-git-send-email-jirislaby@gmail.com>
	 <1210536043-19812-3-git-send-email-jirislaby@gmail.com>
	 <1210536043-19812-4-git-send-email-jirislaby@gmail.com>
	 <1210536043-19812-5-git-send-email-jirislaby@gmail.com>
	 <1210536043-19812-6-git-send-email-jirislaby@gmail.com>
	 <1210536043-19812-7-git-send-email-jirislaby@gmail.com>
	 <1210536043-19812-8-git-send-email-jirislaby@gmail.com>
	 <1210536043-19812-9-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:59475 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755861AbYEKXSv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 11 May 2008 19:18:51 -0400
In-Reply-To: <1210536043-19812-9-git-send-email-jirislaby@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, anssi.hannula@gmail.com, akpm@linux-foundation.org, Sam Ravnborg <sam@ravnborg.org>

Hi Jiri,

> Add compat option to hid code to allow loading of all modules on
> systems which don't allow autoloading because of old userspace.

this is pretty ugly. Please add a line to feature-removal-schedule.txt
to mark that this will be removed within the next 6 month. At that point
every distribution should have updated udev and module-init-tools.

Regards

Marcel


