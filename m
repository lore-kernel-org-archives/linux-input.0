From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: USB hid blocks USB port in 2.6.28rc3
Date: Thu, 13 Nov 2008 13:30:55 +0100
Message-ID: <491C1DFF.6000509@gmail.com>
References: <20081111003117.GA10904@basil.nowhere.org> <alpine.LNX.1.10.0811121529240.32143@jikos.suse.cz> <20081113113223.GT3810@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:41992 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089AbYKMMbA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Nov 2008 07:31:00 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1323677ugf.37
        for <linux-input@vger.kernel.org>; Thu, 13 Nov 2008 04:30:57 -0800 (PST)
In-Reply-To: <20081113113223.GT3810@one.firstfloor.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>

Andi Kleen napsal(a):
> Which information do you need exactly out of /sys/bus/usb/devices? 

You misread the path, it's one file in /proc. (Make sure usbfs is mounted
there.)
