From: Matt Walker <matt.g.d.walker-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv2] drivers/input/mouse: add support for newer elantech
 touchpads (released ca. August 2013);
Date: Wed, 4 Dec 2013 12:57:15 -0500
Message-ID: <CA+X2d=AHdivGF+s_uOC2ns5okoOdZHX1kEg4iuB32zUkBjsszg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11c223deba01c804ecb92415
Return-path: <backports-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: backports-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: backports-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

--001a11c223deba01c804ecb92415
Content-Type: text/plain; charset=ISO-8859-1

From: Matt Walker <matt.g.d.walker-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Added detection for newer Elantech touchpads, so that kernel doesn't
fall-back to default PS/2 driver. Supports touchpads released after
~August 2013.  Fixes bug:
https://lists.launchpad.net/kernel-packages/msg18481.html

Signed-off by: Matt Walker <matt.g.d.walker-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> on an Acer
Aspire S7-392-6302

----

Thanks to Hauke for the reference on how to submit a patch properly.
Thanks to Dmitry for correction to Signed-off line.

Diff Output:

--- linux-3.13-rc1/drivers/input/
mouse/elantech.c.orig    2013-12-03
12:14:52.829173656 -0500
+++ linux-3.13-rc1/drivers/input/mouse/elantech.c    2013-12-03
12:15:11.833173880 -0500
@@ -1313,6 +1313,7 @@ static int elantech_set_properties(struc
             break;
         case 6:
         case 7:
+        case 8:
             etd->hw_version = 4;
             break;
         default:

--001a11c223deba01c804ecb92415
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hosvo7380

LS0tIGxpbnV4LTMuMTMtcmMxL2RyaXZlcnMvaW5wdXQvbW91c2UvZWxhbnRlY2guYy5vcmlnCTIw
MTMtMTItMDMgMTI6MTQ6NTIuODI5MTczNjU2IC0wNTAwCisrKyBsaW51eC0zLjEzLXJjMS9kcml2
ZXJzL2lucHV0L21vdXNlL2VsYW50ZWNoLmMJMjAxMy0xMi0wMyAxMjoxNToxMS44MzMxNzM4ODAg
LTA1MDAKQEAgLTEzMTMsNiArMTMxMyw3IEBAIHN0YXRpYyBpbnQgZWxhbnRlY2hfc2V0X3Byb3Bl
cnRpZXMoc3RydWMKIAkJCWJyZWFrOwogCQljYXNlIDY6CiAJCWNhc2UgNzoKKwkJY2FzZSA4Ogog
CQkJZXRkLT5od192ZXJzaW9uID0gNDsKIAkJCWJyZWFrOwogCQlkZWZhdWx0Ogo=
--001a11c223deba01c804ecb92415--
