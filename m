From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [systemd-devel] Suspending access to opened/active /dev/nodes
 during application runtime
Date: Fri, 7 Mar 2014 12:55:40 -0800
Message-ID: <20140307205540.GA6354@kroah.com>
References: <E7B2439D-FF36-4353-8E1A-C58E5C33A89F@gmail.com>
 <20140307190939.GA8082@kroah.com>
 <93871091-7845-4BCC-A841-F724BEDF6E4B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:43746 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107AbaCGUxx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Mar 2014 15:53:53 -0500
Content-Disposition: inline
In-Reply-To: <93871091-7845-4BCC-A841-F724BEDF6E4B@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lukasz Pawelczyk <havner@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, libvir-list@redhat.com, lxc-devel@lists.linuxcontainers.org, systemd-devel@lists.freedesktop.org, David Herrmann <dh.herrmann@gmail.com>

On Fri, Mar 07, 2014 at 09:45:28PM +0100, Lukasz Pawelczyk wrote:
>=20
> On 7 Mar 2014, at 20:09, Greg KH <gregkh@linuxfoundation.org> wrote:
>=20
> > On Fri, Mar 07, 2014 at 07:46:44PM +0100, Lukasz Pawelczyk wrote:
> >> Problem:
> >> Has anyone thought about a mechanism to limit/remove an access to =
a
> >> device during an application runtime? Meaning we have an applicati=
on
> >> that has an open file descriptor to some /dev/node and depending o=
n
> >> *something* it gains or looses the access to it gracefully (with o=
r
> >> without a notification, but without any fatal consequences).
> >>=20
> >> Example:
> >> LXC. Imagine we have 2 separate containers. Both running full oper=
ating
> >> systems. Specifically with 2 X servers. Both running concurrently =
of
> >> course. Both need the same input devices (e.g. we have just one mo=
use).
> >=20
> > Stop right there.
> >=20
> > If they "both" need an input device, then they should use the "shar=
ed"
> > input device stream, i.e. evdev.
> >=20
> > And it goes the same for every type of device the kernel is exposin=
g to
> > userspace, if you want to "share" them, then you need to work on
> > changing the kernel to be able to handle shared devices.
>=20
> I think you might have misunderstood me. They are using a shared inpu=
t
> stream (evdev in this case). The problem is I don=E2=80=99t want them=
 to
> eavesdrop on each other. So it=E2=80=99s not about making it to work.=
 It=E2=80=99s
> about making them to work =E2=80=9Ein turns=E2=80=9D.

See Lennart's comment about namespaces for devices, and how the kernel
doesn't support it, for the answer to this.

Sorry, not going to happen, use real virtual machines if you want to do
this.

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
