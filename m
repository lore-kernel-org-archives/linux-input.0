From: Nathan Royer <nroyer@invensense.com>
Subject: Re: [PATCH 01/11] misc: inv_mpu primary header file and README file.
Date: Fri, 8 Jul 2011 09:24:44 -0700
Message-ID: <CAGiMKzRruQXf3Kakf1zL051D-j3XQ5+4FMfKLpF3VoLxTHb3Mg@mail.gmail.com>
References: <1309486707-1658-1-git-send-email-nroyer@invensense.com>
	<4E0D8E94.5030604@cam.ac.uk>
	<4d61a92a11e5d83a1cb0094441ae5f5e@mail.gmail.com>
	<4E105284.7030209@cam.ac.uk>
	<20110704091658.0d4c8e3f@bob.linux.org.uk>
	<c2189246a279a0e5a1b8599edc94a79a@mail.gmail.com>
	<20110706115430.3745592c@bob.linux.org.uk>
	<592dafb95382604bd514687f7600cebd@mail.gmail.com>
	<20110707084026.4562ab94@lxorguk.ukuu.org.uk>
	<e02bd0691ed3d1e1390459018e79c8bc@mail.gmail.com>
	<4E16E853.1060202@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:41019 "HELO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750783Ab1GHQYq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 8 Jul 2011 12:24:46 -0400
In-Reply-To: <4E16E853.1060202@cam.ac.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Jiri Kosina <jkosina@suse.cz>, Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Chris Hudson <chudson@kionix.com>, eric.andersson@unixphere.com

>> Our MPL needs the platform data, mostly the orientation of each devi=
ce.
>> The relevant information can be made available as iio sysfs attribut=
es for
>> each device. =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> #define MPU_GET_EXT_SLAVE_PLATFORM_DATA =A0 =A0 =A0 \
>> =A0 =A0 =A0 _IOWR(MPU_IOCTL, 0x02, struct ext_slave_platform_data)
>> #define MPU_GET_MPU_PLATFORM_DATA =A0 =A0 \
>> =A0 =A0 =A0 _IOWR(MPU_IOCTL, 0x02, struct mpu_platform_data)
>> #define MPU_GET_EXT_SLAVE_DESCR =A0 =A0 =A0 \
>> =A0 =A0 =A0 _IOWR(MPU_IOCTL, 0x02, struct ext_slave_descr)
> Perfectly acceptable to have sysfs attributes with input devices to, =
so that
> doesn't matter so much. =A0Now there are issues with what they are.
> Why is platform data passed via sysfs? It's platform data, so it belo=
ngs
> in a board file or device tree.

Yes I agree, but user space needs to read that information, my plan
was to make the information in the platform data available as read
only attributes.  Is there a better way?

>>
>> These are simple register reads and register writes. =A0These can be
>> replaced with iio sysfs attributes for the gyro driver.
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> #define MPU_READ =A0 =A0 =A0 =A0 =A0 =A0 =A0_IOWR(MPU_IOCTL, 0x10, s=
truct
>> mpu_read_write)
>> #define MPU_WRITE =A0 =A0 =A0 =A0 =A0 =A0 _IOW(MPU_IOCTL, =A00x10, s=
truct
>> mpu_read_write)
> Hmm. These really don't belong in sysfs. They are opaque and complete=
ly
> ungeneralizable. =A0If you have this of need to write general purpose=
 stuff
> then perhaps consider some of the work going on for communications be=
tween
> asymmetric multiprocessor systems.

I think this particular interface is redundant with MPU_CFG_GYRO.
I'll need to look through our user space code, but I think 1 attribute
per register will remove the need for these general purpose i2c read
and write.

>> This was used to start or stop the system. =A0This can be replaced w=
ith iio
>> sysfs power mode attribute for each slave, and an additional one for=
 the
>> MPU controller.
> Ideally this wants to be handled via runtime pm so that the dependenc=
ies
> are nicely handled.

Ok, I'll look into runtime pm.

