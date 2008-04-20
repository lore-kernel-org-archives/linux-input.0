From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: HID bus
Date: Sun, 20 Apr 2008 20:07:22 +0200
Message-ID: <480B865A.7040907@gmail.com>
References: <Pine.LNX.4.64.0804181333180.12972@jikos.suse.cz> <1208644696-29129-1-git-send-email-jirislaby@gmail.com> <480B6C16.40806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:2630 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225AbYDTSHf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Apr 2008 14:07:35 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1460885fgb.17
        for <linux-input@vger.kernel.org>; Sun, 20 Apr 2008 11:07:32 -0700 (PDT)
In-Reply-To: <480B6C16.40806@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, marcel@holtmann.org, linux-kernel@vger.kernel.org

On 04/20/2008 06:15 PM, Anssi Hannula wrote:
> Oh, so we create a normal usb modalias entry anyway, not a custom
> 'usbhid:' one.

Arrr, thank you, this provoked me an idea. I'll repost the patch tomorrow or so.
