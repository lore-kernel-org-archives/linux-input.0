From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: Lenovo G360: ALPS Touchpad Recognized as "PS/2 Generic
 Mouse"(with newly dmesg information)
Date: Fri, 6 Jul 2012 00:11:41 -0500
Message-ID: <20120706051141.GA2937@thinkpad-t410>
References: <20120706113942.40152322.dashing.meng@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:35172 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962Ab2GFFLp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Jul 2012 01:11:45 -0400
Content-Disposition: inline
In-Reply-To: <20120706113942.40152322.dashing.meng@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: littlebat <dashing.meng@gmail.com>
Cc: linux-input@vger.kernel.org, 679750@bugs.debian.org, jrnieder@gmail.com, rik.theys@gmail.com


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 06, 2012 at 11:39:42AM +0800, littlebat wrote:
> I found these lines in my dmesg information:
> [   19.995850] psmouse serio4: alps: E6 report: 00 00 64
> [   20.021288] psmouse serio4: alps: E7 report: 73 03 50
> [   20.623609] input: PS/2 Generic Mouse
> as /devices/platform/i8042/serio4/input/input9

Thanks, this is the information we need to check whether or not your
touchpad uses any of the known ALPS protocols.

I'm attaching a patch to use as a starting point. Basically we're just
going to try each protocol version until either we find one that works
or run out of options. You should have an external mouse available,
because it's likely that your touchpad will not be usable. I've also
heard that some of the workarounds that people use to get the "disable
touchpad while typing" behavior can cause the touchpad to no longer
function once it starts behaving as a touchpad, so you should look out
for that as well.

I won't be able to respond further until next Monday, but it's pretty
simple to modify the driver to try different protocol versions so I'll
give you some instructions. The patch adds the following line. I've
identified the two fields you'll need to change.

    { { 0x73, 0x03, 0x50 }, 0x8a, ALPS_PROTO_V4, 0x8f, 0x8f, 0 },
                              ^         ^
                              |         |
                    command_mode_resp   |
                                  proto_version

Not surprisingly, to try different protocol versions you just need to
change the proto_version field. Try ALPS_PROTO_V4 first, if that doesn't
work try ALPS_PROTO_V3, etc., until you've tried them all or found one
that works.

The first time you run the patch though you need to be on the lookout
for a message in dmesg that says "Unknown command mode response"
followed by two hex digits. If you see this then you need to change
command_mode_resp to match the response printed in the message. Be sure
to leave the 0x characters in place; only replace the 8a characters.
Then try the same protocol version again.

The basic test procedure after booting with a test version of the driver
is:

 1. Check dmesg for any errors from the alps driver. If you see anything
    other than the "Unknown command mode response" message then it
    probably means your touchpad doesn't use that protocol version, so
    you should move on to the next one. If the device name isn't showing
    up as something with ALPS in it, that also indicates your device
    isn't using that version.

 2. Thoroughly test the touchpad. You may see erratic behavior -- the
    pointer jumping around, random clicks, etc -- which means it's using
    a different protocol.

If you find a protocol version that works, let me know and I'll help get
it added to the driver. If you don't then there's not much more I can do
to help without hardware.

Seth

--2oS5YaxWCcQjTEyO
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="alps-test.patch"

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 4c6a72d..979339c 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -15,6 +15,8 @@
  * the Free Software Foundation.
  */
 
+#define DEBUG
+
 #include <linux/slab.h>
 #include <linux/input.h>
 #include <linux/input/mt.h>
@@ -112,6 +114,7 @@ static const struct alps_model_info alps_model_data[] = {
 	{ { 0x73, 0x02, 0x64 },	0x9b, ALPS_PROTO_V3, 0x8f, 0x8f, ALPS_DUALPOINT },
 	{ { 0x73, 0x02, 0x64 },	0x9d, ALPS_PROTO_V3, 0x8f, 0x8f, ALPS_DUALPOINT },
 	{ { 0x73, 0x02, 0x64 },	0x8a, ALPS_PROTO_V4, 0x8f, 0x8f, 0 },
+	{ { 0x73, 0x03, 0x50 },	0x8a, ALPS_PROTO_V4, 0x8f, 0x8f, 0 },
 };
 
 /*

--2oS5YaxWCcQjTEyO--