>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> #define MPU_SUSPEND =A0 =A0 =A0 =A0 =A0 _IOW(MPU_IOCTL, 0x30, __u32)
>> #define MPU_RESUME =A0 =A0 =A0 =A0 =A0 =A0_IOW(MPU_IOCTL, 0x31, __u3=
2)
>>
>> Selecting on /dev/mpu will return a MPU_PM_EVENT_SUSPEND_PREPARE or
>> MPU_PM_EVENT_POST_SUSPEND allowing user space to decide if it wants =
to
>> leave anything powered on when suspended. =A0This in conjunction wit=
h the
>> IGNORE_SYSTEM_SUSPEND allows the DMP plus gyro and/or accel to conti=
nue
>> running while the main processor is suspended. =A0This can be used t=
o wake
>> up the main processor on a particular motion event, or to record mot=
ion
>> events to be reported when the processor later wakes up. =A0This ioc=
tl
>> signals that user space has finished configuring all sensors and the=
 MPU
>> controller and that the MPU controller can continue.
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> #define MPU_PM_EVENT_HANDLED =A0_IO(MPU_IOCTL, 0x32)
>>
>> Requested sensors is a common place to know which sensors are on, an=
d to
>> specify which sensors to turn on the next time the system is started=
=2E
>> This can be removed since it is redundant with power mode attributes=
 I'm
>> proposing be used by each slave and the MPU controller.
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> #define MPU_GET_REQUESTED_SENSORS =A0 =A0 _IOR(MPU_IOCTL, 0x40, __u8=
)
>> #define MPU_SET_REQUESTED_SENSORS =A0 =A0 _IOW(MPU_IOCTL, 0x40, __u8=
)
>>
>> See my note on MPU_PM_EVENT_HANDLED above. =A0This can be made a Sys=
=46s
>> attribute of drivers/misc/inv_mpu
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> #define MPU_GET_IGNORE_SYSTEM_SUSPEND _IOR(MPU_IOCTL, 0x41, __u8)
>> #define MPU_SET_IGNORE_SYSTEM_SUSPEND _IOW(MPU_IOCTL, 0x41, __u8)
> Is this supported in runtime pm? =A0If not, perhaps it is a usecase t=
hat should
> be. =A0Here we could disable the bus, but not for example relevant re=
gulators.

User space needs a way to control if the chip is left powered or not.
In our use case we will load different firmware that keeps event
records in DMP memory, or generate an IRQ on event.  If nobody is user
land wants this feature enabled, then we completely sleep the chip.
I'll look to see if this is supported by runtime pm, not too familiar
with runtime pm... yet.

>> These are bitfield of how the MPU controller state. =A0Which devices=
 are
>> currently suspended, which devices are running, if the i2c master is
>> bypassed, if the DMP is running. =A0This can be made a SysFs attribu=
te, and
>> perhaps removed.
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> #define MPU_GET_MLDL_STATUS =A0 =A0 =A0 =A0 =A0 _IOR(MPU_IOCTL, 0x42=
, __u8)
> If sysfs, it should be one attribute per device, not a bitfield.

Ok, agreed.

>>
>> This is a bitfield showing the status of which of the master i2c cha=
nnels
>> have been enabled. =A0The mpu3050 has 1 channel, and the mpu6050 has=
 5
>> channels. =A0This can become a sysfs attribute
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> #define MPU_GET_I2C_SLAVES_ENABLED =A0 =A0_IOR(MPU_IOCTL, 0x43, __u8=
)
> I think this should be handled via some platform data / run time pm.
>
> If there is something there and it's being talked to it should be ena=
bled.
> Otherwise not.

Correct,  this was actually never necessary.  I will just remove it.

>>
>> After all is said and done this is files that would be made availabl=
e:
>> /dev/mpu
>> =A0 =A0 =A0 Iotcl interface for memory and fifo reads writes, read f=
or events
>> include pm events and irq events.
> Make sure it is numbered. Perfectly reasonable to have more than one =
of these!

If so I could get rid of the ioctl interface and replace it with
/dev/mpumem read() and write() and a /dev/mpufifo read() and write()
and /dev/mpupm read() for pm events if there isn't a better API for
runtime pm.  Which do you think would be better, several /dev devices
with read/write or a single /dev file with ioctl's?

>>
>> I'm not exactly sure of the details of what you are suggesting, but
>> somehow telling a slave that it is now being used in 'smart' mode is=
 fine,
>> as long as the MPU controller can still read back the information it=
 needs
>> to control it, for example setting up the mpu3050 i2c master.
> To my mind this should look a bit like the i2c bus multiplexers. =A0T=
he only
> difference is that under some conditions, devices won't respond (the =
master
> has taken an exclusive lock on them).

I like that idea.  That means that certain interactions would return
-EBUSY if locked by the master.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
