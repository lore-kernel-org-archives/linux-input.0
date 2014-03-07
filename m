From: Lukasz Pawelczyk <havner@gmail.com>
Subject: Re: Suspending access to opened/active /dev/nodes
	during application runtime
Date: Fri, 7 Mar 2014 21:45:28 +0100
Message-ID: <93871091-7845-4BCC-A841-F724BEDF6E4B@gmail.com>
References: <E7B2439D-FF36-4353-8E1A-C58E5C33A89F@gmail.com>
	<20140307190939.GA8082@kroah.com>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <systemd-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20140307190939.GA8082@kroah.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/systemd-devel>,
	<mailto:systemd-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/systemd-devel>
List-Post: <mailto:systemd-devel@lists.freedesktop.org>
List-Help: <mailto:systemd-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/systemd-devel>,
	<mailto:systemd-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: systemd-devel-bounces@lists.freedesktop.org
Errors-To: systemd-devel-bounces@lists.freedesktop.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: systemd-devel@lists.freedesktop.org, libvir-list@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, lxc-devel@lists.linuxcontainers.org
List-Id: linux-input@vger.kernel.org


On 7 Mar 2014, at 20:09, Greg KH <gregkh@linuxfoundation.org> wrote:

> On Fri, Mar 07, 2014 at 07:46:44PM +0100, Lukasz Pawelczyk wrote:
>> Problem:
>> Has anyone thought about a mechanism to limit/remove an access to a
>> device during an application runtime? Meaning we have an application
>> that has an open file descriptor to some /dev/node and depending on
>> *something* it gains or looses the access to it gracefully (with or
>> without a notification, but without any fatal consequences).
>> =

>> Example:
>> LXC. Imagine we have 2 separate containers. Both running full operating
>> systems. Specifically with 2 X servers. Both running concurrently of
>> course. Both need the same input devices (e.g. we have just one mouse).
> =

> Stop right there.
> =

> If they "both" need an input device, then they should use the "shared"
> input device stream, i.e. evdev.
> =

> And it goes the same for every type of device the kernel is exposing to
> userspace, if you want to "share" them, then you need to work on
> changing the kernel to be able to handle shared devices.

I think you might have misunderstood me. They are using a shared input stre=
am (evdev in this case). The problem is I don=92t want them to eavesdrop on=
 each other. So it=92s not about making it to work. It=92s about making the=
m to work =84in turns=94.

> And odds are, you will get back a big "as-if" comment from the kernel
> developers, as for almost all devices, they can't be shared, for very
> good reasons.

Evdev devices can.


-- =

Regards,
Havner
