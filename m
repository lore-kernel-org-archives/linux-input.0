From: =?ISO-8859-1?Q?J=F8rn_Christensen?= <linux-input@mettle.dk>
Subject: Driver for Acer T230H
Date: Sun, 13 Dec 2009 16:28:10 +0100
Message-ID: <4B25080A.3070306@mettle.dk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070109060507020908080108"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cicero-fbr1.cybercity.dk ([212.242.40.5]:62760 "HELO
	cicero-fbr1.cybercity.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753766AbZLMQLy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Dec 2009 11:11:54 -0500
Received: from smtp1.cybercity.dk (smtp1.cybercity.dk [212.242.43.251])
	by cicero-fbr1.cybercity.dk (Postfix) with ESMTP id 459943D22B4
	for <linux-input@vger.kernel.org>; Sun, 13 Dec 2009 16:29:28 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: daniel.ritz@gmx.ch, Alex Custov <alex.custov@gmail.com>

This is a multi-part message in MIME format.
--------------070109060507020908080108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Pre-note:
I wrote this mail for the linux kernel development list, and realized,=20
once finished writing the mail, that linux-input would be a better place=20
to post this. I searched the archives and found a few mails that I=20
missed before starting to write this driver and mail. So I understand=20
that some work is already going on, and some might require changes to=20
the HID system?

Anyway... I hope my mail may still be of some help to the process. My=20
(proof of concept) driver is functional for the Acer T230H. I am=20
currently using it to my great amusement :-D


Hi all of you,

This mail is in regard to an Acer T230H touchscreen, and aimed to
  - Daniel Ritz, who is the maintainer of the usbtouchscreen kernel modul=
e
  - Alex Custov, whom's friend also have this screen
  - Linux kernel input list

You are all on the CC, because I hope that some of you can and will help=20
me finish the driver for this screen.

So... I got this screen, and in Linux it is recognized only as=20
/dev/hidraw0 and /dev/usb/hiddev0 devices. I really wanted to get it to=20
work, so I sat down and analyzed the output, and wrote a small program=20
as a proof-of-concept driver.

Once I got this working, I went to the kernel source of the=20
usbtouchscreen driver, and tried to expand it to include support for=20
this screen at kernel space - but failed. Ii could not get the driver to=20
properly register my screen - no matter what I did, it always ended up=20
as the hiddev and hidraw devices. (And kernel messages were not very=20
helpful).

Anyway... I have never hacked the kernel source before, and - due to=20
lack of time - I now give up, and hope some of you will take your time=20
to include my code in the driver.

I have attached my sample driver. It opens the hidraw device, reads=20
data, parses it, and passes it on to Xorg (via XTest). The parsing is=20
done in the decodeData()-function. The rest is done in mail(). I hope I=20
have written enough comments for my code to be readable by you.

What I hope you can do, is
  - Expand the usbtouchscreen driver to register the screen=20
(vendor:product id 0408:3000)
  - Copy the decodeData function and pass the raw data to it.
  - Send the parsed data to the kernel event interface - hopefully with=20
some sensible mappings of the axes.

To Alex: Until support is in the kernel, you should be able to use my=20
program get the screen up'n'running.

The screen supports two fingers touch. I have implemented the following=20
functionality:
  - One finger press: Left click'n'drag.
  - Two fingers press:
    - Center point of fingers are calculated.
    - Distance between fingers is calculated.
    - If one finger is released between center or distance has changed=20
over a certain threshold, a right click'n'drag is initiated.
    - If center point is moved beyond a threshold, scrolling mode is=20
initiated. Vertical and horizontal scroll is affected by the movement of=20
the center. Relative coordinates.
    - If distance is changed beyond a threshold, well mode is initiated.=20
Wheel is turned to the change of distance. Relative movement.
    - If both fingers are released before any mode is initiated, a right=20
click and release is performed.

The threshold is currently hardcoded into the program. I know this is=20
ugly - but again (due to my lack of knowledge on kernel programming), I=20
don't know how to make this a parameter that can be changed. (I expect=20
one need to make an interface, that HAL can connect to, and in the end,=20
someone need to make a nice gui program to change the settings... but I=20
know this is probably further than you want to go right now. I would be=20
glad, if you in kernel space, would make the necessary preparations for=20
it to be possible in the future.)

