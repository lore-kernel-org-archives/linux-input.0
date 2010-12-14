From: Sundar R IYER <sundar.iyer@stericsson.com>
Subject: Re:[v1] input/tc3589x: add tc3589x keypad support
Date: Tue, 14 Dec 2010 06:31:20 +0100
Message-ID: <33A307AF30D7BF4F811B1568FE7A9B18047C8B2DFA@EXDCVYMBSTM006.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:53858 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751612Ab0LNFbi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Dec 2010 00:31:38 -0500
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Dmitry,

>I do not see where you'd enable the keypad. What will happen if you
>unbind/unload the driver (which will cause explicit call to disable) and
>then try loading the module again?

A minor doubt: I enable the keypad in the open call; leaving it to the user
space to control the input device. If I understand your question, then I
should not be disabling the keypad in the tc3589x_keypad_remove, which
might cause conflicts. Is my understanding correct?

Cheers!
