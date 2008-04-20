From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: HID bus
Date: Sun, 20 Apr 2008 13:57:14 +0200
Message-ID: <480B2F9A.3020104@gmail.com>
References: <Pine.LNX.4.64.0804181333180.12972@jikos.suse.cz> <1208644696-29129-1-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:30061 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480AbYDTL5Z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Apr 2008 07:57:25 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1365804fgb.17
        for <linux-input@vger.kernel.org>; Sun, 20 Apr 2008 04:57:24 -0700 (PDT)
In-Reply-To: <1208644696-29129-1-git-send-email-jirislaby@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, marcel@holtmann.org, mit-devel@lists.printk.net, linux-kernel@vger.kernel.org

On 04/20/2008 12:38 AM, Jiri Slaby wrote:
> Now, I wonder for exactly what purpose are module.*map files in
> /lib/modules/`uname -r`/ dir, i.e. what would break, if the devices won't
> be listed there on systems with unpatched module-init-tools.

Well, used by /sbin/hotplug. I.e. on systems which uses that hotplugging system 
and not new enough udev. It means older RHEL, SLE* et al., and older 
distributions too...

So I suppose we still need the option to let users compile all the chosen 
drivers into hid.
