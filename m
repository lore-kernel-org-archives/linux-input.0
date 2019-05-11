From: Roderick Colenbrander <thunderbird2k@gmail.com>
Subject: Re: [RFC v2] iio: input-bridge: optionally bridge iio acceleometers
 to create a /dev/input interface
Date: Sat, 11 May 2019 11:47:30 -0700
Message-ID: <CAEc3jaBTbH=zHogxekRw5i=GtQcRc9O_d68fMwQb-7jdOcvh5w@mail.gmail.com>
References: <195994ebff28de22eae872df134d086c761b83b8.1554026986.git.hns@goldelico.com>
 <20190407133037.0ad98897@archlinux> <CD44AFA0-6676-4842-9C80-61BB363DD556@goldelico.com>
 <20190414124029.1f1f6084@archlinux> <CAEc3jaCnHLA9PV5gLiBvHT5y26mwMGSUxa3YCO=c+FYmcszePQ@mail.gmail.com>
 <d9f2ee79b8690939f36377990fb6d6fb08e9f0bc.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d9f2ee79b8690939f36377990fb6d6fb08e9f0bc.camel@hadess.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Jonathan Cameron <jic23@kernel.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eric Piel <eric.piel@tremplin-utc.net>, linux-input <linux-input@vger.kernel.org>, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, lkml <linux-kernel@vger.kernel.org>, linux-iio@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, May 10, 2019 at 1:57 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Sun, 2019-04-14 at 09:26 -0700, Roderick Colenbrander wrote:
> >
> <snip>
> > We at the time were one of the first to expose acceleration and gyro
> > data through /dev/input for DualShock 4 as supported by hid-sony. We
> > report acceleration in 'g' and angular velocity in 'degree / s'. We
> > set the resolution to respectively '1 g' and '1 degree / s'. The range
> > we set to the range of the device e.g. for DS4 -4g to +4g for
> > acceleration. I need to check though what coordinate system we use,
> > but I think it is right handed (gyro counter clockwise relative to
> > acceleration axes).
>
> How do you export the gyro information through the input device?

For each DS4, there are multiple evdev devices for a DS4 for
respectively "gamepad", touchpad and motion sensors. The motion
sensors one, has INPUT_PROP_ACCELEROMETER set. ABS_X/_Y_Z provide
acceleration and ABS_RX/_RY/_RZ provide gyro. When we added this we
also updated the input documentation (event-codes.rst) to allow gyro
to use the rotational axes.

> FWIW, we needed to do extra work in iio-sensor-proxy so that the
> accelerometer in the Sixaxis/DS4 joypads (and uDraw tablet) didn't
> appear as though they were accelerometer for the system:
> https://github.com/hadess/iio-sensor-proxy/commit/401d59e54b3123860180d4401e09df8a1e1bc6c3
>
> > The two other drivers using INPUT_PROC_ACCELEROMETER are hid-wacom and
> > hid-udraw-ps3 Wacom. Both seem to report resolution in 'g'  as well.
>
> I wrote hid-udraw-ps3, and it's reporting accelerometer data through
> input because the rest of the driver is input, and it didn't make much
> sense to use another subsystem for just that small portion of the
> events the device sends out.
>
