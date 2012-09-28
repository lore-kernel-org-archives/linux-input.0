From: simon@mungewell.org
Subject: Default Deadzones for Event based Joysticks
Date: Fri, 28 Sep 2012 13:00:58 -0400
Message-ID: <2c2974e3d19510f04faebc1693446a29.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:45778 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754952Ab2I1SIm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Sep 2012 14:08:42 -0400
Received: from localhost ([127.0.0.1] helo=mungewell.org)
	by host171.canaca.com with esmtpa (Exim 4.69)
	(envelope-from <simon@mungewell.org>)
	id 1THdvu-0000B8-EX
	for linux-input@vger.kernel.org; Fri, 28 Sep 2012 13:00:58 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi all,
I have a problem when using a gaming wheel with SDL1.3/2.0, which appears
to stem from the Linux event system. By default the deadzone is very large
(approximately 60' on a G27), which make 'driving' very difficult.

I found two solutions:

 1). use 'export SDL_JOYSTICK_DEVICE=/dev/input/js0', but then SDL doesn't
present a haptic interface for that joystick

2). G25Manage, which tells the event interface that there is no deadzone.
./G25manage --deadzone=0 --evdev=/dev/input/event3

https://github.com/VDrift/vdrift/tree/master/tools/G25manage



Is there a way to configure the default deadzone to '0' so I don't have to
do the above?

Thanks,
Simon.

