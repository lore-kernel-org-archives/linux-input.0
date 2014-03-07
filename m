From: Lennart Poettering <mzerqung@0pointer.de>
Subject: Re: Suspending access to opened/active /dev/nodes
 during application runtime
Date: Fri, 7 Mar 2014 20:24:10 +0100
Message-ID: <20140307192410.GA24453@tango.0pointer.de>
References: <9D7BA6C9-9F1F-4D09-8F4F-E7DA4720FF97@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <systemd-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <9D7BA6C9-9F1F-4D09-8F4F-E7DA4720FF97@gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/systemd-devel>,
	<mailto:systemd-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/systemd-devel>
List-Post: <mailto:systemd-devel@lists.freedesktop.org>
List-Help: <mailto:systemd-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/systemd-devel>,
	<mailto:systemd-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: systemd-devel-bounces@lists.freedesktop.org
Errors-To: systemd-devel-bounces@lists.freedesktop.org
To: Lukasz Pawelczyk <havner@gmail.com>
Cc: systemd-devel@lists.freedesktop.org, libvir-list@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, lxc-devel@lists.linuxcontainers.org
List-Id: linux-input@vger.kernel.org

On Fri, 07.03.14 19:45, Lukasz Pawelczyk (havner@gmail.com) wrote:

> Problem:
> Has anyone thought about a mechanism to limit/remove an access to a
> device during an application runtime? Meaning we have an application
> that has an open file descriptor to some /dev/node and depending on
> *something* it gains or looses the access to it gracefully (with or
> without a notification, but without any fatal consequences).

logind can mute input devices as sessions are switched, to enable
unpriviliged X11 and wayland compositors.

> Example:
> LXC. Imagine we have 2 separate containers. Both running full operating
> systems. Specifically with 2 X servers. Both running concurrently of

Well, devices are not namespaced on Linux (with the single exception of
network devices). An X server needs device access, hence this doesn't
fly at all.

When you enumerate devices with libudev in a container they will never
be marked as "initialized" and you do not get any udev hotplug events in
containers, and you don#t have the host's udev db around, nor would it
make any sense to you if you had. X11 and friends rely on udev
however...

Before you think about doing something like this, you need to fix the
kernel to provide namespaced devices (good luck!)

> course. Both need the same input devices (e.g. we have just one mouse).
> This creates a security problem when we want to have completely separate
> environments. One container is active (being displayed on a monitor and
> controlled with a mouse) while the other container runs evtest
> /dev/input/something and grabs the secret password user typed in the
> other.

logind can do this for you between sessions. But such a container setup
will never work without proper device namespacing.

> Solutions:
> The complete solution would comprise of 2 parts:
> - a mechanism that would allow to temporally "hide" a device from an
> open file descriptor.
> - a mechanism for deciding whether application/process/namespace should
> have an access to a specific device at a specific moment

Well, there's no point in inventing any "mechanisms" like this, as long
as devices are not namespaced in the kernel, so that userspace in
containers can enumerate/probe/identify/... things correctly...

Lennart

-- 
Lennart Poettering, Red Hat
