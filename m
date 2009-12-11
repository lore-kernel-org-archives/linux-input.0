From: "Rick L. Vinyard, Jr." <rvinyard-qcTL/1vZYtiVc3sceRu5cw@public.gmane.org>
Subject: Logitech G13 driver + user-space libraries available
Date: Fri, 11 Dec 2009 10:24:52 -0700
Message-ID: <d4690bfe19cee0dc8c5355a684fa7e09.squirrel@intranet.cs.nmsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux USB <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Here's a first look at the G13 driver I've been playing around with:
     git://g13.git.sourceforge.net/gitroot/g13/g13

I've been building the driver out-of-tree and this is my first (untested)
shot at moving it in-tree. There are still a number of things to do (and
clean up) in the driver but it is rather functional.

I'll test it later today and update the repo as necessary, but I thought
I'd throw it out there now.

Here's the repo for the support libraries:
     svn co https://g13.svn.sourceforge.net/svnroot/g13/trunk g13

The Gtk and Gtkmm libs are empty for now, but I have tested the g13 and
g13-cairo libs.

The g13 library uses udev for device discovery and exports many of the
sysfs attributes in a little bit friendlier API. See the 'utilities'
directory and 'examples/g13-draw-checkerboard' for examples of the API.

The g13-cairo library similarly provides an API that bridges the
framebuffer functions of the g13 library with cairo making it a little
more friendly to draw directly on the framebuffer. See
'examples/cairo/g13-cairo-helloworld' for an animated example drawing with
cairo to the g13 framebuffer.

Feedback, comments, critiques and flames are welcome.

---

Rick


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