Note, that my sample program opens the file /dev/input/t230h, which I on=20
my system have set up to be a symlink to /dev/hidraw0. If you do not=20
want to do this just for testing the driver, just change the input file.

To Alex: I got a udev-rule, which you might find handy too:
   SUBSYSTEM=3D=3D"hidraw", ATTRS{manufacturer}=3D=3D"Acer",=20
ATTRS{product}=3D=3D"T230H", SYMLINK+=3D"input/t230h", GROUP=3D"plugdev"

I have attached the output from lsusb about the device - in case you=20
think it is useful.

I hope that one of you will take your time to include this into the=20
kernel driver. A big thanks to him or her :-) I will of course be happy=20
with what help I can offer - but I have not got much time to do it. The=20
screen is actually for my parents, and I will set it up for them when I=20
visit them in the Christmas holidays.

Best regards
J=F8rn


--------------070109060507020908080108
Content-Type: text/x-c++src;
 name="acer_driver.cpp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acer_driver.cpp"

/**
 * Proof-of-concept driver for the Acer T230H touchscreen.
 * By JVC, December 2009.
 */
#include <X11/Xlib.h>
#include <X11/extensions/XTest.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <strings.h>

Display *display;
Window winRoot;

#define ACER_T230H_GARB_0 0 /* Was 0 for a long time, but suddenly changed to 247 */
#define ACER_T230H_GARB_1 1 /* Always 1. Sync ? Don't quite trust it - also thought that the above was sync - but proved wrong after a whole day's use... */

#define ACER_T230H_GOT_DATA 2 /* 0 on no data - 7 when finger pressed - 4 when releasing finger (and last data input from that source) */
#define ACER_T230H_IS_POINTER 3 /* 0 if this finger is the (mouse) pointer - see note */
#define ACER_T230H_POS_X_LSB 4
#define ACER_T230H_POS_X_MSB 5
#define ACER_T230H_POS_Y_LSB 6
#define ACER_T230H_POS_Y_MSB 7

#define ACER_T230H_GOT_DATA_2ND 8 /* 0 on no data - 7 when finger pressed - 4 when releasing finger (and last data input from that source) */
#define ACER_T230H_IS_POINTER_2ND 9 /* 0 if this finger is the (mouse) pointer - see note */
#define ACER_T230H_POS_2ND_X_LSB 10
#define ACER_T230H_POS_2ND_X_MSB 11
#define ACER_T230H_POS_2ND_Y_LSB 12
#define ACER_T230H_POS_2ND_Y_MSB 13

#define ACER_T230H_TOUCH_NUM_FINGERS 14 /* 0 (just when putting finger down) - 2 */

/**
 * Note: The pointer finger will normaly be the first finger pressed.
 *       But if the two fingers are pressed, and the first finger is lifted,
 *       the second finger will receive the pointer flag - AND the data from
 *       the second finger is automatically copied to the first.
 */

#define BUTTON_LEFT 1
#define BUTTON_MIDDLE 2
#define BUTTON_RIGHT 4
struct ev_data {
	int x, y, button, scrollH, scrollV, wheel;
};

#define MOVEMENT_THRESHOLD 40 /* Movement threshold in pixels for mode 2. If finger is released before this threshold has been moved => right finger click. Else wheel or scrool. */

