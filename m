From: Lukasz Pawelczyk <havner@gmail.com>
Subject: Re: [systemd-devel] Suspending access to opened/active /dev/nodes during application runtime
Date: Fri, 7 Mar 2014 21:51:04 +0100
Message-ID: <9E972401-6FA3-439B-9531-49D1FCC8D61D@gmail.com>
References: <9D7BA6C9-9F1F-4D09-8F4F-E7DA4720FF97@gmail.com> <20140307192410.GA24453@tango.0pointer.de>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:49560 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbaCGUvN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Mar 2014 15:51:13 -0500
In-Reply-To: <20140307192410.GA24453@tango.0pointer.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lennart Poettering <mzerqung@0pointer.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, libvir-list@redhat.com, lxc-devel@lists.linuxcontainers.org, systemd-devel@lists.freedesktop.org, David Herrmann <dh.herrmann@gmail.com>


On 7 Mar 2014, at 20:24, Lennart Poettering <mzerqung@0pointer.de> wrot=
e:

> On Fri, 07.03.14 19:45, Lukasz Pawelczyk (havner@gmail.com) wrote:
>=20
>> Problem:
>> Has anyone thought about a mechanism to limit/remove an access to a
>> device during an application runtime? Meaning we have an application
>> that has an open file descriptor to some /dev/node and depending on
>> *something* it gains or looses the access to it gracefully (with or
>> without a notification, but without any fatal consequences).
>=20
> logind can mute input devices as sessions are switched, to enable
> unpriviliged X11 and wayland compositors.

Would you please elaborate on this? Where is this mechanism? How does i=
t work without kernel space support? Is there some kernel space support=
 I=92m not aware of?

>> Example:
>> LXC. Imagine we have 2 separate containers. Both running full operat=
ing
>> systems. Specifically with 2 X servers. Both running concurrently of
>=20
> Well, devices are not namespaced on Linux (with the single exception =
of
> network devices). An X server needs device access, hence this doesn't
> fly at all.
>=20
> When you enumerate devices with libudev in a container they will neve=
r
> be marked as "initialized" and you do not get any udev hotplug events=
 in
> containers, and you don#t have the host's udev db around, nor would i=
t
> make any sense to you if you had. X11 and friends rely on udev
> however...
>=20
> Before you think about doing something like this, you need to fix the
> kernel to provide namespaced devices (good luck!)

Precisly! That=92s the generic idea. I=92m not for implementing it thou=
gh at this moment. I just wanted to know whether anybody actually thoug=
h about it or maybe someone is interested in starting such a work, etc.

>> course. Both need the same input devices (e.g. we have just one mous=
e).
>> This creates a security problem when we want to have completely sepa=
rate
>> environments. One container is active (being displayed on a monitor =
and
>> controlled with a mouse) while the other container runs evtest
>> /dev/input/something and grabs the secret password user typed in the
>> other.
>=20
> logind can do this for you between sessions. But such a container set=
up
> will never work without proper device namespacing.

So how can it do it when there is no kernel support? You mean it could =
be doing this if the support were there?

>> Solutions:
>> The complete solution would comprise of 2 parts:
>> - a mechanism that would allow to temporally "hide" a device from an
>> open file descriptor.
>> - a mechanism for deciding whether application/process/namespace sho=
uld
>> have an access to a specific device at a specific moment
>=20
> Well, there's no point in inventing any "mechanisms" like this, as lo=
ng
> as devices are not namespaced in the kernel, so that userspace in
> containers can enumerate/probe/identify/... things correctly=85

True. My point is about kernel space implementation. Like I wrote. I ha=
ven=92t seen anything like this in kernel source and I=92m well away it=
 should be done there.
I would just like to know if anybody is interested in this, if anybody =
started or would like to start such a thing.

I do understand that systemd/logind would only provide a mechanism for =
determining who should have an access and who shouldn=92t (or to be mor=
e specific it would utilize some kernel space configuration like cgroup=
s). But the work itself has to be done in kernel space.

--=20
Regards,
Havner



--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
