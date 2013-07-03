From: Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: One USB mouse problem with runtime power management enabled
Date: Wed, 3 Jul 2013 10:43:25 +0800
Message-ID: <20130703024324.GA17349@nchen-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Jiri and Alan,

I have run below below at 3.5.7 kernel, but after checking upstream
kernel, it may also be existed.

1. evtest /dev/input/event1 &
2. Let mouse auto suspend, enable mouse as wakeup source, and let
the system enters suspend.
echo auto > /sys/bus/usb/devices/1-1/power/control

echo enabled > /sys/bus/platform/devices/2184000.usb/power/wakeup
echo enabled > /sys/bus/usb/devices/usb1/power/wakeup
echo enabled > /sys/bus/usb/devices/1-1/power/wakeup
echo enabled > /sys/bus/platform/devices/ci_hdrc.0/power/wakeup

sleep 3
echo mem > /sys/power/state

3. Resume system with USB mouse button.

4. Console output endless with below message
hub 1-0:1.0: port 1 nyet suspended
hub 1-0:1.0: usb_suspend_interface: status -16
usb usb1: usb_suspend_both: status -16

5. The reason for above message
After system goes to suspend, the roothub is RPM_SUSPENDED
At hub_events it will auto resume roothub, then auto suspend
roothub after system resumes. When it tries to auto suspend roothub,
it will print above message. But usbhid interface is resumed 
by system resume, so its can_submit is 1.

Unlike the USB Keyboard, the mouse doesn't have any event after system
resume, so it will not restart OUT/CTRL queues. So the USB mouse will
not do autoresume and autosuspend.

For hid keyboard, it has below message at its usb_hidinput_input_event
after system resume:
hid-generic 0003:413C:2105.0002: type:17, code:0, value:0
hid-generic 0003:413C:2105.0002: type:17, code:1, value:0
hid-generic 0003:413C:2105.0002: type:17, code:2, value:0
hid-generic 0003:413C:2105.0002: type:20, code:1, value:33
hid-generic 0003:413C:2105.0002: type:20, code:0, value:250

6. It will not affect evtest, but the USBHID mouse seems will not do
auto-resume/auto-suspend again even the mouse's button is pressed.
Then the USBHID has always been active (although it is RPM_SUSPENDED)

>From my point, this problem may need to be fixed:
1. At usbhid/input layer:
Since the usbhid device has auto suspended before system suspend, then,
it should still auto suspended after system resume.
2. At USB layer:
It can do auto resume and auto suspend USB device
after system resume to keep the usb device runtime pm status correct.

Thanks.

-- 

Best Regards,
Peter Chen

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