bool decodeData(unsigned char pkt[], struct ev_data *ev) {
    static int mode = 0; /* mode/buttons pressed. 0 => no buttons. 1 => left finger. 2 => two fingers => multi functionality */
    static unsigned int last_x = 0;
    static unsigned int last_y = 0;
    static unsigned int last_d = 0;
    unsigned int x, y, x2, y2, tmpd, tmpx, tmpy;
    int raisingFingerCount = 0;
    bool releaseOne; /* True if a finger is released, and the other is still pressed */
    bool releaseFull; /* True if a finger is released, and no more fingers are pressed */
    static bool pause = false; /* When scrolling or using wheel - one finger can be released to pause action */

/*    
    static int lastMode = 0;
    if(mode != lastMode) {
        fprintf(stderr, "Entering mode %d\n", mode);
        lastMode = mode;
    }
*/    
    
	/* packets should start with sync */
/* Apparently the first byte was not sync anyhow... it changed from 0 to 247 for no apparent reason
	if (pkt[ACER_T230H_SYNC_0] != 0 || pkt[ACER_T230H_SYNC_1] != 1) {
	    mode = 0;
		return false;
    }
*/
    
    /* Zero out buttons and relative axis */
    ev->button = 0;
    ev->scrollH = 0;
    ev->scrollV = 0;
    ev->wheel = 0;
    
	/* Calculate position and fingers released - always available */
	x = (pkt[ACER_T230H_POS_X_MSB] << 8) | pkt[ACER_T230H_POS_X_LSB]; if(x > 1919) x = 1919;
	y = (pkt[ACER_T230H_POS_Y_MSB] << 8) | pkt[ACER_T230H_POS_Y_LSB]; if(y > 1079) y = 1079;
    x2 = (pkt[ACER_T230H_POS_2ND_X_MSB] << 8) | pkt[ACER_T230H_POS_2ND_X_LSB]; if(x2 > 1919) x2 = 1919;
    y2 = (pkt[ACER_T230H_POS_2ND_Y_MSB] << 8) | pkt[ACER_T230H_POS_2ND_Y_LSB]; if(y2 > 1079) y2 = 1079;
    releaseOne = (pkt[ACER_T230H_GOT_DATA] == 4 && pkt[ACER_T230H_GOT_DATA_2ND] == 7) || (pkt[ACER_T230H_GOT_DATA_2ND] == 4 && pkt[ACER_T230H_GOT_DATA] == 7);
    releaseFull = (pkt[ACER_T230H_GOT_DATA] == 4 && pkt[ACER_T230H_GOT_DATA_2ND] != 7) || (pkt[ACER_T230H_GOT_DATA_2ND] == 4 && pkt[ACER_T230H_GOT_DATA] != 7);
    
    /* State machine. States:
     *  0: No finger pressed. 'Idle'. Next states: 1, 2
     *  1: One finger pressed: Left finger. Next states: 0.
     *  2: Multi-touch mode. Function not decided. Next states: 3, 4, 5.
     *  3: Multi.touch mode. Right click. Next states: 0.
     *  4: Multi.touch mode. Scroll. Next states: 0.
     *  5: Multi.touch mode. Wheel. Next states: 0.
     *
     * In addition to next states above, it is also valid to have no state change.
     */
    if(pkt[ACER_T230H_TOUCH_NUM_FINGERS] == 0) { /* Reset to mode zero */
        mode = 0;
        last_x = x;
        last_y = y;
        ev->x = x;
        ev->y = y;
        return true;
    }
    else if(mode == 0) { /* 'Idle' */
        if(pkt[ACER_T230H_TOUCH_NUM_FINGERS] == 1) { /* Single finger => left finger */
            mode = 1;
            ev->x = x;
            ev->y = y;
            ev->button = BUTTON_LEFT;
            return true;
        }

        if(pkt[ACER_T230H_TOUCH_NUM_FINGERS] == 2) { /* Two fingers => Multi mode */
            mode = 2;

            last_x = (x + x2) >> 1; /* Becomes center coordinates */
            last_y = (y + y2) >> 1; /* Becomes center coordinates */
            last_d = (unsigned int) sqrtf((x - x2) * (x - x2) + (y - y2) * (y - y2));
            
            ev->x = x;
            ev->y = y;
            return true;
        }

        mode = 0;
        return false; /* Unknown value for ACER_T230H_TOUCH_NUM_FINGERS */
    }
    else if(mode == 1) { /* Left finger */
        if(releaseFull) { /* Exit mode */
            mode = 0;
            return true;
        }

        if(pkt[ACER_T230H_TOUCH_NUM_FINGERS] == 1) { /* Keep left finger pressed */
            ev->x = x;
            ev->y = y;
            ev->button = BUTTON_LEFT;
            return true;
        }
            
        if(pkt[ACER_T230H_TOUCH_NUM_FINGERS] == 2) {
            ev->x = x;
            ev->y = y;
            if(releaseOne) /* Had two fingers, but going back to one */
                ev->button = BUTTON_LEFT;
            else /* Two fingers */
                ev->button = BUTTON_LEFT | BUTTON_RIGHT;

            return true;
        }

        /* Error - no fingers pressed ? */
        mode = 0;
        return false;
    }
    else if(mode == 2) { /* Multi touch - undecided function */
        tmpx = (x + x2) >> 1; /* Center coordinates */
        tmpy = (y + y2) >> 1; /* Center coordinates */
        tmpd = (unsigned int) sqrtf((x - x2) * (x - x2) + (y - y2) * (y - y2));

        /* Releasing two fingers => Make a right click and go back to mode 0 */
        if(releaseFull) { 
            mode = 0;
            ev->x = tmpx;
            ev->y = tmpy;
            ev->button = BUTTON_RIGHT;
            return true;
        }
        
        /* Wheel moved more than threshold => wheel mode */
        if(abs(tmpd - last_d) > MOVEMENT_THRESHOLD) { 
            mode = 5;
            ev->x = tmpx;
            ev->y = tmpy;
            ev->wheel = tmpd - last_d;
            last_d = tmpd;
            return true;
        }
        
        /* Center moved more than threshold => scroll mode */
        if((unsigned int) sqrtf((last_x - tmpx) * (last_x - tmpx) + (last_y - tmpy) * (last_y - tmpy)) > MOVEMENT_THRESHOLD) { 
            ev->scrollH = tmpx - last_x;
            ev->scrollV = tmpy - last_y;
            last_x = tmpx;
            last_y = tmpy;
            mode = 4;
            return true;
        }
        
        /* No movement exceeded threshold - and release finger => right click */
        if(releaseOne) {
            mode = 3;
            ev->x = tmpx;
            ev->y = tmpy;
            ev->button = BUTTON_RIGHT;
        }
            

        /* No decicion yet */            
        return true;
    }
    else if(mode == 3) { /* Multi touch - right button */
        if(releaseFull) {
            mode = 0;
            return true;
        }
        
        /* Only accept one finger press */
        if(pkt[ACER_T230H_TOUCH_NUM_FINGERS] == 1) { 
            ev->x = x;
            ev->y = y;
            ev->button = BUTTON_RIGHT;
            return true;
        }

        /* No movement - but keep button pressed */
        ev->button = BUTTON_RIGHT;
        return true;
    }
    else if(mode == 4) { /* Multi touch - scroll */
        if(releaseFull) {
            mode = 0;
            return true;
        }

        /* Only accept two fingers press */
        if(pkt[ACER_T230H_TOUCH_NUM_FINGERS] == 2) { 
            tmpx = (x + x2) >> 1; /* Center coordinates */
            tmpy = (y + y2) >> 1; /* Center coordinates */
            if(!pause) {
                ev->scrollH = tmpx - last_x;
                ev->scrollV = tmpy - last_y;
            }
            pause = false;
            last_x = tmpx;
            last_y = tmpy;
            return true;
        }
        
        /* Silently do nothing */
        pause = true;
        return true;
    }
    else if(mode == 5) { /* Multi touch - wheel */
        if(releaseFull) {
            mode = 0;
            return true;
        }
    
        /* Only accept two fingers press */
        if(pkt[ACER_T230H_TOUCH_NUM_FINGERS] == 2) { 
            tmpd = (unsigned int) sqrtf((x - x2) * (x - x2) + (y - y2) * (y - y2));
            tmpx = (x + x2) >> 1; /* Center coordinates */
            tmpy = (y + y2) >> 1; /* Center coordinates */
            ev->x = tmpx;
            ev->y = tmpy;
            if(!pause)
                ev->wheel = tmpd - last_d;
            last_d = tmpd;
            pause = false;
            return true;
        }

        /* Silently do nothing */
        pause = true;
        return true;
    }
    
    /* Should not happen */
    mode = 0;
    return false;
}



