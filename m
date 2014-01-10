From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: Re: Re: [PATCH] Introduce Naming Convention in Input Subsystem
Date: Sat, 11 Jan 2014 02:55:33 +0530
Message-ID: <CADYu30_qxKV7SmUdUc1Y-sN+KDYbWyz6Yv_H6BsSA-koK9aWYQ@mail.gmail.com>
References: <25201406.444611389372583656.JavaMail.weblogic@epml19>
	<20140110191108.GC10889@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:38903 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbaAJVZf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Jan 2014 16:25:35 -0500
Received: by mail-lb0-f172.google.com with SMTP id x18so3796131lbi.17
        for <linux-input@vger.kernel.org>; Fri, 10 Jan 2014 13:25:34 -0800 (PST)
In-Reply-To: <20140110191108.GC10889@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Aniroop Mathur <a.mathur@samsung.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "cpgs ." <cpgs@samsung.com>, Anurag Aggarwal <a.anurag@samsung.com>, Naveen Kumar <naveen.sel@samsung.com>, VIKAS KALA <vikas.kala@samsung.com>, Poorva Srivastava <poorva.s@samsung.com>

Hello Mr. Torokhov,
Greetings!

First of all, So sorry, unfortunately i used HTML text again.
and Many thanks for all replies.

Sending email again in plain text.


On Sat, Jan 11, 2014 at 12:41 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Aniroop,
>
> On Fri, Jan 10, 2014 at 04:49:43PM +0000, Aniroop Mathur wrote:
>> Hello Mr. Torokhov,
>> Greetings!
>>
>> On Thu, Jan 09, 2014 at 10:27:56AM +0530, Aniroop Mathur wrote:
>> > This patch allows user(driver) to set sysfs node name of input
>> > devices.  To set sysfs node name, user(driver) just needs to set
>> > node_name_unique variable.  If node_name_unique is not set, default
>> > name is given(as before).  So, this patch is completely
>> > backward-compatible.
>> >
>> > Sysfs Input node name format is: input_
>> > Sysfs Event node name format is: event_
>> >
>> > This "name" is given by user and automatically, prefix(input and
>> > event) is added by input core.
>> >
>> > This name must be unique among all input devices and driver(user) has
>> > the responsibility to ensure it.  If same name is used again for other
>> > input device, registration of that input device will fail because two
>> > input devices cannot have same name.
>> >
>> > Advantages of this patch are:
>> >
>> > 1. Reduces Booting Time of HAL/Upper-Layer because now HAL or
>> > Upper-Layer do not need to search input/event number corresponding to
>> > each input device in /dev/input/...  This searching in /dev/input/ was
>> > taking too much time.  (Especially in mobile devices, where there are
>> > many input devices (many sensors, touchscreen, etc), it reduces a lot
>> > of booting time)
>>
>> I am sorry, how much time does it take to scan a directory of what, 20
>> devices? If it such a factor have udev create nodes that are easier for
>> you to locate, similarly how we already create nodes by-id and by-path.
>> For example you can encode major:minor in device name.
>>
>> Re: (Aniroop Mathur)
>
> First of all, it would be great if you could use MUA that can properly
> quote and wrap long lines...
>
>> Its correct that we can set name of a device node using udev.  Yes,
>> this will change the name of device node(/dev/...) but not sysfs
>> node.(/sys/class/input/...) So now, the problem area will shift from
>> dev path to sysfs path, because now we dont know which sysfs node to
>> refer for a particular input device and hence HAL/Upper-Layer will
>> need to search in /sys/class/input/... instead of /dev/... directory.
>
> [dtor@dtor-d630 ~]$ mkdir my-sysfs-view
> [dtor@dtor-d630 ~]$ ln -s
> /sys/devices/platform/i8042/serio1/input/input6
> my-sysfs-view/input_touchpad
> [dtor@dtor-d630 ~]$ ls my-sysfs-view/input_touchpad/
> capabilities/ event6/       modalias      name          power/
> subsystem/    uniq
> device/       id/           mouse1/       phys          properties
> uevent
> [dtor@dtor-d630 ~]$ ls my-sysfs-view/input_touchpad/
> capabilities  device  event6  id  modalias  mouse1  name  phys  power
> properties  subsystem  uevent  uniq
> [dtor@dtor-d630 ~]$ ls my-sysfs-view/input_touchpad/event6/
> dev  device  power  subsystem  uevent
>
> Mmmmkay?
>

