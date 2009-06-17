From: Mohamed Ikbel Boulabiar <medikbel@lii-enac.fr>
Subject: Re: [PATCH] Restoring usages used by the pen.
Date: Wed, 17 Jun 2009 14:01:09 +0200
Message-ID: <45cc95260906170501u6bf26a57i9cb7b4cfc6ef49d2@mail.gmail.com>
References: <4A385751.8000904@seas.upenn.edu> <93BE517D-F863-4F80-8060-CC36562E02CC@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:44894 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754302AbZFQMJe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Jun 2009 08:09:34 -0400
Received: by bwz9 with SMTP id 9so260558bwz.37
        for <linux-input@vger.kernel.org>; Wed, 17 Jun 2009 05:09:36 -0700 (PDT)
In-Reply-To: <93BE517D-F863-4F80-8060-CC36562E02CC@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: Rafi Rubin <rafi@seas.upenn.edu>, linux-input@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>, brysgo@gmail.com, Sebastien Hamdani <sebastien.hamdani@gmail.com>, Henrik Rydberg <rydberg@euromail.se>

> Leaving aside the pain of having incompatible versions of the firmware
> around, it looks this type of dual device (stylus + finger) challenges the
> way linux-hid, linux-input and Xorg regard touch devices: yes, something
> that looks like a touchscreen can be a digitizer too... Maybe we should
> create two Linux devices, one for the stylus and one for fingers?


This is another example raising questions about the input system, from
the kernel to Xorg to finally reach applications.

I will write another mail about this later (maybe RFC), but it seems
that some code should be modified in the kernel and input devices
should have an input daemon outside the kernel and not in X, to easily
deal with new devices and new constraints without modifying many
layers of the whole system.

(in this case, we maybe need 2 devices because the constructor
included this as a feature, but if simple users want to add some)
