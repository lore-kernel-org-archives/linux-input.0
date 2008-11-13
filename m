From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH] HID: don't grab devices with no input
Date: Thu, 13 Nov 2008 23:14:05 +0100
Message-ID: <491CA6AD.5050706@gmail.com>
References: <Pine.LNX.4.44L0.0811131632150.3036-100000@iolanthe.rowland.org> <491CA495.7010007@gmail.com> <20081113222200.GD3810@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:9838 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756389AbYKMWOL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Nov 2008 17:14:11 -0500
Received: by ey-out-2122.google.com with SMTP id 6so475971eyi.37
        for <linux-input@vger.kernel.org>; Thu, 13 Nov 2008 14:14:09 -0800 (PST)
In-Reply-To: <20081113222200.GD3810@one.firstfloor.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/13/2008 11:22 PM, Andi Kleen wrote:
> On Thu, Nov 13, 2008 at 11:05:09PM +0100, Jiri Slaby wrote:
>> On 11/13/2008 10:37 PM, Alan Stern wrote:
>>> Do you want to use usb_endpoint_is_int_in() instead?  It matches the 
>>> error message more closely.
>> Yes, good catch, thanks.
> Should I test it with that change or the original version?

The updated one, please.
