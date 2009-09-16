From: Xiangfu Liu <xiangfu.z@gmail.com>
Subject: Fn + [KEYS] question
Date: Wed, 16 Sep 2009 15:24:13 +0800
Message-ID: <4AB0929D.4030007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f171.google.com ([209.85.210.171]:34880 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754126AbZIPHYS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Sep 2009 03:24:18 -0400
Received: by yxe1 with SMTP id 1so6324192yxe.21
        for <linux-input@vger.kernel.org>; Wed, 16 Sep 2009 00:24:21 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi

I know in the IBM laptop, you use Fn + F1 to do something.
I want [Fn + U = 7] in my device. 
when you press Fn + U in the terminal it will display '7'.


I look into the keyboard.c file.
but don't know which function is handle the Fn key?

there is [1] in the keyboard.h file. I don't know 
which Fn key belong. is it KT_SHIFT???

thanks for any advice. 


[1] -------------
#define KT_LATIN	0	/* we depend on this being zero */
#define KT_LETTER	11	/* symbol that can be acted upon by CapsLock */
#define KT_FN		1
#define KT_SPEC		2
#define KT_PAD		3
#define KT_DEAD		4
#define KT_CONS		5
#define KT_CUR		6
#define KT_SHIFT	7
#define KT_META		8
#define KT_ASCII	9
#define KT_LOCK		10
#define KT_SLOCK	12
#define KT_DEAD2	13
#define KT_BRL		14

-- 
Xiangfu Liu
Email: xiangfu at qi-hardware dot com
Web: http://www.qi-hardware.com
