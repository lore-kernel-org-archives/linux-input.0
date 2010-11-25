From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [RFC] Adding BTN_TOOL_TOUCH to input.h
Date: Thu, 25 Nov 2010 17:12:56 +0300
Message-ID: <4CEE6EE8.4060805@gmail.com>
References: <4CEE6D2A.9040408@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:35812 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752979Ab0KYONU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Nov 2010 09:13:20 -0500
Received: by eye27 with SMTP id 27so469495eye.19
        for <linux-input@vger.kernel.org>; Thu, 25 Nov 2010 06:13:19 -0800 (PST)
In-Reply-To: <4CEE6D2A.9040408@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Chris Bagwell <chris@cnpbagwell.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ping Cheng <pinglinux@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suze.cz>

On 11/25/2010 05:05 PM, Henrik Rydberg wrote:
> 	__u32	phys_abs_width;		/* physical width of surface (mm) */
> 	__u32	phys_abs_height;	/* physical height of surface (mm) */
This is better and is already covered by input_absinfo.
You could calculate it with (maximum - minimum) / resolution.

Sincerely,
Nick
