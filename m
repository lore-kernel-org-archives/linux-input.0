From: Jonathan Cameron <jic23-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>
Subject: Re: [PATCH] iio: hid: hid-sensor-accel-3d: Add second ACC sensor support
Date: Fri, 17 Mar 2017 13:31:13 +0000
Message-ID: <3CBCE111-2686-4B23-9CB2-E9888FE6427D@jic23.retrosnub.co.uk>
References: <1489659652-35608-1-git-send-email-hongyan.song@intel.com> <1489716812.10281.4.camel@intel.com> <1489756594.18490.22.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1489756594.18490.22.camel-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, "Pandruvada, Srinivas" <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Song, Hongyan" <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org



On 17 March 2017 13:16:34 GMT+00:00, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org> wrote:
>On Fri, 2017-03-17 at 02:13 +0000, Pandruvada, Srinivas wrote:
>> On Thu, 2017-03-16 at 18:20 +0800, Song Hongyan wrote:
>> > As accelerometer sensor becomes more and more popular, there are
>> > more
>> > user scenarios have been developed, "Hinge" is a very important
>> > usecase
>> > which needs two accelerometer sensors to calculate the included
>> > angle
>> > of keyboard and screen.
>> > In this case, two accelerometer sensors will be exposed. Currently,
>> > IIO interface hasn't other way to distinguish two sensors with same
>> > sensor type, except sensor name. So a new sensor name
>> > "accel_2nd_3d"
>> > is added for secondary accelerometer sensor.
>> 
>> This type of interface will not satisfy all cases. We have some hubs
>> with  many accelerometers attached. Same case is also true even for
>> discrete sensors. So there should be some framework way to expose
>> location of sensors.
>
>So you're nacking as well?
>
>> ACPI has special method called _PLD (Physical Device Location), which
>> can  be used to specify location of any device. So we need to be able
>> to export such information to user space. We can add for each sensor
>> the location information.
>> 
>> I can propose some ABI for exporting location information.
>
>There were patches floating around to do this, but they were never
>finished:
>http://www.spinics.net/lists/linux-acpi/msg51540.html

We have the location element as defined for the cross_ec sensors.  Taking that general would be fine with me.

 Current options are base and lid, but can be extended to include more.

J
>
>Cheers
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
