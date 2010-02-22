From: Abraham Arce <abraham.arce.moreno@gmail.com>
Subject: Event number sequence
Date: Mon, 22 Feb 2010 10:46:28 -0600
Message-ID: <cb8016981002220846i19399989r946d33cc26d81fe2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:57348 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538Ab0BVQqf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Feb 2010 11:46:35 -0500
Received: by pwj8 with SMTP id 8so2865710pwj.19
        for <linux-input@vger.kernel.org>; Mon, 22 Feb 2010 08:46:34 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

I have tested the insertion/removel of 2 different drivers (keyboard
and touchscreen), what I have seen is that the sequence in the number
of the event is always different aty the time of registering them, I'd
expect that if I remove a module, the event number is freed, making it
available for the next time but this is not the case

My output looks like

#insmod myinputdriver.ko
/class/input/input0
#rmmod myinputdriver.ko
#insmod myinputdriver.ko
/class/input/input1
#rmmod myinputdriver.ko

Is there any specific function from the input subsystem to free it? Do
we have a limitation on the input subsystem?

Best Regards
Abraham
