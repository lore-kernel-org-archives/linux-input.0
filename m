From: Cameron Gutman <aicommander@gmail.com>
Subject: Re: X-Box One Controler (Covert Forces) no Input/Static Input
Date: Sat, 5 Dec 2015 23:56:42 -0800
Message-ID: <5663EA3A.4050107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35392 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700AbbLFICS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 6 Dec 2015 03:02:18 -0500
Received: by pfu207 with SMTP id 207so48289936pfu.2
        for <linux-input@vger.kernel.org>; Sun, 06 Dec 2015 00:02:17 -0800 (PST)
In-Reply-To: 5662F0E0.7020806@gmail.com
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: greenbigfrog@gmail.com, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com

I also have a Covert Forces Xbox One controller and can confirm this 
issue. It looks like the 5 byte initialization packet used for rumble 
support in various other Xbox One drivers (xboxdrv, forks of xpad) is 
actually required for proper initialization of these new controllers.
Without it, we won't receive input data (as if initialization never 
occurred at all).

Luckily, there's a trivial fix for this. We'll just send the larger 
initialization packet, even without sending a sequence number in the 
rumble packets yet. I've confirmed that this fixes the issue for me. 
I'll send a patch shortly.


Cameron
