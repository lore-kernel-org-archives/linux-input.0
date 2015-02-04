From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH] Input: evdev - add EVIOCREVOKE ioctl
Date: Wed, 4 Feb 2015 14:12:06 +0100
Message-ID: <20150204141206.59b73fce@neptune.home>
References: <1377602704-23301-1-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hygieia.santi-shop.eu ([78.46.175.2]:33701 "EHLO
	hygieia.santi-shop.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754208AbbBDNMS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Feb 2015 08:12:18 -0500
In-Reply-To: <1377602704-23301-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kristian =?UTF-8?B?SMO4Z3NiZXJn?= <hoegsberg@gmail.com>, Hans de Goede <hdegoede@redhat.com>

Hi David,

Sorry for reviving this old thread (I didn't find more recent patch series
at first glance or have not been using the proper keyword while searching).

At FOSDEM 2015 last Sunday Hans presented libinput X input driver and mentioned
evdev FD revoking.

A question I raise was how are input devices to be put in a reasonable
state on FD revoking?
The specific case of force-feedback game-pads/wheels and the like that libinput
is expected to pass through to games was the main trigger.

Assume:
- Game triggers some force-feedback event like vibrating device
- Game looses focus and gets its evdev FD revoked
- Newly focused application does not care about the game-pad/wheel

How should the force-feedback activity get stopped on that focus change
and thus FD revoking?
Is the game expected to react before the FD being revoked (how long to
wait?) or should the kernel somehow reset the device to a sane state on
revoke (and if so, under which conditions?).

Should some other evdev devices also receive a special treatment to reset
them into a known/idle state (eventually LEDs on keyboards, beep, ...)?

Bruno

On Tue, 27 August 2013 David Herrmann <dh.herrmann@gmail.com> wrote:
> If we have multiple sessions on a system, we normally don't want
> background sessions to read input events. Otherwise, it could capture
> passwords and more entered by the user on the foreground session. This is
> a real world problem as the recent XMir development showed:
>   http://mjg59.dreamwidth.org/27327.html
> 
> We currently rely on sessions to release input devices when being
> deactivated. This relies on trust across sessions. But that's not given on
> usual systems. We therefore need a way to control which processes have
> access to input devices.
> 
> With VTs the kernel simply routed them through the active /dev/ttyX. This
> is not possible with evdev devices, though. Moreover, we want to avoid
> routing input-devices through some dispatcher-daemon in userspace (which
> would add some latency).
> 
> This patch introduces EVIOCREVOKE. If called on an evdev fd, this revokes
> device-access irrecoverably for that *single* open-file. Hence, once you
> call EVIOCREVOKE on any dup()ed fd, all fds for that open-file will be
> rather useless now (but still valid compared to close()!). This allows us
> to pass fds directly to session-processes from a trusted source. The
> source keeps a dup()ed fd and revokes access once the session-process is
> no longer active.
> Compared to the EVIOCMUTE proposal, we can avoid the CAP_SYS_ADMIN
> restriction now as there is no way to revive the fd again. Hence, a user
> is free to call EVIOCREVOKE themself to kill the fd.
> 
> Additionally, this ioctl allows multi-layer access-control (again compared
> to EVIOCMUTE which was limited to one layer via CAP_SYS_ADMIN). A middle
> layer can simply request a new open-file from the layer above and pass it
> to the layer below. Now each layer can call EVIOCREVOKE on the fds to
> revoke access for all layers below, at the expense of one fd per layer.
> 
> There's already ongoing experimental user-space work which demonstrates
> how it can be used:
>   http://lists.freedesktop.org/archives/systemd-devel/2013-August/012897.html
