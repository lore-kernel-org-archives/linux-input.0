From: =?UTF-8?Q?Cl=c3=a9ment_Vuchener?= <clement.vuchener@gmail.com>
Subject: Keycodes for programmable keys/buttons
Date: Sat, 22 Aug 2015 18:38:38 +0200
Message-ID: <55D8A58E.50002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:32945 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795AbbHVQil (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 22 Aug 2015 12:38:41 -0400
Received: by wijp15 with SMTP id p15so42417832wij.0
        for <linux-input@vger.kernel.org>; Sat, 22 Aug 2015 09:38:40 -0700 (PDT)
Received: from [192.168.1.13] (ARennes-658-1-17-254.w83-199.abo.wanadoo.fr. [83.199.32.254])
        by smtp.googlemail.com with ESMTPSA id r8sm4120543wik.16.2015.08.22.09.38.39
        for <linux-input@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 22 Aug 2015 09:38:40 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

I am writing a driver for keyboard with eighteen programmable keys. When 
they are not bound to anything on the hardware, I would like them to 
send keycodes so an userspace program can execute macros or commands 
when they are pressed. But I could not find anything suitable in 
input.h. Did I miss something? How should I handle those keys?
