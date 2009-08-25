From: Xiangfu Liu <xiangfu.z@gmail.com>
Subject: what is the meaning of matrix_keypad_platform_data.active_low
Date: Tue, 25 Aug 2009 15:18:23 +0800
Message-ID: <4A93903F.3080005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f182.google.com ([209.85.216.182]:59089 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753176AbZHYHTI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Aug 2009 03:19:08 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org

Hi
./include/linux/input/matrix_keypad.h 
there no help in matrix_keypad.h about active_low.

I guess. when set active_low to 1.means:

0: key press
1: key not press

right?

thanks for help.

-- 
Xiangfu Liu
Email: xiangfu at qi-hardware dot com
Web: http://www.qi-hardware.com
