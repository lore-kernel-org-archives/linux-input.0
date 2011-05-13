From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: IR remote control autorepeat / evdev
Date: Fri, 13 May 2011 09:51:02 +0200
Message-ID: <4DCCE2E6.3070703@redhat.com>
References: <20110510053038.GA5808@barra.redhat.com> <4DC940E5.2070902@iki.fi> <4DCA1496.20304@redhat.com> <4DCABA42.30505@iki.fi> <4DCABEAE.4080607@redhat.com> <4DCACE74.6050601@iki.fi> <4DCB213A.8040306@redhat.com> <4DCB2BD9.6090105@iki.fi> <4DCB336B.2090303@redhat.com> <4DCB39AF.2000807@redhat.com> <20110512060529.GA14710@barra.bne.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:26718 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757481Ab1EMHvQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 13 May 2011 03:51:16 -0400
In-Reply-To: <20110512060529.GA14710@barra.bne.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Anssi Hannula <anssi.hannula@iki.fi>, linux-media@vger.kernel.org, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, xorg-devel@lists.freedesktop.org

Em 12-05-2011 08:05, Peter Hutterer escreveu:
> On Thu, May 12, 2011 at 03:36:47AM +0200, Mauro Carvalho Chehab wrote=
:
>> Em 12-05-2011 03:10, Mauro Carvalho Chehab escreveu:
>>> Em 12-05-2011 02:37, Anssi Hannula escreveu:
>>
>>>> I don't see any other places:
>>>> $ git grep 'REP_PERIOD' .
>>>> dvb/dvb-usb/dvb-usb-remote.c:   input_dev->rep[REP_PERIOD] =3D
>>>> d->props.rc.legacy.rc_interval;
>>>
>>> Indeed, the REP_PERIOD is not adjusted on other drivers. I agree th=
at we
>>> should change it to something like 125ms, for example, as 33ms is t=
oo=20
>>> short, as it takes up to 114ms for a repeat event to arrive.
>>>
>> IMO, the enclosed patch should do a better job with repeat events, w=
ithout
>> needing to change rc-core/input/event logic.
>>
>> -
>>
>> Subject: Use a more consistent value for RC repeat period
>> From: Mauro Carvalho Chehab <mchehab@redhat.com>
>>
>> The default REP_PERIOD is 33 ms. This doesn't make sense for IR's,
>> as, in general, an IR repeat scancode is provided at every 110/115ms=
,
>> depending on the RC protocol. So, increase its default, to do a
>> better job avoiding ghost repeat events.
>>
>> Signed-off-by: Mauro Carvalho Chehab <mchehab@redhat.com>
>>
>> diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
>> index f53f9c6..ee67169 100644
>> --- a/drivers/media/rc/rc-main.c
>> +++ b/drivers/media/rc/rc-main.c
>> @@ -1044,6 +1044,13 @@ int rc_register_device(struct rc_dev *dev)
>>  	 */
>>  	dev->input_dev->rep[REP_DELAY] =3D 500;
>> =20
>> +	/*
>> +	 * As a repeat event on protocols like RC-5 and NEC take as long a=
s
>> +	 * 110/114ms, using 33ms as a repeat period is not the right thing
>> +	 * to do.
>> +	 */
>> +	dev->input_dev->rep[REP_PERIOD] =3D 125;
>> +
>>  	path =3D kobject_get_path(&dev->dev.kobj, GFP_KERNEL);
>>  	printk(KERN_INFO "%s: %s as %s\n",
>>  		dev_name(&dev->dev),
>=20
> so if I get this right, a XkbSetControls(.. XkbRepeatKeysMask ...) by=
 a
> client to set the repeat rate would provide the same solution - for t=
hose
> clients/devices affected.=20

Yes, if we preserve the same logic. The above will probably still gener=
ate
ghost repeats if the user keeps the IR pressed for a long time, as we'r=
e using
a separate timer at the rc-core logic than the one used inside evdev.

> The interesting question is how clients would identify the devices th=
at are
> affected by this (other than trial and error).

That is easy. I've added a logic that detects it on Xorg evdev on some =
RFC patches
I've prepared in the past to allow using a keycode with more than 247 f=
or IR's.
I'll work on a new version for it and submit again when I have some tim=
e.
Anyway, I'm enclosing a patch with the old version.=20

Basically, GetRCInputs.c file adds a logic that returns a list of input=
 devices
that are Remote Controllers, using rc-core.

This logic inside evdev gets the RC devices and adds a flag identifying=
 them
as such:

+    /* Check if the device is a remote controller */
+    pRCDevList =3D GetRCInputDevices(&NumDevices);
+    for (i =3D 0; i < NumDevices; i++) {
+        if (!strcmp(device, pRCDevList[i].InputName)) {
+             pEvdev->flags |=3D EVDEV_RC_EVENTS;
+             break;
+        }
+    }

Thanks,
Mauro

-

diff --git a/src/GetRCInputs.c b/src/GetRCInputs.c
new file mode 100644
index 0000000..0e03e3a
--- /dev/null
+++ b/src/GetRCInputs.c
@@ -0,0 +1,358 @@
+/*
+ * Copyright =A9 2011 Red Hat, Inc.
+ *
+ * Permission to use, copy, modify, distribute, and sell this software
+ * and its documentation for any purpose is hereby granted without
+ * fee, provided that the above copyright notice appear in all copies
+ * and that both that copyright notice and this permission notice
+ * appear in supporting documentation, and that the name of Red Hat
+ * not be used in advertising or publicity pertaining to distribution
+ * of the software without specific, written prior permission.  Red
+ * Hat makes no representations about the suitability of this software
+ * for any purpose.  It is provided "as is" without express or implied
+ * warranty.
+ *
+ * THE AUTHORS DISCLAIM ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
+ * INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN
+ * NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY SPECIAL, INDIRECT OR
+ * CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS
+ * OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
+ * NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
+ * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ *
+ * Author:
+ * 	Mauro Carvalho Chehab <mchehab@redhat.com>
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include "evdev.h"
+
+#include <X11/keysym.h>
+#include <X11/extensions/XI.h>
+
+#include <ctype.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <linux/input.h>
+#include <sys/ioctl.h>
+#include <dirent.h>
+
+#include <xf86.h>
+#include <xf86Xinput.h>
+#include <exevents.h>
+#include <xorgVersion.h>
+#include <xkbsrv.h>
+
+struct UEvents {
+    char           *key;
+    char           *value;
+    struct UEvents *next;
+};
+
+struct SysfsNames  {
+    char              *name;
+    struct SysfsNames *next;
+};
+
+struct RCDevice {
+    char *SysfsName;    /* Device sysfs node name */
+    char *InputName;    /* Input device file name */
+};
+
+static void FreeNames(struct SysfsNames *names)
+{
+    struct SysfsNames *old;
+    do {
+        old =3D names;
+        names =3D names->next;
+        if (old->name)
+            free(old->name);
+        free(old);
+    } while (names);
+}
+
+static struct SysfsNames *SeekSysfsDir(char *dname, char *NodeName)
+{
+    DIR                *dir;
+    struct dirent      *entry;
+    struct SysfsNames  *names, *CurName;
+
+    names =3D calloc(sizeof(*names), 1);
+
+    CurName =3D names;
+
+    dir =3D opendir(dname);
+    if (!dir) {
+        perror(dname);
+        return NULL;
+    }
+    entry =3D readdir(dir);
+    while (entry) {
+        if (!NodeName || !strncmp(entry->d_name, NodeName, strlen(Node=
Name))) {
+            CurName->name =3D malloc(strlen(dname) + strlen(entry->d_n=
ame) + 2);
+            if (!CurName->name)
+                goto err;
+            strcpy(CurName->name, dname);
+            strcat(CurName->name, entry->d_name);
+            if (NodeName)
+                strcat(CurName->name, "/");
+            CurName->next =3D calloc(sizeof(*CurName), 1);
+            if (!CurName->next)
+                goto err;
+            CurName =3D CurName->next;
+        }
+        entry =3D readdir(dir);
+    }
+    closedir(dir);
+
+    if (names =3D=3D CurName) {
+        xf86Msg(X_ERROR, "Couldn't find any node at %s%s*.\n",
+            dname, NodeName);
+        free (names);
+        names =3D NULL;
+    }
+    return names;
+
+err:
+    perror("Seek dir");
+    FreeNames(names);
+    return NULL;
+}
+
+static void FreeUevent(struct UEvents *uevent)
+{
+    struct UEvents *old;
+    do {
+        old =3D uevent;
+        uevent =3D uevent->next;
+        if (old->key)
+            free(old->key);
+        if (old->value)
+            free(old->value);
+        free(old);
+    } while (uevent);
+}
+
+static struct UEvents *ReadSysfsUevents(char *dname)
+{
+    FILE           *fp;
+    struct UEvents *next, *uevent;
+    char           *event =3D "uevent", *file, s[4096];
+
+    next =3D uevent =3D calloc(1, sizeof(*uevent));
+
+    file =3D malloc(strlen(dname) + strlen(event) + 1);
+    strcpy(file, dname);
+    strcat(file, event);
+
+    fp =3D fopen(file, "r");
+    if (!fp) {
+        perror(file);
+        free(file);
+        return NULL;
+    }
+    while (fgets(s, sizeof(s), fp)) {
+        char *p =3D strtok(s, "=3D");
+        if (!p)
+            continue;
+        next->key =3D malloc(strlen(p) + 1);
+        if (!next->key) {
+            perror("next->key");
+            free(file);
+            FreeUevent(uevent);
+            return NULL;
+        }
+        strcpy(next->key, p);
+
+        p =3D strtok(NULL, "\n");
+        if (!p) {
+            xf86Msg(X_ERROR, "Error on uevent information\n");
+            fclose(fp);
+            free(file);
+            FreeUevent(uevent);
+            return NULL;
+        }
+        next->value =3D malloc(strlen(p) + 1);
+        if (!next->value) {
+            perror("next->value");
+            free(file);
+            FreeUevent(uevent);
+            return NULL;
+        }
+        strcpy(next->value, p);
+
+        next->next =3D calloc(1, sizeof(*next));
+        if (!next->next) {
+            perror("next->next");
+            free(file);
+            FreeUevent(uevent);
+            return NULL;
+        }
+        next =3D next->next;
+    }
+    fclose(fp);
+    free(file);
+
+    return uevent;
+}
+
+static struct SysfsNames *FindDevice(char *name)
+{
+    char                     dname[256];
+    char                     *input =3D "rc";
+    static struct SysfsNames *names, *cur;
+    /*
+     * Get event sysfs node
+     */
+    snprintf(dname, sizeof(dname), "/sys/class/rc/");
+
+    names =3D SeekSysfsDir(dname, input);
+    if (!names)
+        return NULL;
+
+    if (name) {
+        static struct SysfsNames *tmp;
+        char *p, *n;
+        int found =3D 0;
+
+        n =3D malloc(strlen(name) + 2);
+        strcpy(n, name);
+        strcat(n,"/");
+        for (cur =3D names; cur->next; cur =3D cur->next) {
+            if (cur->name) {
+                p =3D cur->name + strlen(dname);
+                if (p && !strcmp(p, n)) {
+                    found =3D 1;
+                    break;
+                }
+            }
+        }
+        free(n);
+        if (!found) {
+            FreeNames(names);
+            xf86Msg(X_ERROR, "Not found device %s\n", name);
+            return NULL;
+        }
+        tmp =3D calloc(sizeof(*names), 1);
+        tmp->name =3D cur->name;
+        cur->name =3D NULL;
+        FreeNames(names);
+        return tmp;
+    }
+
+    return names;
+}
+
+static int GetAttribs(struct RCDevice *RCDev, char *SysfsName)
+{
+    struct UEvents           *uevent;
+    char                     *input =3D "input", *event =3D "event";
+    char                     *DEV =3D "/dev/";
+    static struct SysfsNames *InputNames, *event_names;
+
+    /* Clean the attributes */
+    memset(RCDev, 0, sizeof(*RCDev));
+
+    RCDev->SysfsName =3D SysfsName;
+
+    InputNames =3D SeekSysfsDir(RCDev->SysfsName, input);
+    if (!InputNames)
+        return EINVAL;
+    if (InputNames->next->next) {
+        xf86Msg(X_ERROR, "Found more than one input interface."
+                "This is currently unsupported\n");
+        return EINVAL;
+    }
+
+    event_names =3D SeekSysfsDir(InputNames->name, event);
+    FreeNames(InputNames);
+    if (!event_names) {
+        FreeNames(event_names);
+        return EINVAL;
+    }
+    if (event_names->next->next) {
+        FreeNames(event_names);
+        xf86Msg(X_ERROR, "Found more than one event interface."
+                "This is currently unsupported\n");
+        return EINVAL;
+    }
+
+    uevent =3D ReadSysfsUevents(event_names->name);
+    FreeNames(event_names);
+
+    if (!uevent)
+        return EINVAL;
+
+    while (uevent->next) {
+        if (!strcmp(uevent->key, "DEVNAME")) {
+            RCDev->InputName =3D malloc(strlen(uevent->value) + strlen=
(DEV) + 1);
+            strcpy(RCDev->InputName, DEV);
+            strcat(RCDev->InputName, uevent->value);
+            break;
+        }
+        uevent =3D uevent->next;
+    }
+    FreeUevent(uevent);
+
+    if (!RCDev->InputName) {
+        xf86Msg(X_ERROR, "Input device name not found.\n");
+        return EINVAL;
+    }
+
+    return 0;
+}
+
+RCDeviceListPtr GetRCInputDevices(int *num)
+{
+    struct RCDevice          RCDev;
+    static struct SysfsNames *names, *cur;
+    RCDeviceListPtr          RCDevList;
+    int                      n =3D 0;
+
+    *num =3D 0;
+
+    names =3D FindDevice(NULL);
+    if (!names)
+        return NULL;
+    for (cur =3D names; cur->next; cur =3D cur->next)
+        if (cur->name)
+            n++;
+
+    RCDevList =3D malloc(n * sizeof(RCDeviceList));
+    if (!RCDevList)
+        goto error;
+
+    *num =3D n;
+
+    n =3D 0;
+    for (cur =3D names; cur->next; cur =3D cur->next) {
+        if (cur->name) {
+            if (GetAttribs(&RCDev, cur->name)) {
+                free (RCDevList);
+                return NULL;
+            }
+            xf86Msg(X_INFO, "Found %s (%s)\n",
+                    RCDev.SysfsName, RCDev.InputName);
+
+            strncpy(RCDevList[n].SysfsName, RCDev.SysfsName,
+                    sizeof(RCDevList[n].SysfsName) - 1);
+	    RCDevList[n].SysfsName[sizeof(RCDevList[n].SysfsName) - 1] =3D '\=
0';
+            strncpy(RCDevList[n].InputName, RCDev.InputName,
+                    sizeof(RCDevList[n].InputName) - 1);
+	    RCDevList[n].InputName[sizeof(RCDevList[n].InputName) - 1] =3D '\=
0';
+            n++;
+        }
+    }
+
+error:
+    FreeNames(names);
+
+    return RCDevList;
+}
diff --git a/src/Makefile.am b/src/Makefile.am
index a5c89ac..a42fe35 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -36,5 +36,6 @@ AM_CPPFLAGS =3D-I$(top_srcdir)/include
                                @DRIVER_NAME@.h \
                                emuMB.c \
                                emuWheel.c \
