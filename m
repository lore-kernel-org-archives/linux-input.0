From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [IR-RFC PATCH v4 2/6] Core IR module
Date: Sun, 29 Nov 2009 12:41:22 -0500
Message-ID: <9e4733910911290941o761a4dfhf4168e573c6b6e89@mail.gmail.com>
References: <20091127013217.7671.32355.stgit@terra>
	 <20091127013423.7671.36546.stgit@terra>
	 <20091129171726.GB4993@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20091129171726.GB4993@kroah.com>
Sender: linux-media-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, Nov 29, 2009 at 12:17 PM, Greg KH <greg@kroah.com> wrote:
>> +static ssize_t ir_raw_show(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct =
device_attribute *attr, char *buf)
>> +{
>> + =A0 =A0 struct input_dev *input_dev =3D to_input_dev(dev);
>> + =A0 =A0 unsigned int i, count =3D 0;
>> +
>> + =A0 =A0 for (i =3D input_dev->ir->raw.tail; i !=3D input_dev->ir->=
raw.head; ) {
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 count +=3D snprintf(&buf[count], PAGE_SIZE=
 - 1, "%i\n", input_dev->ir->raw.buffer[i++]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (i > ARRAY_SIZE(input_dev->ir->raw.buff=
er))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (count >=3D PAGE_SIZE - 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_dev->ir->raw.tail =3D=
 i;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PAGE_SIZE - 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> + =A0 =A0 input_dev->ir->raw.tail =3D i;
>> + =A0 =A0 return count;
>> +}
>
> This looks like it violates the "one value per sysfs file" rule that =
we
> have. =A0What exactly are you outputting here? =A0It does not look li=
ke this
> belongs in sysfs at all.

It should be on a debug switch or maybe a debug device. If the rest of
the system is working right you shouldn't need this data.

>
>> +static ssize_t ir_raw_store(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct=
 device_attribute *attr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const =
char *buf,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size_t=
 count)
>> +{
>> + =A0 =A0 struct ir_device *ir =3D to_input_dev(dev)->ir;
>> + =A0 =A0 long delta;
>> + =A0 =A0 int i =3D count;
>> + =A0 =A0 int first =3D 0;
>> +
>> + =A0 =A0 if (!ir->xmit)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return count;
>> + =A0 =A0 ir->send.count =3D 0;
>> +
>> + =A0 =A0 while (i > 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 i -=3D strict_strtoul(&buf[i], i, &delta);
>> + =A0 =A0 =A0 =A0 =A0 =A0 while ((buf[i] !=3D '\n') && (i > 0))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i--;
>> + =A0 =A0 =A0 =A0 =A0 =A0 i--;
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* skip leading zeros */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((delta > 0) && !first)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 ir->send.buffer[ir->send.count++] =3D abs(=
delta);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ir->xmit(ir->private, ir->send.buffer, ir->send.count, ir-=
>raw.carrier, ir->raw.xmitter);
>> +
>> + =A0 =A0 return count;
>> +}
>
> What type of data are you expecting here? =A0More than one value?
>
> thanks,
>
> greg k-h
>



--=20
Jon Smirl
jonsmirl@gmail.com
