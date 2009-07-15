From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Support for synaptic touchscreen in HTC dream
Date: Wed, 15 Jul 2009 14:33:32 -0700
Message-ID: <d6200be20907151433q2f1ddc61m13c258c06ca4fd76@mail.gmail.com>
References: <20090714100634.GA4054@elf.ucw.cz>
	 <5d5443650907140320w334864f4uc1ee13ed32fdb874@mail.gmail.com>
	 <20090715133627.GA2538@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090715133627.GA2538-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Trilok Soni <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Swetland <swetland-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dtor-JGs/UdohzUI@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, Jul 15, 2009 at 6:36 AM, Pavel Machek<pavel-+ZI9xUNit7I@public.gmane.org> wrote:
> Hi!
>
>> > +static void decode_report(struct synaptics_ts_data *ts, u8 *buf)
>> > +{
>>
>> some documentation about this logic would be great.
>
> Arve, can you help here?

This sensor sends two 6-byte absolute finger reports, an optional
2-byte relative report followed by a status byte
(http://www.synaptics.com/sites/default/files/511_000099_01F.pdf).
This function reads the two finger reports and transforms the
coordinates according the platform data so they can be aligned with
the lcd behind the touchscreen. typically we flip the y-axis since the
sensor uses the bottom left corner as the origin, but if the sensor is
mounted upside down the platform data will request that the x-axis
should be flipped instead. The snap to inactive edge border are used
to allow tapping the edges of the screen on the G1. The active area of
the touchscreen is smaller than the lcd. When the finger gets close
the edge of the screen we snap it to the edge. This allows ui elements
at the edge of the screen to be hit, and it prevents hitting ui
elements that are not at the edge of the screen when the finger is
touching the edge.

--=20
Arve Hj=F8nnev=E5g