Yes, agreed, we can use udev and soft links to achieve this.
But i think there is something more to take care.

So far, as per discussion, i understood that if an end user wants to use
node names instead of numbers, he/she has to do the following things:
1. Create rules for all input devices in udev rule file i.e. set atleast
unique id and unique name.
(end user need to determine unique id too for every input device)
2. Create links for all input device nodes using names.
(in probe function, after input_register_device)

By following above two steps, the file structure will look like:
devfs - /dev/input_proximity
sysfs - my-sysfs-view/input_proximity --> sys/class/input/input2
sysfs - my-sysfs-view/event_proximity --> sys/class/input/event2

But my concern is why to create trouble for end user to perform
and spend time for two extra steps, when an easy way is possible
to achieve the same task ?

With this patch, end user only need to set node_name_unique variable
and right after that, both for devfs and sysfs,same node name is set.
End user does not need to do or take care of any other extra work,
like creating entry in udev rules, creating links, etc

Also, with creating links for all input devices and checking udev rules
before actually creating a device node, will only increase computation
and time in kernel code.

My purpose is to avoid extra work load and directly create node names
within input subsystem. Also backward compatibility is there.
So i think, it is better than the other alternative way.
Isn't this more easy ? Is there any side-effect or drawback of this patch ?

>>
>> Moreover, as i know, udev is mainly for hot-pluggable devices, but my
>> problem is for platform devices, which are already present on the
>> board during boot up. (Like in Embedded devices)
>
> No, udev also manages those by requesting to replay all events that
> happened dyuring boot.
>
>>
>> To avoid confusion and make the problem more clear,
>> I would like to explain the problem and my suggestion by taking an example:
>>
>> Suppose in a mobile device, there are 10 embedded input devices as below:
>> Proximity ---                /dev/input0  --- /sys/class/input/input0 --- /sys/class/input/event0
>> Magnetometer ---      /dev/input1   --- /sys/class/input/input1 --- /sys/class/input/event1
>> Accelerometer ---      /dev/input2  --- /sys/class/input/input2 --- /sys/class/input/event2
>> Touchscreen ---         /dev/input3  --- /sys/class/input/input3 --- /sys/class/input/event3
>> ... 6 more like this
>> (All these are created during boot up time)
>>
>> Kernel has created all these nodes, so that HAL/UpperLayer can read or
>> write values from it.  HAL/Upper-Layer needs to do main tasks like:
>> 1. Read raw data - does through /dev/input<num>
>> 2. Enable device - does through sys/class/input<num>/enable
>> 3. Set delay - does through sys/class/input<num>/delay
>> and many more...
>>
>> Now, Lets suppose we need to do these tasks for Accelerometer.
>>
>> If dev node name is set, HAL can directly read value from it (no
>> search required) But for enabling the accelerometer device or set the
>> delay of a hardware chip, there is no direct way, HAL can know which
>> input node to refer for accelerometer because the input number is
>> created dynamically as per device probe order, so this input number
>> can be anything (0,1,2,3...) So HAL will need to search every input
>> node and read its name attribute and keep on searching until a match
>> is found between the "attribute name" and "name passed as parameter".
>> Like for accelerometer, this searching needs to be done for all other
>> input devices.  All of this part is done during booting and this takes
>> a lot for time from booting perspective.
>>
>
> See the above. You can very easily create your own private 'view' of
> sysfs, no kernel changes needed.
>
>> As I measured, if there are ten devices, it is taking 1 second to do
>> all this searching. (for all devices) So for 20 devices, i guess, it
>> could take upto 2 seconds.
>
> That seems _very_ high, maybe you need to profile your code a bit. To
> search though 2 directories with less than a hundred files each should
> not take 1 second.
>

