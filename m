From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] HID: add new gamepad LED constants
Date: Tue, 16 Sep 2014 12:00:26 +0200
Message-ID: <CANq1E4R80GwEL43ngV5-8cWXTQAchfCOwpYSxUZfL7Hxy5yVSw@mail.gmail.com>
References: <1410750811-11156-1-git-send-email-michaelwr@google.com>
	<CANq1E4RY8cF1de4_rdS3Whjrf0bboYMtii4_nYNM2mEJuAKMfQ@mail.gmail.com>
	<CAON4U=OTzqOYDCeT-rFM8trvD80_kQxirZ+Yu5nOjc84v15XLA@mail.gmail.com>
	<20140915215728.GB13468@core.coreip.homeip.net>
	<CANq1E4TK1=mD0Xh5KuydoONqiex79HggvoM9XRhorogmxqBqhw@mail.gmail.com>
	<20140915225809.GA31798@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:38035 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753369AbaIPKA1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Sep 2014 06:00:27 -0400
Received: by mail-ig0-f169.google.com with SMTP id a13so3448846igq.4
        for <linux-input@vger.kernel.org>; Tue, 16 Sep 2014 03:00:26 -0700 (PDT)
In-Reply-To: <20140915225809.GA31798@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Wright <michaelwr@android.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Michael Wright <michaelwr@google.com>, Jiri Kosina <jkosina@suse.cz>

Hi

On Tue, Sep 16, 2014 at 12:58 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>> The LED subsystem lacks any unprivileged API to control LEDs.
>
> As far as I can see it is the same as for input devices. You just need
> to make sure the device owner can access needed attributes, such as
> brightness.
>
>> There's no cdev to control write-access to the LED API. /sys has never
>> been intended as unprivileged API
>
> chmod/chown works just fine on sysfs attributes.

Sure it is. You can even use ACLs. But that doesn't mean it provides a
proper API environment. Udev maintainers have always said "sysfs is
only writable by root". Reasons mostly being the following:

* sysfs exists only once. Unlike char-devs, you cannot create multiple
independent entry-points to the device node. Instead, there's only a
single entry point which has to be shared between all users (across
sessions, across containers, across user-namespaces, across
pid-namespaces).

* sysfs does not provide per-file contexts. Unlike char-devs, sysfs
never knows the context of the user that writes into an attribute. It
cannot associate private data to the open file and it cannot track the
time the user releases the device again. It cannot multiplex across
multiple simultaneous users.

* sysfs is not "lightweight". People always say they don't want full
blown char-devs because sysfs is much lighter. Don't know where that
came from.. but looking at the amount of inodes and files needed for
sysfs APIs, it's definitely not faster nor smaller than char-devs.

Just look at IIO to see what happens if you write evdev-like APIs
based on sysfs attributes "because it's lightweight". It's a mess.

Sure, one solution would be to provide char-devs for LEDs. But then
one char-dev per LED sounds like overkill, so my proposal is to
include it in the input API like we always did. You're free to
disagree on that. I'm just saying that sysfs APIs to access LEDs on
GamePads (which this patch is mostly targeted at, I guess) is making
user-space life miserable. It's the same discussion we had with
backlights for years and we're trying eagerly to merge them into the
DRM char-devs.

Thanks
David
