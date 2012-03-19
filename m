From: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>
Subject: Re: [PATCH] HID: multitouch: add PID for Fructel product
Date: Mon, 19 Mar 2012 18:30:37 +0100
Message-ID: <CAPHpN5OT9NbD_N__Y63Row3rgiV=ym8YcZP-NkM5-eS1F1EE4Q@mail.gmail.com>
References: <1332168063-24812-1-git-send-email-eas@svep.se>
 <CAPHpN5Nn1JQtOQML8Y=2iL8Qy5SFjxMbf1uggNDVqoeeeegWCg@mail.gmail.com> <884EB0E38721BD4797EDF5AE1D66333C03F4953A9533@Exchange-1.svep.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:58960 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030894Ab2CSRa6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Mar 2012 13:30:58 -0400
Received: by vcqp1 with SMTP id p1so6488224vcq.19
        for <linux-input@vger.kernel.org>; Mon, 19 Mar 2012 10:30:57 -0700 (PDT)
In-Reply-To: <884EB0E38721BD4797EDF5AE1D66333C03F4953A9533@Exchange-1.svep.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andreas Nielsen <eas@svep.se>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "benjamin.tissoires@enac.fr" <benjamin.tissoires@enac.fr>, "chatty@enac.fr" <chatty@enac.fr>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "jkosina@suse.cz" <jkosina@suse.cz>

On Mon, Mar 19, 2012 at 5:03 PM, Andreas Nielsen <eas@svep.se> wrote:
> The multitouch events are emulated by the Gametel device. Each physical button is configured to generate a MT event on a specific coordinate. This seems to be the only way for us to support Android games that doesn't support HID gamepads. It is possible to inject MT events at Android level, but this requires the user to root their phone which isn't realistic for our users.

Cool, the explanation that I need !
Thanks.
