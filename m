From: "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>
Subject: Re: Issue caused by your commit to the linux kernel
Date: Thu, 21 Jan 2016 17:47:25 +0100
Message-ID: <20160121164725.GC20099@mail.corp.redhat.com>
References: <15227381b21.be24b19a14291.7794248722302336410@vlrz.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47538 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752192AbcAUQra (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jan 2016 11:47:30 -0500
Content-Disposition: inline
In-Reply-To: <15227381b21.be24b19a14291.7794248722302336410@vlrz.es>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manuel Valls <manolo@vlrz.es>
Cc: "Eric.Brunet@lps.ens.fr" <Eric.Brunet@lps.ens.fr>, "jkosina@suse.cz" <jkosina@suse.cz>, linux-input@vger.kernel.org

Hi Manuel,

On Jan 09 2016 or thereabouts, Manuel Valls wrote:
> 
> 
> Commit 79346d620e9de87912de73337f6df8b7f9a46888 caused DragonRise Inc. PC TWIN SHOCK Gamepad's right stick to be wrongly detected as a Z axis, making it unusable. I'm writing to you as the authors of said commit requesting a fix. Looking forward to an answer.
> 

It looks like I finally understood why this commit broke some gamepads.
Basically, nothing prevents a HID device to use an axis more than once.
This is noticeably used by multitouch devices.

So some gamepads manufacturers, are using for both joysticks (under the
2 thumbs) X and Y. Before 79346d620, this used to be working in Linux
because we were looking for the next available axis.
So when the second joystick gets parsed, X and Y are already in used,
and so they gets assigned Z and RX. Luckily, the gamepad does not uses
those particular axis (plus the fact that we actually do not care which
axis is which, this gets sorted out later on by userspace).

To be able to fix this, I will need you to provide the report
descriptors of your gamepad. Can you run hid-recorder[1] on the gamepad?

Once I have those, I should be able to either remove the gamepads from
the list of "hey, if you declare X, you should map it to X", or I might
just force the pen usages to be on this list only.

Cheers,
Benjamin

[1] https://bentiss.github.io/hid-replay-docs/