-                               draglock.c
+                               draglock.c \
+                               GetRCInputs.c
=20
diff --git a/src/Makefile.in b/src/Makefile.in
index 3d6195d..1299c58 100644
--- a/src/Makefile.in
+++ b/src/Makefile.in
@@ -95,7 +95,7 @@ am__installdirs =3D "$(DESTDIR)$(@DRIVER_NAME@_drv_la=
dir)"
 LTLIBRARIES =3D $(@DRIVER_NAME@_drv_la_LTLIBRARIES)
 @DRIVER_NAME@_drv_la_LIBADD =3D
 am_@DRIVER_NAME@_drv_la_OBJECTS =3D @DRIVER_NAME@.lo emuMB.lo \
-	emuWheel.lo draglock.lo
+	emuWheel.lo draglock.lo GetRCInputs.lo
 @DRIVER_NAME@_drv_la_OBJECTS =3D $(am_@DRIVER_NAME@_drv_la_OBJECTS)
 AM_V_lt =3D $(am__v_lt_$(V))
 am__v_lt_ =3D $(am__v_lt_$(AM_DEFAULT_VERBOSITY))
@@ -281,7 +281,8 @@ AM_CPPFLAGS =3D -I$(top_srcdir)/include
                                @DRIVER_NAME@.h \
                                emuMB.c \
                                emuWheel.c \