int main(int argc, char *argv[]) {
  FILE *hidraw = fopen("/dev/input/t230h", "rb");
  if(hidraw == NULL) {
    fprintf(stderr, "Could not open /dev/input/t230h. Exiting.\n"); /* /dev/input/t230h is symlink to /dev/hidraw? */
    return 1;
  }
  
  unsigned char buf[15];
  bool left = false, right = false;

  struct ev_data ev;
  bzero(&ev, sizeof(ev));
  
  int wheelCount = 0;
  int scrollHCount = 0;
  int scrollVCount = 0;


  while(1) {
    int s = fread(buf, sizeof(char), 15, hidraw);
    if(s == 0) { /* End of stream - perhaps unplugged device */
      fprintf(stderr, "End of stream. Perhaps the device is unplugged?\n"); /* /dev/input/t230h is symlink to /dev/hidraw? */
      fclose(hidraw);
      return 0;
    }

    if(s != 15) {
      fprintf(stderr, "Expected 15 bytes. Got %d instead. Skipping.\n", s);
      continue;
    }

/*    
    for(int i=0; i < 15; i++)
      printf("%4u ", (unsigned int) buf[i]);
    printf("\n");
*/
    
    if(decodeData(buf, &ev)) {
        //printf("Mouse pos: %4d x %4d - Scroll: %4d x %4d - Wheel: %4d - Button: %d\n", ev.x, ev.y, ev.scrollH, ev.scrollV, ev.wheel, ev.button);
        
        display = XOpenDisplay(0);
        if(display == NULL) {
          fprintf(stderr, "Could not open display. Exiting.\n");
          return 1;
        }

        XTestFakeMotionEvent(display, -1, ev.x, ev.y, 0);

        if(((ev.button & BUTTON_LEFT)) && !left)
            XTestFakeButtonEvent(display, 1, true, 0);
        else if(((ev.button & BUTTON_LEFT) == 0) && left)
            XTestFakeButtonEvent(display, 1, false, 0);
        left = (bool) (ev.button & BUTTON_LEFT);

        if(((ev.button & BUTTON_RIGHT)) && !right)
            XTestFakeButtonEvent(display, 3, true, 0);
        else if(((ev.button & BUTTON_RIGHT) == 0) && right)
            XTestFakeButtonEvent(display, 3, false, 0);
        right = (bool) (ev.button & BUTTON_RIGHT);

        #define MOVE_SPEED 66
        wheelCount += ev.wheel;
        if(wheelCount > MOVE_SPEED) {
//            printf("Wheel up\n");
            XTestFakeButtonEvent(display, 4, true, 0);
            XTestFakeButtonEvent(display, 4, false, 5);
            wheelCount -= MOVE_SPEED;
        }
        if(wheelCount < -MOVE_SPEED) {
//            printf("Wheel down\n");
            XTestFakeButtonEvent(display, 5, true, 0);
            XTestFakeButtonEvent(display, 5, false, 5);
            wheelCount += MOVE_SPEED;
        }
            
        scrollHCount += ev.scrollH;
        if(scrollHCount > MOVE_SPEED) {
//            printf("Scroll H left\n");
            XTestFakeButtonEvent(display, 6, true, 0);
            XTestFakeButtonEvent(display, 6, false, 5);
            scrollHCount -= MOVE_SPEED;
        }
        if(scrollHCount < -MOVE_SPEED) {
//            printf("Scroll H right\n");
            XTestFakeButtonEvent(display, 7, true, 0);
            XTestFakeButtonEvent(display, 7, false, 5);
            scrollHCount += MOVE_SPEED;
        }

        scrollVCount += ev.scrollV;
        if(scrollVCount > MOVE_SPEED) {
//            printf("Scroll V up\n");
            XTestFakeButtonEvent(display, 4, true, 0);
            XTestFakeButtonEvent(display, 4, false, 5);
            scrollVCount -= MOVE_SPEED;
        }
        if(scrollVCount < -MOVE_SPEED) {
//            printf("Scroll V down\n");
            XTestFakeButtonEvent(display, 5, true, 0);
            XTestFakeButtonEvent(display, 5, false, 5);
            scrollVCount += MOVE_SPEED;
        }
    
        XCloseDisplay(display);
    }
    else { /* Error - release buttons */
        if(left) {
            XTestFakeButtonEvent(display, 1, false, 0);
            left = false;
        }
        if(right) {
            XTestFakeButtonEvent(display, 3, false, 0);
            right = false;
        }

    }
  }
}


--------------070109060507020908080108
Content-Type: text/plain;
 name="lsusb.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lsusb.txt"


Bus 006 Device 007: ID 0408:3000 Quanta Computer, Inc. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x0408 Quanta Computer, Inc.
  idProduct          0x3000 
  bcdDevice            0.00
  iManufacturer           1 Acer
  iProduct                2 T230H
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           34
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      0 No Subclass
      bInterfaceProtocol      0 None
      iInterface              0 
      ** UNRECOGNIZED:  09 21 10 01 00 01 22 d2 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               8
Device Status:     0x0000
  (Bus Powered)

--------------070109060507020908080108--
