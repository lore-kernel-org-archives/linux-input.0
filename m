From: Amit Nagal <helloin.amit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: ring buffer size in hiddev and hidraw
Date: Sat, 15 Oct 2011 16:44:14 +0530
Message-ID: <CA+F9FsCEh57rVyQnrAYJG68V6QfxOuMXxYKF+te_Qi=Nbi48sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi ,

hiddev ring buffer size  ( HIDDEV_BUFFER_SIZE ) as defined in
driver/hid/usbhid/hiddev.c is 2048 bytes .

similarly hidraw ring buffer size (HIDRAW_BUFFER_SIZE) as defined in
include/linux/hidraw.h is 64 bytes .

i am presently using both hiddev and hidraw driver with a USB HID
device ( ipod ).


My queries are as follows :

1) How was it  calculated  that hiddev ring buffer size of 2048 bytes
is sufficient to handle
usb hid report traffic coming from  a usb high speed device exposing
HID interface  ?

Similarly how the value of  HIDRAW_BUFFER_SIZE was calculated  for a
USBHID high speed device ? .

While computing such ring buffer size values , what all factors/loads
should be taken into account ?


2) Are these current values of HIDDEV_BUFFER_SIZE  ,
HIDRAW_BUFFER_SIZE  optimum enough
to handle any USB HID high speed device present currently ?

3) What max latency ( in ms ?  or us ? ) application can have between
2 consecutive reads() over USBHID interface ,
so that these ring buffers donot overflow in any situations ?

4) i observed that the value of HIDDEV_BUFFER_SIZE was 64 bytes till
2.6.31 kernel ,
and in 2.6.32 kernel HIDDEV_BUFFER_SIZE  was increased  to 2048 bytes
to handle reports from full speed and high speed USB hid devices
with the patch at
http://kerneltrap.org/mailarchive/git-commits-head/2009/9/15/5178 .

Will these values needs to be increased again  in future  keeping in
view Superspeed usb3.0  ?

Thanx & Regards
Amit Nagal
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