-                               draglock.c
+                               draglock.c \
+                               GetRCInputs.c
=20
 all: all-am
=20
diff --git a/src/evdev.c b/src/evdev.c
index 512e957..7a0af1c 100644
--- a/src/evdev.c
+++ b/src/evdev.c
@@ -296,6 +296,575 @@ EvdevQueueKbdEvent(InputInfoPtr pInfo, struct inp=
ut_event *ev, int value)
     pEvdev->num_queue++;
 }
=20
+/*
+ * Those are new keycodes added for 2.6.38 and used by some Remote Con=
trollers
+ */
+#ifndef KEY_10CHANNELSUP
+#define KEY_10CHANNELSUP        0x1b8   /* 10 channels up (10+) */
+#define KEY_10CHANNELSDOWN      0x1b9   /* 10 channels down (10-) */
+#endif
+
+int rc_keymap[] =3D {
+	[KEY_RESERVED] =3D KEY_RESERVED,                    /* not assigned *=
/
+	[KEY_ESC] =3D KEY_ESC,
+	[KEY_1] =3D KEY_1,
+	[KEY_2] =3D KEY_2,
+	[KEY_3] =3D KEY_3,
+	[KEY_4] =3D KEY_4,
+	[KEY_5] =3D KEY_5,
+	[KEY_6] =3D KEY_6,
+	[KEY_7] =3D KEY_7,
+	[KEY_8] =3D KEY_8,
+	[KEY_9] =3D KEY_9,
+	[KEY_0] =3D KEY_0,
+	[KEY_MINUS] =3D KEY_MINUS,
+	[KEY_EQUAL] =3D KEY_EQUAL,
+	[KEY_BACKSPACE] =3D KEY_BACKSPACE,
+	[KEY_TAB] =3D KEY_TAB,
+	[KEY_Q] =3D KEY_Q,
+	[KEY_W] =3D KEY_W,
+	[KEY_E] =3D KEY_E,
+	[KEY_R] =3D KEY_R,
+	[KEY_T] =3D KEY_T,
+	[KEY_Y] =3D KEY_Y,
+	[KEY_U] =3D KEY_U,
+	[KEY_I] =3D KEY_I,
+	[KEY_O] =3D KEY_O,
+	[KEY_P] =3D KEY_P,
+	[KEY_LEFTBRACE] =3D KEY_LEFTBRACE,
+	[KEY_RIGHTBRACE] =3D KEY_RIGHTBRACE,
+	[KEY_ENTER] =3D KEY_ENTER,
+	[KEY_LEFTCTRL] =3D KEY_LEFTCTRL,
+	[KEY_A] =3D KEY_A,
+	[KEY_S] =3D KEY_S,
+	[KEY_D] =3D KEY_D,
+	[KEY_F] =3D KEY_F,
+	[KEY_G] =3D KEY_G,
+	[KEY_H] =3D KEY_H,
+	[KEY_J] =3D KEY_J,
+	[KEY_K] =3D KEY_K,
+	[KEY_L] =3D KEY_L,
+	[KEY_SEMICOLON] =3D KEY_SEMICOLON,
+	[KEY_APOSTROPHE] =3D KEY_APOSTROPHE,
+	[KEY_GRAVE] =3D KEY_GRAVE,
+	[KEY_LEFTSHIFT] =3D KEY_LEFTSHIFT,
+	[KEY_BACKSLASH] =3D KEY_BACKSLASH,
+	[KEY_Z] =3D KEY_Z,
+	[KEY_X] =3D KEY_X,
+	[KEY_C] =3D KEY_C,
+	[KEY_V] =3D KEY_V,
+	[KEY_B] =3D KEY_B,
+	[KEY_N] =3D KEY_N,
+	[KEY_M] =3D KEY_M,
+	[KEY_COMMA] =3D KEY_COMMA,
+	[KEY_DOT] =3D KEY_DOT,
+	[KEY_SLASH] =3D KEY_SLASH,
+	[KEY_RIGHTSHIFT] =3D KEY_RIGHTSHIFT,
+	[KEY_KPASTERISK] =3D KEY_KPASTERISK,
+	[KEY_LEFTALT] =3D KEY_LEFTALT,
+	[KEY_SPACE] =3D KEY_SPACE,
+	[KEY_CAPSLOCK] =3D KEY_CAPSLOCK,
+	[KEY_F1] =3D KEY_F1,
+	[KEY_F2] =3D KEY_F2,
+	[KEY_F3] =3D KEY_F3,
+	[KEY_F4] =3D KEY_F4,
+	[KEY_F5] =3D KEY_F5,
+	[KEY_F6] =3D KEY_F6,
+	[KEY_F7] =3D KEY_F7,
+	[KEY_F8] =3D KEY_F8,
+	[KEY_F9] =3D KEY_F9,
+	[KEY_F10] =3D KEY_F10,
+	[KEY_NUMLOCK] =3D KEY_NUMLOCK,
+	[KEY_SCROLLLOCK] =3D KEY_RESERVED,                  /* not assigned *=
/
+	[KEY_KP7] =3D KEY_RESERVED,                         /* not assigned *=
/
+	[KEY_KP8] =3D KEY_RESERVED,                         /* not assigned *=
/
+	[KEY_KP9] =3D KEY_RESERVED,                         /* not assigned *=
/
+	[KEY_KPMINUS] =3D KEY_KPMINUS,
+	[KEY_KP4] =3D KEY_RESERVED,                         /* not assigned *=
/
+	[KEY_KP5] =3D KEY_RESERVED,                         /* not assigned *=
/
+	[KEY_KP6] =3D KEY_RESERVED,                         /* not assigned *=
/
+	[KEY_KPPLUS] =3D KEY_KPPLUS,
+	[KEY_KP1] =3D KEY_RESERVED,                         /* not assigned *=
/
+	[KEY_KP2] =3D KEY_RESERVED,                         /* not assigned *=
/
+	[KEY_KP3] =3D KEY_RESERVED,                         /* not assigned *=
/
+	[KEY_KP0] =3D KEY_RESERVED,                         /* not assigned *=
/
+	[KEY_KPDOT] =3D KEY_RESERVED,                       /* not assigned *=
/
+	[84] =3D KEY_RESERVED,                              /* not defined on=
 linux/input.h yet */
+	[KEY_ZENKAKUHANKAKU] =3D KEY_RESERVED,              /* not assigned *=
/
+	[KEY_102ND] =3D KEY_RESERVED,                       /* not assigned *=
/
+	[KEY_F11] =3D KEY_F11,
+	[KEY_F12] =3D KEY_F12,
+	[KEY_RO] =3D KEY_RESERVED,                          /* not assigned *=
/
+	[KEY_KATAKANA] =3D KEY_RESERVED,                    /* not assigned *=
/
+	[KEY_HIRAGANA] =3D KEY_RESERVED,                    /* not assigned *=
/
+	[KEY_HENKAN] =3D KEY_RESERVED,                      /* not assigned *=
/
+	[KEY_KATAKANAHIRAGANA] =3D KEY_RESERVED,            /* not assigned *=
/
+	[KEY_MUHENKAN] =3D KEY_RESERVED,                    /* not assigned *=
/
+	[KEY_KPJPCOMMA] =3D KEY_RESERVED,                   /* not assigned *=
/
+	[KEY_KPENTER] =3D KEY_RESERVED,                     /* not assigned *=
/
+	[KEY_RIGHTCTRL] =3D KEY_RESERVED,                   /* not assigned *=
/
+	[KEY_KPSLASH] =3D KEY_RESERVED,                     /* not assigned *=
/
+	[KEY_SYSRQ] =3D KEY_RESERVED,                       /* not assigned *=
/
+	[KEY_RIGHTALT] =3D KEY_RESERVED,                    /* not assigned *=
/
+	[KEY_LINEFEED] =3D KEY_RESERVED,                    /* not assigned *=
/
+	[KEY_HOME] =3D KEY_HOME,
+	[KEY_UP] =3D KEY_UP,
+	[KEY_PAGEUP] =3D KEY_PAGEUP,
+	[KEY_LEFT] =3D KEY_LEFT,
+	[KEY_RIGHT] =3D KEY_RIGHT,
+	[KEY_END] =3D KEY_END,
+	[KEY_DOWN] =3D KEY_DOWN,
+	[KEY_PAGEDOWN] =3D KEY_PAGEDOWN,
+	[KEY_INSERT] =3D KEY_INSERT,
+	[KEY_DELETE] =3D KEY_DELETE,
+	[KEY_MACRO] =3D KEY_MACRO,
+	[KEY_MUTE] =3D KEY_MUTE,
+	[KEY_VOLUMEDOWN] =3D KEY_VOLUMEDOWN,
+	[KEY_VOLUMEUP] =3D KEY_VOLUMEUP,
+	[KEY_POWER] =3D KEY_POWER,
+	[KEY_KPEQUAL] =3D KEY_RESERVED,                     /* not assigned *=
/
+	[KEY_KPPLUSMINUS] =3D KEY_KPPLUSMINUS,
+	[KEY_PAUSE] =3D KEY_PAUSE,
+	[KEY_SCALE] =3D KEY_RESERVED,                       /* not assigned *=
/
+	[KEY_KPCOMMA] =3D KEY_RESERVED,                     /* not assigned *=
/
+	[KEY_HANGEUL] =3D KEY_RESERVED,                     /* not assigned *=
/
+	[KEY_HANJA] =3D KEY_RESERVED,                       /* not assigned *=
/
+	[KEY_YEN] =3D KEY_RESERVED,                         /* not assigned *=
/
+	[KEY_LEFTMETA] =3D KEY_RESERVED,                    /* not assigned *=
/
+	[KEY_RIGHTMETA] =3D KEY_RESERVED,                   /* not assigned *=
/
+	[KEY_COMPOSE] =3D KEY_RESERVED,                     /* not assigned *=
/
+	[KEY_STOP] =3D KEY_STOP,
+	[KEY_AGAIN] =3D KEY_AGAIN,
+	[KEY_PROPS] =3D KEY_PROPS,
+	[KEY_UNDO] =3D KEY_UNDO,
+	[KEY_FRONT] =3D KEY_FRONT,
+	[KEY_COPY] =3D KEY_RESERVED,                        /* not assigned *=
/
+	[KEY_OPEN] =3D KEY_OPEN,
+	[KEY_PASTE] =3D KEY_RESERVED,                       /* not assigned *=
/
+	[KEY_FIND] =3D KEY_RESERVED,                        /* not assigned *=
/
+	[KEY_CUT] =3D KEY_RESERVED,                         /* not assigned *=
/
+	[KEY_HELP] =3D KEY_HELP,
+	[KEY_MENU] =3D KEY_MENU,
+	[KEY_CALC] =3D KEY_RESERVED,                        /* not assigned *=
/
+	[KEY_SETUP] =3D KEY_SETUP,
+	[KEY_SLEEP] =3D KEY_SLEEP,
+	[KEY_WAKEUP] =3D KEY_RESERVED,                      /* not assigned *=
/
+	[KEY_FILE] =3D KEY_RESERVED,                        /* not assigned *=
/
+	[KEY_SENDFILE] =3D KEY_RESERVED,                    /* not assigned *=
/
+	[KEY_DELETEFILE] =3D KEY_RESERVED,                  /* not assigned *=
/
+	[KEY_XFER] =3D KEY_RESERVED,                        /* not assigned *=
/
+	[KEY_PROG1] =3D KEY_PROG1,
+	[KEY_PROG2] =3D KEY_PROG2,
+	[KEY_WWW] =3D KEY_WWW,
+	[KEY_MSDOS] =3D KEY_RESERVED,                       /* not assigned *=
/
+	[KEY_SCREENLOCK] =3D KEY_RESERVED,                  /* not assigned *=
/
+	[KEY_DIRECTION] =3D KEY_RESERVED,                   /* not assigned *=
/
+	[KEY_CYCLEWINDOWS] =3D KEY_CYCLEWINDOWS,
+	[KEY_MAIL] =3D KEY_MAIL,
+	[KEY_BOOKMARKS] =3D KEY_BOOKMARKS,
+	[KEY_COMPUTER] =3D KEY_RESERVED,                    /* not assigned *=
/
+	[KEY_BACK] =3D KEY_BACK,
+	[KEY_FORWARD] =3D KEY_FORWARD,
+	[KEY_CLOSECD] =3D KEY_CLOSECD,
+	[KEY_EJECTCD] =3D KEY_EJECTCD,
+	[KEY_EJECTCLOSECD] =3D KEY_EJECTCLOSECD,
+	[KEY_NEXTSONG] =3D KEY_NEXTSONG,
+	[KEY_PLAYPAUSE] =3D KEY_PLAYPAUSE,
+	[KEY_PREVIOUSSONG] =3D KEY_PREVIOUSSONG,
+	[KEY_STOPCD] =3D KEY_STOPCD,
+	[KEY_RECORD] =3D KEY_RECORD,
+	[KEY_REWIND] =3D KEY_REWIND,
+	[KEY_PHONE] =3D KEY_PHONE,
+	[KEY_ISO] =3D KEY_RESERVED,                         /* not assigned *=
/
+	[KEY_CONFIG] =3D KEY_CONFIG,
+	[KEY_HOMEPAGE] =3D KEY_HOMEPAGE,
+	[KEY_REFRESH] =3D KEY_REFRESH,
+	[KEY_EXIT] =3D KEY_EXIT,
+	[KEY_MOVE] =3D KEY_RESERVED,                        /* not assigned *=
/
+	[KEY_EDIT] =3D KEY_EDIT,
+	[KEY_SCROLLUP] =3D KEY_RESERVED,                    /* not assigned *=
/
+	[KEY_SCROLLDOWN] =3D KEY_RESERVED,                  /* not assigned *=
/
+	[KEY_KPLEFTPAREN] =3D KEY_RESERVED,                 /* not assigned *=
/
+	[KEY_KPRIGHTPAREN] =3D KEY_RESERVED,                /* not assigned *=
/
+	[KEY_NEW] =3D KEY_NEW,
+	[KEY_REDO] =3D KEY_RESERVED,                        /* not assigned *=
/
+	[KEY_F13] =3D KEY_F13,
+	[KEY_F14] =3D KEY_F14,
+	[KEY_F15] =3D KEY_F15,
+	[KEY_F16] =3D KEY_F16,
+	[KEY_F17] =3D KEY_F17,
+	[KEY_F18] =3D KEY_F18,
+	[KEY_F19] =3D KEY_F19,
+	[KEY_F20] =3D KEY_RESERVED,                         /* not assigned *=
/
+	[KEY_F21] =3D KEY_F21,
+	[KEY_F22] =3D KEY_F22,
+	[KEY_F23] =3D KEY_F23,
+	[KEY_F24] =3D KEY_F24,
+	[195] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[196] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[197] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[198] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[199] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[KEY_PLAYCD] =3D KEY_PLAYCD,
+	[KEY_PAUSECD] =3D KEY_PAUSECD,
+	[KEY_PROG3] =3D KEY_PROG3,
+	[KEY_PROG4] =3D KEY_RESERVED,                       /* not assigned *=
/
+	[KEY_DASHBOARD] =3D KEY_RESERVED,                   /* not assigned *=
/
+	[KEY_SUSPEND] =3D KEY_SUSPEND,
+	[KEY_CLOSE] =3D KEY_CLOSE,
+	[KEY_PLAY] =3D KEY_PLAY,
+	[KEY_FASTFORWARD] =3D KEY_FASTFORWARD,
+	[KEY_BASSBOOST] =3D KEY_RESERVED,                   /* not assigned *=
/
+	[KEY_PRINT] =3D KEY_PRINT,
+	[KEY_HP] =3D KEY_RESERVED,                          /* not assigned *=
/
+	[KEY_CAMERA] =3D KEY_CAMERA,
+	[KEY_SOUND] =3D KEY_SOUND,
+	[KEY_QUESTION] =3D KEY_RESERVED,                    /* not assigned *=
/
+	[KEY_EMAIL] =3D KEY_EMAIL,
+	[KEY_CHAT] =3D KEY_RESERVED,                        /* not assigned *=
/
+	[KEY_SEARCH] =3D KEY_SEARCH,
+	[KEY_CONNECT] =3D KEY_RESERVED,                     /* not assigned *=
/
+	[KEY_FINANCE] =3D KEY_RESERVED,                     /* not assigned *=
/
+	[KEY_SPORT] =3D KEY_RESERVED,                       /* not assigned *=
/
+	[KEY_SHOP] =3D KEY_RESERVED,                        /* not assigned *=
/
+	[KEY_ALTERASE] =3D KEY_RESERVED,                    /* not assigned *=
/
+	[KEY_CANCEL] =3D KEY_CANCEL,
+	[KEY_BRIGHTNESSDOWN] =3D KEY_BRIGHTNESSDOWN,
+	[KEY_BRIGHTNESSUP] =3D KEY_BRIGHTNESSUP,
+	[KEY_MEDIA] =3D KEY_MEDIA,
+	[KEY_SWITCHVIDEOMODE] =3D KEY_SWITCHVIDEOMODE,
+	[KEY_KBDILLUMTOGGLE] =3D KEY_RESERVED,              /* not assigned *=
/
+	[KEY_KBDILLUMDOWN] =3D KEY_RESERVED,                /* not assigned *=
/
+	[KEY_KBDILLUMUP] =3D KEY_RESERVED,                  /* not assigned *=
/
+	[KEY_SEND] =3D KEY_RESERVED,                        /* not assigned *=
/
+	[KEY_REPLY] =3D KEY_RESERVED,                       /* not assigned *=
/
+	[KEY_FORWARDMAIL] =3D KEY_RESERVED,                 /* not assigned *=
/
+	[KEY_SAVE] =3D KEY_SAVE,
+	[KEY_DOCUMENTS] =3D KEY_RESERVED,                   /* not assigned *=
/
+	[KEY_BATTERY] =3D KEY_RESERVED,                     /* not assigned *=
/
+	[KEY_BLUETOOTH] =3D KEY_RESERVED,                   /* not assigned *=
/
+	[KEY_WLAN] =3D KEY_RESERVED,                        /* not assigned *=
/
+	[KEY_UWB] =3D KEY_RESERVED,                         /* not assigned *=
/
+	[KEY_UNKNOWN] =3D KEY_UNKNOWN,
+	[KEY_VIDEO_NEXT] =3D KEY_RESERVED,                  /* not assigned *=
/
+	[KEY_VIDEO_PREV] =3D KEY_RESERVED,                  /* not assigned *=
/
+	[KEY_BRIGHTNESS_CYCLE] =3D KEY_RESERVED,            /* not assigned *=
/
+	[KEY_BRIGHTNESS_ZERO] =3D KEY_RESERVED,             /* not assigned *=
/
+	[KEY_DISPLAY_OFF] =3D KEY_RESERVED,                 /* not assigned *=
/
+	[KEY_WIMAX] =3D KEY_RESERVED,                       /* not assigned *=
/
+	[KEY_RFKILL] =3D KEY_RESERVED,                      /* not assigned *=
/
+	[248] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[249] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[250] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[251] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[252] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[253] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[254] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[255] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[256] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[257] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[258] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[259] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[260] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[261] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[262] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[263] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[264] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[265] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[266] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[267] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[268] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[269] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[270] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[271] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[272] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[273] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[274] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[275] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[276] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[277] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[278] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[279] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[280] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[281] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[282] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[283] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[284] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[285] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[286] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[287] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[288] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[289] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[290] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[291] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[292] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[293] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[294] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[295] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[296] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[297] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[298] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[299] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[300] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[301] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[302] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[303] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[304] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[305] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[306] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[307] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[308] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[309] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[310] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[311] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[312] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[313] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[314] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[315] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[316] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[317] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[318] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[319] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[320] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[321] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[322] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[323] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[324] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[325] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[326] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[327] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[328] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[329] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[330] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[331] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[332] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[333] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[334] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[335] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[336] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[337] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[338] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[339] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[340] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[341] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[342] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[343] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[344] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[345] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[346] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[347] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[348] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[349] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[350] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[351] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[KEY_OK] =3D 125,                                   /* KEY_LEFTMETA *=
/
+	[KEY_SELECT] =3D 153,                               /* KEY_DIRECTION =
*/
+	[KEY_GOTO] =3D 94,                                  /* KEY_MUHENKAN *=
/
+	[KEY_CLEAR] =3D 84,                                 /* currently unus=
ed */
+	[KEY_POWER2] =3D 135,                               /* KEY_PASTE */
+	[KEY_OPTION] =3D 126,                               /* KEY_RIGHTMETA =
*/
+	[KEY_INFO] =3D 96,                                  /* KEY_KPENTER */
+	[KEY_TIME] =3D 180,                                 /* KEY_KPRIGHTPAR=
EN */
+	[KEY_VENDOR] =3D KEY_RESERVED,                      /* not assigned *=
/
+	[KEY_ARCHIVE] =3D KEY_RESERVED,                     /* not assigned *=
/
+	[KEY_PROGRAM] =3D KEY_RESERVED,                     /* not assigned *=
/
+	[KEY_CHANNEL] =3D 81,                               /* KEY_KP3 */
+	[KEY_FAVORITES] =3D 91,                             /* KEY_HIRAGANA *=
/
+	[KEY_EPG] =3D 90,                                   /* KEY_KATAKANA *=
/
+	[KEY_PVR] =3D 137,                                  /* KEY_CUT */
+	[KEY_MHP] =3D 120,                                  /* KEY_SCALE */
+	[KEY_LANGUAGE] =3D 98,                              /* KEY_KPSLASH */
+	[KEY_TITLE] =3D 182,                                /* KEY_REDO */
+	[KEY_SUBTITLE] =3D 178,                             /* KEY_SCROLLDOWN=
 */
+	[KEY_ANGLE] =3D 73,                                 /* KEY_KP9 */
+	[KEY_ZOOM] =3D 203,                                 /* KEY_PROG4 */
+	[KEY_MODE] =3D 121,                                 /* KEY_KPCOMMA */
+	[KEY_KEYBOARD] =3D 97,                              /* KEY_RIGHTCTRL =
*/
+	[KEY_SCREEN] =3D 151,                               /* KEY_MSDOS */
+	[KEY_PC] =3D 127,                                   /* KEY_COMPOSE */
+	[KEY_TV] =3D 195,                                   /* currently unus=
ed */
+	[KEY_TV2] =3D 196,                                  /* currently unus=
ed */
+	[KEY_VCR] =3D 197,                                  /* currently unus=
ed */
+	[KEY_VCR2] =3D KEY_RESERVED,                        /* not assigned *=
/
+	[KEY_SAT] =3D 147,                                  /* KEY_XFER */
+	[KEY_SAT2] =3D KEY_RESERVED,                        /* not assigned *=
/
+	[KEY_CD] =3D 80,                                    /* KEY_KP2 */
+	[KEY_TAPE] =3D KEY_RESERVED,                        /* not assigned *=
/
+	[KEY_RADIO] =3D 140,                                /* KEY_CALC */
+	[KEY_TUNER] =3D 190,                                /* KEY_F20 */
+	[KEY_PLAYER] =3D 133,                               /* KEY_COPY */
+	[KEY_TEXT] =3D 179,                                 /* KEY_KPLEFTPARE=
N */
+	[KEY_DVD] =3D 86,                                   /* KEY_102ND */
+	[KEY_AUX] =3D 76,                                   /* KEY_KP5 */
+	[KEY_MP3] =3D 122,                                  /* KEY_HANGEUL */
+	[KEY_AUDIO] =3D 75,                                 /* KEY_KP4 */
+	[KEY_VIDEO] =3D 198,                                /* currently unus=
ed */
+	[KEY_DIRECTORY] =3D KEY_RESERVED,                   /* not assigned *=
/
+	[KEY_LIST] =3D 100,                                 /* KEY_RIGHTALT *=
/
+	[KEY_MEMO] =3D KEY_RESERVED,                        /* not assigned *=
/
+	[KEY_CALENDAR] =3D KEY_RESERVED,                    /* not assigned *=
/
+	[KEY_RED] =3D 143,                                  /* KEY_WAKEUP */
+	[KEY_GREEN] =3D 95,                                 /* KEY_KPJPCOMMA =
*/
+	[KEY_YELLOW] =3D 199,                               /* currently unus=
ed */
+	[KEY_BLUE] =3D 77,                                  /* KEY_KP6 */
+	[KEY_CHANNELUP] =3D 83,                             /* KEY_KPDOT */
+	[KEY_CHANNELDOWN] =3D 82,                           /* KEY_KP0 */
+	[KEY_FIRST] =3D 92,                                 /* KEY_HENKAN */
+	[KEY_LAST] =3D 99,                                  /* KEY_SYSRQ */
+	[KEY_AB] =3D 72,                                    /* KEY_KP8 */
+	[KEY_NEXT] =3D 123,                                 /* KEY_HANJA */
+	[KEY_RESTART] =3D 144,                              /* KEY_FILE */
+	[KEY_SLOW] =3D 170,                                 /* KEY_ISO */
+	[KEY_SHUFFLE] =3D 157,                              /* KEY_COMPUTER *=
/
+	[KEY_BREAK] =3D 79,                                 /* KEY_KP1 */
+	[KEY_PREVIOUS] =3D 136,                             /* KEY_FIND */
+	[KEY_DIGITS] =3D 85,                                /* KEY_ZENKAKUHAN=
KAKU */
+	[KEY_TEEN] =3D KEY_RESERVED,                        /* not assigned *=
/
+	[KEY_TWEN] =3D KEY_RESERVED,                        /* not assigned *=
/
+	[KEY_VIDEOPHONE] =3D KEY_RESERVED,                  /* not assigned *=
/
+	[KEY_GAMES] =3D KEY_RESERVED,                       /* not assigned *=
/
+	[KEY_ZOOMIN] =3D 204,                               /* KEY_DASHBOARD =
*/
+	[KEY_ZOOMOUT] =3D 209,                              /* KEY_BASSBOOST =
*/
+	[KEY_ZOOMRESET] =3D KEY_RESERVED,                   /* not assigned *=
/
+	[KEY_WORDPROCESSOR] =3D KEY_RESERVED,               /* not assigned *=
/
+	[KEY_EDITOR] =3D KEY_RESERVED,                      /* not assigned *=
/
+	[KEY_SPREADSHEET] =3D KEY_RESERVED,                 /* not assigned *=
/
+	[KEY_GRAPHICSEDITOR] =3D KEY_RESERVED,              /* not assigned *=
/
+	[KEY_PRESENTATION] =3D KEY_RESERVED,                /* not assigned *=
/
+	[KEY_DATABASE] =3D KEY_RESERVED,                    /* not assigned *=
/
+	[KEY_NEWS] =3D KEY_RESERVED,                        /* not assigned *=
/
+	[KEY_VOICEMAIL] =3D KEY_RESERVED,                   /* not assigned *=
/
+	[KEY_ADDRESSBOOK] =3D KEY_RESERVED,                 /* not assigned *=
/
+	[KEY_MESSENGER] =3D KEY_RESERVED,                   /* not assigned *=
/
+	[KEY_DISPLAYTOGGLE] =3D KEY_RESERVED,               /* not assigned *=
/
+	[KEY_SPELLCHECK] =3D KEY_RESERVED,                  /* not assigned *=
/
+	[KEY_LOGOFF] =3D KEY_RESERVED,                      /* not assigned *=
/
+	[KEY_DOLLAR] =3D KEY_RESERVED,                      /* not assigned *=
/
+	[KEY_EURO] =3D KEY_RESERVED,                        /* not assigned *=
/
+	[KEY_FRAMEBACK] =3D KEY_RESERVED,                   /* not assigned *=
/
+	[KEY_FRAMEFORWARD] =3D KEY_RESERVED,                /* not assigned *=
/
+	[KEY_CONTEXT_MENU] =3D KEY_RESERVED,                /* not assigned *=
/
+	[KEY_MEDIA_REPEAT] =3D 117,                         /* KEY_KPEQUAL */
+	[KEY_10CHANNELSUP] =3D 71,                          /* KEY_KP7 */
+	[KEY_10CHANNELSDOWN] =3D 70,                        /* KEY_SCROLLLOCK=
 */
+	[442] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[443] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[444] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[445] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[446] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[447] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[KEY_DEL_EOL] =3D KEY_RESERVED,                     /* not assigned *=
/
+	[KEY_DEL_EOS] =3D KEY_RESERVED,                     /* not assigned *=
/
+	[KEY_INS_LINE] =3D KEY_RESERVED,                    /* not assigned *=
/
+	[KEY_DEL_LINE] =3D KEY_RESERVED,                    /* not assigned *=
/
+	[452] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[453] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[454] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[455] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[456] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[457] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[458] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[459] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[460] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[461] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[462] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[463] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[KEY_FN] =3D 93,                                    /* KEY_KATAKANAHI=
RAGANA */
+	[KEY_FN_ESC] =3D KEY_RESERVED,                      /* not assigned *=
/
+	[KEY_FN_F1] =3D KEY_RESERVED,                       /* not assigned *=
/
+	[KEY_FN_F2] =3D KEY_RESERVED,                       /* not assigned *=
/
+	[KEY_FN_F3] =3D KEY_RESERVED,                       /* not assigned *=
/
+	[KEY_FN_F4] =3D KEY_RESERVED,                       /* not assigned *=
/
+	[KEY_FN_F5] =3D KEY_RESERVED,                       /* not assigned *=
/
+	[KEY_FN_F6] =3D KEY_RESERVED,                       /* not assigned *=
/
+	[KEY_FN_F7] =3D KEY_RESERVED,                       /* not assigned *=
/
+	[KEY_FN_F8] =3D KEY_RESERVED,                       /* not assigned *=
/
+	[KEY_FN_F9] =3D KEY_RESERVED,                       /* not assigned *=
/
+	[KEY_FN_F10] =3D KEY_RESERVED,                      /* not assigned *=
/
+	[KEY_FN_F11] =3D KEY_RESERVED,                      /* not assigned *=
/
+	[KEY_FN_F12] =3D KEY_RESERVED,                      /* not assigned *=
/
+	[KEY_FN_1] =3D KEY_RESERVED,                        /* not assigned *=
/
+	[KEY_FN_2] =3D KEY_RESERVED,                        /* not assigned *=
/
+	[KEY_FN_D] =3D KEY_RESERVED,                        /* not assigned *=
/
+	[KEY_FN_E] =3D KEY_RESERVED,                        /* not assigned *=
/
+	[KEY_FN_F] =3D KEY_RESERVED,                        /* not assigned *=
/
+	[KEY_FN_S] =3D KEY_RESERVED,                        /* not assigned *=
/
+	[KEY_FN_B] =3D KEY_RESERVED,                        /* not assigned *=
/
+	[485] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[486] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[487] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[488] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[489] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[490] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[491] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[492] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[493] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[494] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[495] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[496] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[KEY_BRL_DOT1] =3D KEY_RESERVED,                    /* not assigned *=
/
+	[KEY_BRL_DOT2] =3D KEY_RESERVED,                    /* not assigned *=
/
+	[KEY_BRL_DOT3] =3D KEY_RESERVED,                    /* not assigned *=
/
+	[KEY_BRL_DOT4] =3D KEY_RESERVED,                    /* not assigned *=
/
+	[KEY_BRL_DOT5] =3D KEY_RESERVED,                    /* not assigned *=
/
+	[KEY_BRL_DOT6] =3D KEY_RESERVED,                    /* not assigned *=
/
+	[KEY_BRL_DOT7] =3D KEY_RESERVED,                    /* not assigned *=
/
+	[KEY_BRL_DOT8] =3D KEY_RESERVED,                    /* not assigned *=
/
+	[KEY_BRL_DOT9] =3D KEY_RESERVED,                    /* not assigned *=
/
+	[KEY_BRL_DOT10] =3D KEY_RESERVED,                   /* not assigned *=
/
+	[507] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[508] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[509] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[510] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[511] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[KEY_NUMERIC_0] =3D 11,                             /* KEY_0 */
+	[KEY_NUMERIC_1] =3D 2,                              /* KEY_1 */
+	[KEY_NUMERIC_2] =3D 3,                              /* KEY_2 */
+	[KEY_NUMERIC_3] =3D 4,                              /* KEY_3 */
+	[KEY_NUMERIC_4] =3D 5,                              /* KEY_4 */
+	[KEY_NUMERIC_5] =3D 6,                              /* KEY_5 */
+	[KEY_NUMERIC_6] =3D 7,                              /* KEY_6 */
+	[KEY_NUMERIC_7] =3D 8,                              /* KEY_7 */
+	[KEY_NUMERIC_8] =3D 9,                              /* KEY_8 */
+	[KEY_NUMERIC_9] =3D 10,                             /* KEY_9 */
+	[KEY_NUMERIC_STAR] =3D 55,                          /* KEY_KPASTERISK=
 */
+	[KEY_NUMERIC_POUND] =3D 124,                        /* KEY_YEN */
+	[524] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[525] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[526] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[527] =3D KEY_RESERVED,                             /* not defined on=
 linux/input.h yet */
+	[KEY_CAMERA_FOCUS] =3D KEY_RESERVED,                /* not assigned *=
/
+	[KEY_WPS_BUTTON] =3D KEY_RESERVED,                  /* not assigned *=
/
+	[530] =3D KEY_RESERVED,                             /* KEY_TOUCHPAD_T=
OGGLE - not assigned */
+	[531] =3D KEY_RESERVED,                             /* KEY_TOUCHPAD_O=
N - not assigned */
+	[531] =3D KEY_RESERVED,                             /* KEY_TOUCHPAD_O=
=46F - not assigned */
+};
+
+void
+EvdevQueueRCEvent(InputInfoPtr pInfo, struct input_event *ev, int valu=
e)
+{
+    int code;
+    EventQueuePtr pQueue;
+    EvdevPtr pEvdev =3D pInfo->private;
+
+    if (ev->code >=3D ArrayLength(rc_keymap))
+        code =3D KEY_RESERVED + MIN_KEYCODE;
+    else
+        code =3D rc_keymap[ev->code] + MIN_KEYCODE;
+
+    if (pEvdev->num_queue >=3D EVDEV_MAXQUEUE)
+    {
+        xf86Msg(X_NONE, "%s: dropping event due to full queue!\n", pIn=
fo->name);
+        return;
+    }
+
+    pQueue =3D &pEvdev->queue[pEvdev->num_queue];
+    pQueue->type =3D EV_QUEUE_KEY;
+    pQueue->key =3D code;
+    pQueue->val =3D value;
+    pEvdev->num_queue++;
+}
+
 void
 EvdevQueueButtonEvent(InputInfoPtr pInfo, int button, int value)
 {
@@ -468,6 +1037,8 @@ EvdevProcessButtonEvent(InputInfoPtr pInfo, struct=
 input_event *ev)
=20
     if (button)
         EvdevQueueButtonEvent(pInfo, button, value);
+    else if (pEvdev->flags & EVDEV_RC_EVENTS)
+        EvdevQueueRCEvent(pInfo, ev, value);
     else
         EvdevQueueKbdEvent(pInfo, ev, value);
 }
