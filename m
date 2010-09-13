From: Sundar R IYER <sundar.iyer@stericsson.com>
Subject: RE: [PATCH v3 1/1] input: add support for Nomadik SKE keypad
 controller
Date: Mon, 13 Sep 2010 09:31:16 +0200
Message-ID: <33A307AF30D7BF4F811B1568FE7A9B180437521C44@EXDCVYMBSTM006.EQ1STM.local>
References: <1283777284-24811-1-git-send-email-sundar.iyer@stericsson.com>
 <4C8645CB.9070206@codeaurora.org>
 <33A307AF30D7BF4F811B1568FE7A9B181C8565B5@EXDCVYMBSTM006.EQ1STM.local>
 <4C87885C.70704@codeaurora.org>
 <AANLkTinYfUVGignRSA+GPWz4yHothgm6TTyt7ruMvmS9@mail.gmail.com>
 <20100908154601.GF4190@core.coreip.homeip.net>
 <33A307AF30D7BF4F811B1568FE7A9B181C856805@EXDCVYMBSTM006.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:58415 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752267Ab0IMHc4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Sep 2010 03:32:56 -0400
In-Reply-To: <33A307AF30D7BF4F811B1568FE7A9B181C856805@EXDCVYMBSTM006.EQ1STM.local>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Trilok Soni <tsoni@codeaurora.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>

Hello Dmitry,

Could you suggest some ideas to move ahead on this? I see myself
getting stucked :(

Regards,
Sundar

>-----Original Message-----
>From: Sundar R IYER
>
>Hmm. Could you please help me out on how I can proceed with the
>following two HW constraints:
>
>1. KPASON polling needs to be waited in case of a multi key press so that
>the keypad registers can stabilize. This is what the TRM states.
>
>2. If I move enabling the interrupts to the timer snippet, I end up breaking multi-key
>detection.
>
>Regards,
>Sundar
