From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH v2 0/3] Another try for the Sixaxis plugin
Date: Fri, 25 Feb 2011 11:04:49 +0100
Message-ID: <1298628292-8842-1-git-send-email-ospite@studenti.unina.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:34252 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932439Ab1BYKIK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Feb 2011 05:08:10 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-bluetooth@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>, "Pascal A . Brisset" <pascal44973@pabr.org>, Marcin Tolysz <tolysz@gmail.com>, Christian Birchinger <joker@netswarm.net>, Filipe Lopes <falktx@gmail.com>, Alan Ott <alan@signal11.us>, Mikko Virkkila <virkkila@kapsi.fi>

Hi,

this is another attempt to get the sixaxis plugin merged upstream in
bluez, now cable pairing is done without libusb, which is good because
the hid driver does not need to be detached anymore.

The work is based on patches by Bastian Nocera, so its SOB line comes
first on the third patch, even though many parts have been totally
reimplemented.  More comments on the patch itself.

Bastien, I took the liberty to impersonate you in the second patch about
re-adding manager_get_default_adapter(), because the change was taken
out from your bluez rpm package. I hope this is OK.

I was wondering if it was possible to have the equivalent of this plugin
as a separate daemon doing the association part with bluez over dbus,
instead of having it builtin (I do not know the bluez dbus interface at
all), and if there were any major drawbacks with that compared to the
builtin plugin. What are your opinions on that?

Anyhow,

HOWTO test it:
  - Get a kernel supporting HIDIOCSFEATURE and HIDIOCGFEATURE: linux-next
    should have that, or Jiki Kosina's hidraw-feature branch:
    http://git.kernel.org/?p=linux/kernel/git/jikos/hid.git;a=shortlog;h=refs/heads/hidraw-feature
  - Build it and install it with its linux-libc-dev package ("make
    deb-pkg" on recent kernels builds that already).
  - Apply the patches in this series and configure bluez, the ioctl
    above should be detected automatically and the plugin enabled.
  - If there is any problem, try backing up and cleaning up
    /var/lib/bluetooth/

TODO before merging:
  - Check the routine about bluetooth association. Also, is it strictly
    necessary to grant manually the first connection?
  - Add the actual official version of linux-libc-dev in which the
    hidraw ioctl will be merged (now it is just 2.6.3x as a
    placeholder).
  - Check the last comment from Marcel about the timeout in
    http://marc.info/?l=linux-bluetooth&m=125525415718147&w=2 Could you
    comment on the third patch about that, please?
  - When the controller is connected via USB after it is working over BT
    it is seen as a second controller and the second LED is turned on,
    should we force BT disconnection on USB connection?
  - Test with multiple controllers, and/or multiple BT adapters, which I
    can't do right now.
  - Remove the XXX comment about the lowercase hex bdaddr format.


FUTURE plans:
 - Add support for battery status report
 - Add support for Playstation Move (I don't have the hardware, tho),
   Pascal?

Thanks,
   Antonio


Antonio Ospite (2):
  Remove input/sixpair.c
  Add sixaxis plugin: USB pairing and LEDs settings

Bastien Nocera (1):
  Re-add manager_get_default_adapter()

 Makefile.am       |    9 +-
 acinclude.m4      |   39 ++++
 configure.ac      |    1 +
 input/sixpair.c   |  299 -------------------------------
 plugins/sixaxis.c |  506 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/manager.c     |    5 +
 src/manager.h     |    1 +
 7 files changed, 559 insertions(+), 301 deletions(-)
 delete mode 100644 input/sixpair.c
 create mode 100644 plugins/sixaxis.c

-- 
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