@@ -2012,6 +2583,8 @@ EvdevOpenDevice(InputInfoPtr pInfo)
 {
     EvdevPtr pEvdev =3D pInfo->private;
     char *device =3D (char*)pEvdev->device;
+    RCDeviceListPtr pRCDevList;
+    int NumDevices, i;
=20
     if (!device)
     {
@@ -2047,6 +2620,25 @@ EvdevOpenDevice(InputInfoPtr pInfo)
         return FALSE;
     }
=20
+    /* Check if the device is a remote controller */
+    pRCDevList =3D GetRCInputDevices(&NumDevices);
+    for (i =3D 0; i < NumDevices; i++) {
+        if (!strcmp(device, pRCDevList[i].InputName)) {
+             pEvdev->flags |=3D EVDEV_RC_EVENTS;
+             break;
+        }
+    }
+    if (pEvdev->flags & EVDEV_RC_EVENTS) {
+        xf86Msg(X_INFO, "%s: device '%s' is a Remote Controller\n",
+                pInfo->name, device);
+    } else {
+        xf86Msg(X_INFO, "%s: device '%s' IS NOT a Remote Controller\n"=
,
+                pInfo->name, device);
+    }
+
+    if (pRCDevList)
+        free(pRCDevList);
+
     return TRUE;
 }
