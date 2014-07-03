From: Przemo Firszt <przemo@firszt.eu>
Subject: Re: [Linuxwacom-devel] [PATCH 06/15] Input - wacom: install
 LED/OLED sysfs files in the HID device instead of USB
Date: Thu, 03 Jul 2014 09:21:43 +0000
Message-ID: <20140703092143.Horde.pRrZTs1B-ZEo6Oax4ouKOw1@webmail.firszt.eu>
References: <1404163586-29582-1-git-send-email-benjamin.tissoires@redhat.com>
 <1404163586-29582-7-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; DelSp=Yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404163586-29582-7-git-send-email-benjamin.tissoires@redhat.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, linuxwacom-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org


Quoting Benjamin Tissoires <benjamin.tissoires@redhat.com>:

> Removes one more dependency over USB, but requires some changes in
> the user space to find the sysfs files correctly.
>
> This patch breaks the user space. However, the number of program
> accessing the LEDs is quite limited and we can easily patch them
> to handle the new HID behavior.
[..]
Hi Bejnamin,
If you get the green light to break the user space we might as well  
think about getting it in line with led/oled over bluetooth (intuos4  
wireless) or the other way around.

The biggest user of led/oled functionality is gnome and there are also  
a few small projects that would stop working after that change. I can  
fix i4oled project easily, i4oled-gui is based on gnome handling oleds.

Patching those 2 should be enough to fix gnome:
https://git.gnome.org/browse/gnome-settings-daemon/tree/plugins/wacom/gsd-wacom-led-helper.c
https://git.gnome.org/browse/gnome-settings-daemon/tree/plugins/wacom/gsd-wacom-oled-helper.c

Regards,
Przemo Firszt
