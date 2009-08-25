From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: what is the meaning of matrix_keypad_platform_data.active_low
Date: Tue, 25 Aug 2009 12:21:10 +0200
Message-ID: <200908251221.10797.marek.vasut@gmail.com>
References: <4A93903F.3080005@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:64514 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754272AbZHYKVc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Aug 2009 06:21:32 -0400
In-Reply-To: <4A93903F.3080005@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Xiangfu Liu <xiangfu.z@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Dne =DAt 25. srpna 2009 09:18:23 Xiangfu Liu napsal(a):
> Hi
> ./include/linux/input/matrix_keypad.h
> there no help in matrix_keypad.h about active_low.
>
> I guess. when set active_low to 1.means:
>
> 0: key press
> 1: key not press
>
> right?

Hi, yeah, it means the GPIO pins have inverted voltage levels.
>
> thanks for help.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