=20
diff --git a/src/evdev.h b/src/evdev.h
index 4945140..b891992 100644
--- a/src/evdev.h
+++ b/src/evdev.h
@@ -71,6 +71,7 @@
 #define EVDEV_UNIGNORE_ABSOLUTE (1 << 9) /* explicitly unignore abs ax=
es */
 #define EVDEV_UNIGNORE_RELATIVE (1 << 10) /* explicitly unignore rel a=
xes */
 #define EVDEV_RELATIVE_MODE	(1 << 11) /* Force relative events for dev=
ices with absolute axes */
+#define EVDEV_RC_EVENTS         (1 << 12) /* Device is a remote contro=
ller */
=20
 #if GET_ABI_MAJOR(ABI_XINPUT_VERSION) >=3D 3
 #define HAVE_PROPERTIES 1
@@ -195,6 +196,11 @@ typedef struct {
     EventQueueRec           queue[EVDEV_MAXQUEUE];
 } EvdevRec, *EvdevPtr;
=20
+typedef struct {
+    char SysfsName[255];    /* Device sysfs node name */
+    char InputName[255];    /* Input device file name */
+} RCDeviceList, *RCDeviceListPtr;
+
 /* Event posting functions */
 void EvdevQueueKbdEvent(InputInfoPtr pInfo, struct input_event *ev, in=
t value);
 void EvdevQueueButtonEvent(InputInfoPtr pInfo, int button, int value);
@@ -224,6 +230,9 @@ BOOL EvdevWheelEmuFilterMotion(InputInfoPtr pInfo, =
struct input_event *pEv);
 void EvdevDragLockPreInit(InputInfoPtr pInfo);
 BOOL EvdevDragLockFilterEvent(InputInfoPtr pInfo, unsigned int button,=
 int value);
=20
+/* GetRCInputs code */
+RCDeviceListPtr GetRCInputDevices(int *num);
+
 #ifdef HAVE_PROPERTIES
 void EvdevMBEmuInitProperty(DeviceIntPtr);
 void EvdevWheelEmuInitProperty(DeviceIntPtr);
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
