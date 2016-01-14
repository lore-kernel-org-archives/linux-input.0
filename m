From: Roberto Alejandro Espi Munoz <raespi@icid.cu>
Subject: Re: uinput on headless system ...
Date: Thu, 14 Jan 2016 09:05:53 -0500
Message-ID: <5697AB41.3070001@icid.cu>
References: <56965CFB.3020401@icid.cu>	<20160113222151.GE39593@dtor-ws> <CAN+gG=FirVq_MrXDkFe8K=7TEVzif9MSHvov4SyZE1M_Z5N=8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.icid.cu ([200.55.133.90]:59151 "EHLO mail.icid.cu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751599AbcANOGh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Jan 2016 09:06:37 -0500
Received: from icid.cu ([10.10.0.3])
	by mail.icid.cu (8.13.8/8.13.8) with ESMTP id u0ECsex6001681
	for <linux-input@vger.kernel.org>; Thu, 14 Jan 2016 07:54:47 -0500
Received: from [10.10.8.78] by icid.cu
	(Cipher TLSv1:RC4-MD5:128) (MDaemon PRO v9.6.1)
	with ESMTP id md50008530586.msg
	for <linux-input@vger.kernel.org>; Thu, 14 Jan 2016 08:23:48 -0500
In-Reply-To: <CAN+gG=FirVq_MrXDkFe8K=7TEVzif9MSHvov4SyZE1M_Z5N=8g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

Yes the uinput driver is compiled as a module and loaded before running 
the test app that I have (double checked with modprobe and lsmod).  The 
same code has been compiled for my laptop and everything loads and works 
fine when sending events to the input subsystem.   I mentioned the 
physical keyboard issue because that's what made it work: SCENARIO1 the 
headless motherboard starts without a keyboard and both the module and 
the app loads but no events get injected and the problem occurs when 
writing to the /dev/uinput device, SCENARIO2 I connect a physical 
keyboard and all goes well. I looked at the libevdev before and sinced 
my code ended up working on my laptop I discarded the library.  I saw 
the libevdev-uinput.c you recommended, I think I'm following the same 
rationale.

Thanks for the replies ...

This is the code I'm using that fails at the end when writing to the 
/dev/uinput device:

     int uinputDev;
     struct uinput_user_dev device;
     memset(&device, 0, sizeof device);

     uinputDev = open("/dev/uinput",O_WRONLY | O_NONBLOCK);
         strcpy(device.name,"test remote");

         device.id.bustype=BUS_USB;
         device.id.vendor=1;
         device.id.product=1;
         device.id.version=1;


         if (write(uinputDev,&device,sizeof(device)) != sizeof(device))
         {
             fprintf(stderr, "error setup\n");
         }
         if (ioctl(uinputDev,UI_SET_EVBIT,EV_KEY) < 0)
             fprintf(stderr, "error evbit key\n");

         if (ioctl(uinputDev,UI_SET_KEYBIT, KEY_LEFT) < 0)
             fprintf(stderr, "error evbit key\n");

         if (ioctl(uinputDev,UI_SET_KEYBIT, KEY_UP) < 0)
             fprintf(stderr, "error evbit key\n");

         if (ioctl(uinputDev,UI_SET_KEYBIT, KEY_DOWN) < 0)
             fprintf(stderr, "error evbit key\n");

         if (ioctl(uinputDev,UI_SET_KEYBIT, KEY_RIGHT) < 0)
             fprintf(stderr, "error evbit key\n");

         if (ioctl(uinputDev,UI_SET_KEYBIT, KEY_ENTER) < 0)
             fprintf(stderr, "error evbit key\n");

         if (ioctl(uinputDev,UI_DEV_CREATE) < 0)
         {
             fprintf(stderr, "error create\n");
         }

      struct input_event event;

     memset(&event, 0, sizeof(event));
     event.type = EV_KEY;
     event.code = KEY_UP;
     event.value = 1;
     gettimeofday(&event.time,NULL);

     if (write( uinputDev, &event, sizeof(struct input_event)) != 
sizeof( struct input_event) ) {
         fprintf(stderr, "Error on send_event");
         return -1;
     }

     memset(&event, 0, sizeof(event));
     event.type = EV_KEY;
     event.code = KEY_UP;
     event.value = 0;
     gettimeofday(&event.time,NULL);

     if (write( uinputDev, &event, sizeof(struct input_event)) != 
sizeof( struct input_event) ) {
         fprintf(stderr, "Error on send_event");
         return -1;
     }

On 01/14/2016 12:08 AM, Benjamin Tissoires wrote:
> Hi Roberto,
>
> On Wed, Jan 13, 2016 at 11:21 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> Hi Roberto,
>>
>> On Wed, Jan 13, 2016 at 09:19:39AM -0500, Roberto Alejandro Espi Munoz wrote:
>>> Hello ... I've been searching around the web for a specific mailing
>>> list for the uinput driver but couldn't find any.  I managed to
>>> create an example app that injects keyboard events to the running
>>> linux kernel succesfully when I have a keyboard attached to the
>>> computer.  However if I run it on a keyboardless machine, like a
>>> standalone motherboard, the uinput device fails to open.
>> uinput driver does not depend on presence of a physical keyboard. I'd
>> start looking whether uinput module is enabled on your headless box and
>> if it is a module verify that it is loaded.
>>
> As Dmitry said, uinput is independent of any attached hardware.
> You might want to see how we managed to create new devices through
> uinput by looking at libevdev[1] (see libevdev/libevdev-uinput.c).
>
> You might actually also want to use libevdev instead of manually doing
> the ioctls and processing of all the small things :)
>
> Cheers,
> Benjamin
>
> [1] http://www.freedesktop.org/wiki/Software/libevdev/
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


