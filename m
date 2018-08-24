From: "dbasehore ." <dbasehore@chromium.org>
Subject: Re: [PATCH] Input: elants_i2c - Fix sw reset delays
Date: Fri, 24 Aug 2018 16:10:17 -0700
Message-ID: <CAGAzgsoxZBxFsy7_yhb_VCDXzsseRr6eU8wuUB91JFYdCSh49A@mail.gmail.com>
References: <20180823231013.254037-1-dbasehore@chromium.org>
 <20180823233028.GC53155@dtor-ws> <20180823233211.GD53155@dtor-ws>
 <20180823233424.GE53155@dtor-ws> <20180824084933.GA29856@jack.zhora.eu> <CAGAzgsqhTbgB2vAYDLMUFvuJ7F4pqHxRp+Xo+iny8g9ghTYM6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGAzgsqhTbgB2vAYDLMUFvuJ7F4pqHxRp+Xo+iny8g9ghTYM6g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: andi@etezian.org
Cc: dmitry.torokhov@gmail.com, johnny.chuang@emc.com.tw, linux-kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, joe@perches.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, james.chen@emc.com.tw, kt.liao@emc.com.tw
List-Id: linux-input@vger.kernel.org

On Fri, Aug 24, 2018 at 4:07 PM dbasehore . <dbasehore@chromium.org> wrote:
>
>
>
> On Fri, Aug 24, 2018 at 1:49 AM Andi Shyti <andi@etezian.org> wrote:
>>
>> Hi Derek,
>>
>> > > > On Thu, Aug 23, 2018 at 04:10:13PM -0700, Derek Basehore wrote:
>> > > > > We only need to wait 10ms instead of 30ms before starting fastbo=
ot or
>> > > > > sending IAP on the touchscreen. Also, instead of delaying everyt=
ime
>> > > > > sw_reset is called, this delays 10ms in the function that starts
>> > > > > fastboot. There's also an explicit 20ms delay before sending IAP=
 when
>> > > > > updating the firmware, so no additional delay is needed there. T=
his
>> > > > > change also has the benefit of not delaying when wakeup is enabl=
ed
>> > > > > during suspend. This is because sw_reset is called, yet fastboot
>> > > > > isn't.
>>
>> ...
>>
>> > > > > -       /*
>> > > > > -        * We should wait at least 10 msec (but no more than 40)=
 before
>> > > > > -        * sending fastboot or IAP command to the device.
>> > > > > -        */
>> > > > > -       msleep(30);
>> > > > > -
>>
>> moving from 30 to 0 is a bit alarming... what does the datasheet
>> say?
>
>
> We're moving from 30msec to 10msec. We used to do this in an older kernel=
.
>
>>
>>
>> Sometimes delays are implicit in the system where you are testing
>> the driver, so that without any msleep it might work in your
>> system but it might not on others.
>>
>> > +             /*
>> > +              * We should wait at least 10 msec (but no more than 40)=
 before
>> > +              * sending IAP command to the device.
>> > +              */
>> >               msleep(20);
>>
>> I agree though that it's not nice to wait twice here (even though
>> as Dmitry says it doesn't hurt so much). Wouldn't it make more
>> sense to remove this msleep instead?
>> This way...
>
>
> We still need this if the delay is removed from the sw_reset function. We=
 have a total of 20msecs delayed between sw_reset and sending IAP in our ol=
d kernel which should be well tested. There seems to be no reason why the d=
elays increased.
>
>>
>>
>> > +     /*
>> > +      * We should wait at least 10 msec (but no more than 40) before =
sending
>> > +      * fastboot command to the device.
>> > +      */
>> > +     usleep_range(10 * 1000, 11 * 1000);
>> > +
>> >       error =3D elants_i2c_send(client, boot_cmd, sizeof(boot_cmd));
>>
>> ... you do not need to add an extra sleep here.
>
>
> I added it here since I removed the 30msec sleep in sw_reset. This preven=
ts us from sleeping on resume when the touch controller is already on for w=
ake up capabilities. This is the same delay that we have in our old 3.8 ker=
nel, so it's pretty well tested and shipped in production.
>
>>
>>
>> Andi

Resending since it seems my plain text setting was removed...
