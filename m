From: Lukasz Pawelczyk <havner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Suspending access to opened/active /dev/nodes during
	application runtime
Date: Fri, 7 Mar 2014 19:45:05 +0100
Message-ID: <9D7BA6C9-9F1F-4D09-8F4F-E7DA4720FF97@gmail.com>
Reply-To: LXC development mailing-list <lxc-devel-cunTk1MwBs9qMoObBWhMNEqPaTDuhLve2LY78lusg7I@public.gmane.org>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: multipart/mixed; boundary="===============6598445596956306415=="
Return-path: <lxc-devel-bounces-cunTk1MwBs9qMoObBWhMNEqPaTDuhLve2LY78lusg7I@public.gmane.org>
List-Unsubscribe: <http://lists.linuxcontainers.org/options/lxc-devel>,
 <mailto:lxc-devel-request-cunTk1MwBs9qMoObBWhMNEqPaTDuhLve2LY78lusg7I@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxcontainers.org/pipermail/lxc-devel>
List-Post: <mailto:lxc-devel-cunTk1MwBs9qMoObBWhMNEqPaTDuhLve2LY78lusg7I@public.gmane.org>
List-Help: <mailto:lxc-devel-request-cunTk1MwBs9qMoObBWhMNEqPaTDuhLve2LY78lusg7I@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linuxcontainers.org/listinfo/lxc-devel>,
 <mailto:lxc-devel-request-cunTk1MwBs9qMoObBWhMNEqPaTDuhLve2LY78lusg7I@public.gmane.org?subject=subscribe>
Errors-To: lxc-devel-bounces-cunTk1MwBs9qMoObBWhMNEqPaTDuhLve2LY78lusg7I@public.gmane.org
Sender: lxc-devel-bounces-cunTk1MwBs9qMoObBWhMNEqPaTDuhLve2LY78lusg7I@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, libvir-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, lxc-devel-cunTk1MwBs9qMoObBWhMNEqPaTDuhLve2LY78lusg7I@public.gmane.org, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, David Herrmann <dh.herrmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org


--===============6598445596956306415==
Content-Type: multipart/alternative; boundary="Apple-Mail=_C2302F36-8BDE-4431-9E8C-E6057EDCDDC4"


--Apple-Mail=_C2302F36-8BDE-4431-9E8C-E6057EDCDDC4
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

Problem:
Has anyone thought about a mechanism to limit/remove an access to a
device during an application runtime? Meaning we have an application
that has an open file descriptor to some /dev/node and depending on
*something* it gains or looses the access to it gracefully (with or
without a notification, but without any fatal consequences).

Example:
LXC. Imagine we have 2 separate containers. Both running full operating
systems. Specifically with 2 X servers. Both running concurrently of
course. Both need the same input devices (e.g. we have just one mouse).
This creates a security problem when we want to have completely separate
environments. One container is active (being displayed on a monitor and
controlled with a mouse) while the other container runs evtest
/dev/input/something and grabs the secret password user typed in the
other.

Solutions:
The complete solution would comprise of 2 parts:
- a mechanism that would allow to temporally "hide" a device from an
open file descriptor.
- a mechanism for deciding whether application/process/namespace should
have an access to a specific device at a specific moment

Let's focus on the first problem only, as it would need to be solved
first anyway.  I haven't found anything that would allow me to do
it. There are a lot mechanisms that make it possible to restrict an
access during open():
- DAC
- ACL (controlled by hand or with uaccess)
- LSM (in general)
- device cgroups
But all of those can't do a thing when the device is already opened and
an application has a file descriptor.  I don't see such mechanism in
kernel sources either.

I do imagine that it would not be possible for every device to handle
such a thing (dri comes to mind) without breaking something (graphics
card state in dri example). But there is class of simple input/output
devices that would handle this without problems.

I did implement some proof-of-concept solution for an evdev driver by
allowing or disallowing events that go to evdev_client structure using
some arbitrary condition. But this is far from a generic solution.

My proof-of-concept is somewhat similar to this (I just found it):
http://www.spinics.net/lists/linux-input/msg25547.html
Though a little bit wider in scope. But neither is flawless nor
generic.

Has anyone had any thoughts about a similar problem?


-- 
Regards
Havner

--Apple-Mail=_C2302F36-8BDE-4431-9E8C-E6057EDCDDC4
Content-Transfer-Encoding: 7bit
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv="Content-Type" content="text/html charset=us-ascii"></head><body style="word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space;"><div dir="ltr"><div>Problem:</div><div>Has anyone thought about a mechanism to limit/remove an access to a</div><div>device during an application runtime? Meaning we have an application</div><div>that has an open file descriptor to some /dev/node and depending on</div>
<div>*something* it gains or looses the access to it gracefully (with or</div><div>without a notification, but without any fatal consequences).</div><div><br></div><div>Example:</div><div>LXC. Imagine we have 2 separate containers. Both running full operating</div>
<div>systems. Specifically with 2 X servers. Both running concurrently of</div><div>course. Both need the same input devices (e.g. we have just one mouse).</div><div>This creates a security problem when we want to have completely separate</div>
<div>environments. One container is active (being displayed on a monitor and</div><div>controlled with a mouse) while the other container runs evtest</div><div>/dev/input/something and grabs the secret password user typed in the</div>
<div>other.</div><div><br></div><div>Solutions:</div><div>The complete solution would comprise of 2 parts:</div><div>- a mechanism that would allow to temporally "hide" a device from an</div><div>open file descriptor.</div>
<div>- a mechanism for deciding whether application/process/namespace should</div><div>have an access to a specific device at a specific moment</div><div><br></div><div>Let's focus on the first problem only, as it would need to be solved</div>
<div>first anyway. &nbsp;I haven't found anything that would allow me to do</div><div>it. There are a lot mechanisms that make it possible to restrict an</div><div>access during open():</div><div>- DAC</div><div>- ACL (controlled by hand or with uaccess)</div>
<div>- LSM (in general)</div><div>- device cgroups</div><div>But all of those can't do a thing when the device is already opened and</div><div>an application has a file descriptor. &nbsp;I don't see such mechanism in</div>
<div>kernel sources either.</div><div><br></div><div>I do imagine that it would not be possible for every device to handle</div><div>such a thing (dri comes to mind) without breaking something (graphics</div><div>card state in dri example). But there is class of simple input/output</div>
<div>devices that would handle this without problems.</div><div><br></div><div>I did implement some proof-of-concept solution for an evdev driver by</div><div>allowing or disallowing events that go to evdev_client structure using</div>
<div>some arbitrary condition. But this is far from a generic solution.</div><div><br></div><div>My proof-of-concept is somewhat similar to this (I just found it):</div><div><a href="http://www.spinics.net/lists/linux-input/msg25547.html">http://www.spinics.net/lists/linux-input/msg25547.html</a></div>
<div>Though a little bit wider in scope. But neither is flawless nor</div><div>generic.</div><div><br></div><div>Has anyone had any thoughts about a similar problem?</div><div><br></div><div><br></div>-- <br>Regards<br>Havner<br>

</div>
</body></html>
--Apple-Mail=_C2302F36-8BDE-4431-9E8C-E6057EDCDDC4--

--===============6598445596956306415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lxc-devel mailing list
lxc-devel-cunTk1MwBs9qMoObBWhMNEqPaTDuhLve2LY78lusg7I@public.gmane.org
http://lists.linuxcontainers.org/listinfo/lxc-devel

--===============6598445596956306415==--
