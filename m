From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [RFC v2 2/8] HID: make a bus from hid code
Date: Tue, 06 May 2008 23:25:30 +0200
Message-ID: <4820CCCA.6040601@gmail.com>
References: <1209296946-18454-1-git-send-email-jirislaby@gmail.com> <1209296946-18454-2-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:8278 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933648AbYEFVZs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 May 2008 17:25:48 -0400
Received: by fg-out-1718.google.com with SMTP id 19so571201fgg.17
        for <linux-input@vger.kernel.org>; Tue, 06 May 2008 14:25:45 -0700 (PDT)
In-Reply-To: <1209296946-18454-2-git-send-email-jirislaby@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, marcel@holtmann.org, mit-devel@lists.printk.net, linux-kernel@vger.kernel.org, anssi.hannula@gmail.com

On 04/27/2008 01:49 PM, Jiri Slaby wrote:
> Make a bus from hid core. This is the first step for converting all the
> quirks and separate almost-drivers into real drivers attached to this bus.

If no objections I would like to merge it to hid#mm along with patch for 
module-init-tools. (I've changed apple driver little bit and need to rebase it 
to hid#mm branch.)
