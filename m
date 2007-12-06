From: "Nick Turner" <Nick.Turner@nuvation.com>
Subject: Sending simulated mouse events using uinput
Date: Thu, 6 Dec 2007 09:31:56 -0800
Message-ID: <274F7B50569A1B4C9D7BCAB17A9C7BE1835D3C@mailguy3.skynet.nuvation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.nuvation.com ([66.92.10.80]:23400 "EHLO
	mailguy3.skynet.nuvation.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750751AbXLFRb4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 6 Dec 2007 12:31:56 -0500
Content-class: urn:content-classes:message
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Greetings oh Linux input wranglers,

At Nuvation we are building a driver for multiple input devices, all of=
 which need to appear as mouse events in userland.=A0 We've tried sever=
al approaches without any good results.=A0 Lately I've been looking at =
the uinput module, especially after finding an article in January 2007 =
Dashboard about how to do it:

   www.einfochips.com/download/dash_jan_tip.pdf

I made a slightly modified version of the sample code from that article=
=2E=A0 I enabled uinput, verified that it is in place, did chmod a+rw o=
n it so I could open it for writing, and compiled this:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <linux/input.h>
#include <linux/uinput.h>
#include <sys/time.h>
#include <unistd.h>

// Test the uinput module

struct uinput_user_dev   uinp;
struct input_event       event;

int main(void) {

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int ufile, retcode, i;

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ufile =3D open("/dev/input/uinput", O=
_WRONLY | O_NDELAY );
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printf("open /dev/input/uinput return=
ed %d.\n", ufile);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ufile =3D=3D 0) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 p=
rintf("Could not open uinput.\n");
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 r=
eturn -1;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memset(&uinp, 0, sizeof(uinp));
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 strncpy(uinp.name, "simulated mouse",=
 20);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uinp.id.version =3D 4;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uinp.id.bustype =3D BUS_USB;

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ioctl(ufile, UI_SET_EVBIT, EV_KEY);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ioctl(ufile, UI_SET_EVBIT, EV_REL);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ioctl(ufile, UI_SET_RELBIT, REL_X);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ioctl(ufile, UI_SET_RELBIT, REL_Y);

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for (i=3D0; i<256; i++) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i=
octl(ufile, UI_SET_KEYBIT, i);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ioctl(ufile, UI_SET_KEYBIT, BTN_MOUSE=
);

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 // create input device in input subsy=
stem
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 retcode =3D write(ufile, &uinp, sizeo=
f(uinp));
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printf("First write returned %d.\n", =
retcode);

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 retcode =3D (ioctl(ufile, UI_DEV_CREA=
TE));
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printf("ioctl UI_DEV_CREATE returned =
%d.\n", retcode);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (retcode) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 p=
rintf("Error create uinput device %d.\n", retcode);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 r=
eturn -1;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 // NOW DO STUFF !!!!

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for (i=3D0; i<100; i++) {

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 s=
truct timeval tv1;

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /=
/ move pointer upleft by 5 pixels
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 m=
emset(&event, 0, sizeof(event));
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 g=
ettimeofday(&event.time, NULL);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 e=
vent.type =3D EV_REL;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 e=
vent.code =3D REL_X;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 e=
vent.value =3D -5;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 w=
rite(ufile, &event, sizeof(event));
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 m=
emset(&event, 0, sizeof(event));
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 g=
ettimeofday(&event.time, NULL);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 e=
vent.type =3D EV_REL;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 e=
vent.code =3D REL_Y;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 e=
vent.value =3D -5;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 w=
rite(ufile, &event, sizeof(event));
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 m=
emset(&event, 0, sizeof(event));
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 g=
ettimeofday(&event.time, NULL);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 e=
vent.type =3D EV_SYN;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 e=
vent.code =3D SYN_REPORT;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 e=
vent.value =3D 0;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 w=
rite(ufile, &event, sizeof(event));

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /=
/ wait just a moment
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d=
o { gettimeofday(&tv1, NULL); } while ((tv1.tv_usec & 0x3FFF) !=3D 0);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d=
o { gettimeofday(&tv1, NULL); } while ((tv1.tv_usec & 0x3FFF) =3D=3D 0)=
;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 // destroy the device
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ioctl(ufile, UI_DEV_DESTROY);

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 close(ufile);

}

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

As I understand it, this ought to cause the mouse to move slowly upleft=
 for a few seconds - but nothing happens!=A0 It is not clear to me what=
 is wrong.

The output on the command line is thus:

[fedorauser@localhost uinputtest]$ gcc uinputtest.c
[fedorauser@localhost uinputtest]$ ./a.out
open /dev/input/uinput returned 3.
=46irst write returned 1116.
ioctl UI_DEV_CREATE returned 0.
[fedorauser@localhost uinputtest]$

I am running Fedora on a VM (using VMWare Player) on a Windows XP machi=
ne.=A0 Here is /etc/X11/xorg.conf:



# Xorg configuration created by system-config-display

Section "ServerLayout"
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Identifier=A0=A0=A0=A0 "single head c=
onfiguration"
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Screen=A0=A0=A0=A0=A0 0=A0 "Screen0" =
0 0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 InputDevice=A0=A0=A0 "Keyboard0" "Cor=
eKeyboard"
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 InputDevice=A0=A0=A0 "VMMouse" "CoreP=
ointer"
EndSection

Section "InputDevice"
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Identifier=A0 "Keyboard0"
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Driver=A0=A0=A0=A0=A0 "kbd"
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Option =A0=A0=A0 "XkbModel" "pc105"
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Option =A0=A0=A0 "XkbLayout" "us"
EndSection

Section "InputDevice"
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Identifier=A0 "VMMouse"
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Driver=A0=A0=A0=A0=A0 "vmmouse"
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Option =A0=A0=A0 "Device" "/dev/input=
/mice"
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Option =A0=A0=A0 "Emulate3Buttons" "y=
es"
EndSection

Section "Monitor"
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Identifier=A0=A0 "Monitor0"
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ModelName=A0=A0=A0 "LCD Panel 1680x10=
50"
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 HorizSync=A0=A0=A0 31.5 - 90.0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 VertRefresh=A0 59.9 - 60.1
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Option =A0=A0=A0 "dpms"
EndSection

Section "Device"
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Identifier=A0 "Videocard0"
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Driver=A0=A0=A0=A0=A0 "vmware"
EndSection

Section "Screen"
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Identifier "Screen0"
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Device=A0=A0=A0=A0 "Videocard0"
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Monitor=A0=A0=A0 "Monitor0"
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DefaultDepth=A0=A0=A0=A0 24
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SubSection "Display"
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 V=
iewport=A0=A0 0 0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 D=
epth=A0=A0=A0=A0 24
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 EndSubSection
EndSection



Can anyone offer some advice?=A0 Are we forgetting something terribly o=
bvious?=A0 Is the fact of running under a VM somehow messing us up?

Thanks, people.=A0 I'm new to Linux - it's great to find out what a lar=
ge group of humans are actively supporting it.

Looking forward to any replies,

Nick Turner
Design Engineer
Nuvation, inc.
San Jose, CA
408-228-5580 x258

-
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
