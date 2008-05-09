From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: HID bus
Date: Fri, 09 May 2008 23:24:43 +0200
Message-ID: <4824C11B.4090305@gmail.com>
References: <Pine.LNX.4.64.0804181333180.12972@jikos.suse.cz> <1208644696-29129-1-git-send-email-jirislaby@gmail.com> <480B2F9A.3020104@gmail.com> <Pine.LNX.4.64.0804220158560.12972@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:20301 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754978AbYEIVZE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 May 2008 17:25:04 -0400
Received: by fg-out-1718.google.com with SMTP id 19so955981fgg.17
        for <linux-input@vger.kernel.org>; Fri, 09 May 2008 14:25:01 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0804220158560.12972@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, marcel@holtmann.org, mit-devel@lists.printk.net, linux-kernel@vger.kernel.org

On 04/22/2008 02:00 AM, Jiri Kosina wrote:
> On Sun, 20 Apr 2008, Jiri Slaby wrote:
> 
>> So I suppose we still need the option to let users compile all the 
>> chosen drivers into hid.

This won't work either. It wouldn't link due to multiple definitions of 
module_init, module_exit and some module tables.

> Another possible workaround is to introduce dummy "hid" module, that will 
> just depend on all other drivers with a reference to certail symbol (and 
> this could of course be optional as CONFIG_HID_COMPAT, or whatever).

Actually this may work if we load hid_dummy by request_module from hid. I have 
no other better idea.
