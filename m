From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: Suspending access to opened/active /dev/nodes
	during application runtime
Date: Tue, 11 Mar 2014 13:33:28 +0100
Message-ID: <CANq1E4QnLWVLC0ZdRq=okCGe2+AsmTES6xfi662WjuVtLDe97Q@mail.gmail.com>
References: <9D7BA6C9-9F1F-4D09-8F4F-E7DA4720FF97@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <systemd-devel-bounces@lists.freedesktop.org>
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
Cc: libvir-list@redhat.com, systemd Mailing List <systemd-devel@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, lxc-devel@lists.linuxcontainers.org, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi

On Fri, Mar 7, 2014 at 7:45 PM, Lukasz Pawelczyk <havner@gmail.com> wrote:
> Problem:
> Has anyone thought about a mechanism to limit/remove an access to a
> device during an application runtime? Meaning we have an application
> that has an open file descriptor to some /dev/node and depending on
> *something* it gains or looses the access to it gracefully (with or
> without a notification, but without any fatal consequences).
>
> Example:
> LXC. Imagine we have 2 separate containers. Both running full operating
> systems. Specifically with 2 X servers. Both running concurrently of
> course. Both need the same input devices (e.g. we have just one mouse).
> This creates a security problem when we want to have completely separate
> environments. One container is active (being displayed on a monitor and
> controlled with a mouse) while the other container runs evtest
> /dev/input/something and grabs the secret password user typed in the
> other.
>
> Solutions:
> The complete solution would comprise of 2 parts:
> - a mechanism that would allow to temporally "hide" a device from an
> open file descriptor.
> - a mechanism for deciding whether application/process/namespace should
> have an access to a specific device at a specific moment
>
> Let's focus on the first problem only, as it would need to be solved
> first anyway.  I haven't found anything that would allow me to do
> it. There are a lot mechanisms that make it possible to restrict an
> access during open():
> - DAC
> - ACL (controlled by hand or with uaccess)
> - LSM (in general)
> - device cgroups
> But all of those can't do a thing when the device is already opened and
> an application has a file descriptor.  I don't see such mechanism in
> kernel sources either.
>
> I do imagine that it would not be possible for every device to handle
> such a thing (dri comes to mind) without breaking something (graphics
> card state in dri example). But there is class of simple input/output
> devices that would handle this without problems.
>
> I did implement some proof-of-concept solution for an evdev driver by
> allowing or disallowing events that go to evdev_client structure using
> some arbitrary condition. But this is far from a generic solution.
>
> My proof-of-concept is somewhat similar to this (I just found it):
> http://www.spinics.net/lists/linux-input/msg25547.html
> Though a little bit wider in scope. But neither is flawless nor
> generic.
>
> Has anyone had any thoughts about a similar problem?

Lennart and Greg have already answered most of this, few notes from me:
 * EVIOCREVOKE and DRM_SET_MASTER/DROP_MASTER are real. We use them.
They solve your problem for gfx and input devices.
 * EVIOCMUTE is *bad*. It is a privileged ioctl compared to
EVIOCREVOKE, so we've never merged it. It neither has major advantages
over revoke. So use EVIOCREVOKE.
 * A generic frevoke() syscall would solve all is, but is unlikely to
ever appear upstream.

Cheers
David
