From: David Ellingsworth <david@identd.dyndns.org>
Subject: Re: question about v4l2_subdev
Date: Tue, 1 Jun 2010 16:56:01 -0400
Message-ID: <AANLkTil-_h_DwGxRzRqtDQc1Q4weQ2ffNQ9LBoxA1cdk@mail.gmail.com>
References: <4C03D80B.5090009@atmel.com>
	<1275329947.2261.19.camel@localhost>
	<4C04C17D.8020702@atmel.com>
	<4C05135D.1080108@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <4C05135D.1080108@atmel.com>
Sender: linux-media-owner@vger.kernel.org
To: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Cc: Andy Walls <awalls@md.metrocast.net>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Linux Media Mailing List <linux-media@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Jun 1, 2010 at 10:04 AM, Sedji Gaouaou <sedji.gaouaou@atmel.com> wrote:
> Hi,
>
> Sorry to bother you again, but here is the situation:
> I have 2 drivers: an ov2640 driver and my atmel driver.
> Basically the ov2640 driver is the same as the ov7670 driver.
>
> So what I don't know is how to call the ov2640 functions(such as set format)
> in my atmel driver.
>
> In the ov2640 I used the function: v4l2_i2c_subdev_init, and in the atmel
> driver I used v4l2_device_register.
>
> But I don't know where I should use the v4l2_i2c_new_subdev function, and
> how to link my atmel video struct to the i2c sensor.
>
> Is there any examples in linux?
>
> Regards,
> Sedji
>

If I understand what you're saying, ov2640 and ovv7670 are both video
drivers but they have shared functionality. If the shared
functionality is in the form of controlling say an i2c device of some
sorts then you should implement that functionality as a subdev.
Otherwise, you should extract the shared functionality into its own
module that can be utilized by both drivers (there are many examples
of this within the kernel).

Regards,

David Ellingsworth