In this i am including time to open a directory, close a directory, open file of
that directory, close file of that directory, searching and computation part.
Including all these, every time for each input device.
All this sums upto 1 second.

>>
>> With naming convention, there is no need of search neither for dev
>> path nor for sysfs path because HAL directly know which node to refer
>> for which input device and hence this 1 second is reduced to 10ms or
>> even less, therefore saving 990ms.  I believe, this is a very good
>> time saving. (from device booting perspective)
>
> OK, so create your own sysfs view and use it to do direct lookups.
>
>>
>> (Is there any direct way, without scanning all nodes for every input
>> device ?)
>>
>> >
>> > 2. Improves Readabilty of input and event sysfs node paths because
>> > names are used instead of numbers.
>>
>> I do not see why it is that important. If one wants overview
>> /proc/bus/input/devices gives nice picture.
>>
>> Re: (Aniroop Mathur)
>> Its correct, we can get an overview from /proc/bus/input/devices.
>> And therefore using this, we can know input node number for every input device.
>> But there are many input devices and input numbers are not fixed,
>> so its quite difficult to memorize input number for all input devices.
>> Therefore, if a user needs to open some input node from sysfs path,
>> he needs to check /proc/bus/input/devices before opening because
>> he does not know the input number. Moreover, this applies for all other
>> input devices and hence a user need to check this every time.
>>
>> It improves readabilty as below
>>
>> Before:                               After patch:
>> /dev/input0                           /dev/input_proximity
>> /dev/input1                           /dev/input_accelerometer
>> ...many more
>>
>> /sys/class/input/input0                       /sys/class/input/input_proximity
>> /sys/class/input/input1                       /sys/class/input/input_accelerometer
>> ...many more
>>
>> /sys/class/input/event0                       /sys/class/input/event_proximity
>> /sys/class/input/event1                       /sys/class/input/event_accelerometer
>> ...many more
>>
>> So, just by looking, user can directly open or refer any input node.
>> (no need to refer any other path)
>
> User as in end user or your HAL layer?
>

End user.

>>
>> >
>> > 3. Removes Input Devices Dependency. If one input device probe fails,
>> > other input devices still work.  Before this patch, if one input
>> > device probe fails before input_register_device, then input number of
>> > other input devices changes and due to this permission settings are
>> > disturbed and hence HAL or upper layer cannot open the required sysfs
>> > node because permission denied error comes.
>>
>> I have only one suggestion here: fix your userspace so that does not
>> depend on device initialization ordering.
>>
>> Re: (Aniroop Mathur)
>> We cannot fix userspace because these input/event/dev number are
>> decided/allocated in kernel as per device initialization ordering
>> during boot up. (userspace has no role in it) So, userspace is not
>> aware, which exact input number corresponds to which input device so
>> it ends up searching/scanning every input node untill a match is
>> found.
>>
>> So, there is input device dependency which needs to be removed.
>
> Do not use numbers. We emit uevents describing the devices and there a
> _lot_ of data there that helps identifying device, such as its path,
> subsystem, name, etc.
>

Sorry, I am not able to understand this point with respect to removing input
device dependency. Please elaborate a bit more.

>>
>> ----------------------------
>>
>> IOW I am totally unconvinced that this facility is needed.
>>
>> Re: (Aniroop Mathur)
>> I hope my problem and suggestion is more clear and convincing now.
>>
>
> Not in the slightest, I am sorry.
>
> Thanks.
>
> --
> Dmitry

Thanks,
Aniroop Mathur
