From: "Bird, Timothy" <Tim.Bird@am.sony.com>
Subject: RE: [PATCH 0/7] HID: sony: DS4 fixes and improvements
Date: Fri, 9 Dec 2016 17:51:56 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF0ABBF81B@USCULXMSG01.am.sony.com>
References: <1481252996-25288-1-git-send-email-roderick@gaikai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-by2nam03on0103.outbound.protection.outlook.com ([104.47.42.103]:45408
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752110AbcLIW01 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 9 Dec 2016 17:26:27 -0500
In-Reply-To: <1481252996-25288-1-git-send-email-roderick@gaikai.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "roderick@gaikai.com" <roderick@gaikai.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, "Colenbrander, Roelof" <Roderick.Colenbrander@sony.com>

> -----Original Message-----
> From: Roderick Colenbrander on Thursday, December 08, 2016 7:10 PM
>
> This patch series contains a few small fixes/improvements in addition
> to the motion sensor patches, shared before.

Since this was a re-send, it should have been labelled with v2 in the
subject line.  ex: [PATCH v2 0/7]].

git format-patch does this for you if you use the "-v <n>" option.

Also, it would be good to include a list of any changes made since v1,
in the top portion of the patch, where applicable.  This is usually placed
after a --- line in the commit description, so that it doesn't get put into
the final commit message.  See https://kernelnewbies.org/PatchTipsAndTricks
for an example of this.
 -- Tim

