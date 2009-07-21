From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: Support for synaptic touchscreen in HTC dream
Date: Tue, 21 Jul 2009 16:04:41 +0530
Message-ID: <5d5443650907210334k3f562cebsc665511a161c8639@mail.gmail.com>
References: <20090714100634.GA4054@elf.ucw.cz>
	 <5d5443650907140320w334864f4uc1ee13ed32fdb874@mail.gmail.com>
	 <20090715133627.GA2538@elf.ucw.cz>
	 <5d5443650907151033w36008b71pe4b32bcea9489b75@mail.gmail.com>
	 <20090721102153.GE4133@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:9281 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755154AbZGUKem convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jul 2009 06:34:42 -0400
In-Reply-To: <20090721102153.GE4133@elf.ucw.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Arve Hj?nnev?g <arve@android.com>, kernel list <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, dmitry.torokhov@gmail.com, dtor@mail.ru, linux-input@vger.kernel.org, Andrew Morton <akpm@osdl.org>, linux-i2c@vger.kernel.org

Hi Pavel,

On Tue, Jul 21, 2009 at 3:51 PM, Pavel Machek<pavel@ucw.cz> wrote:
> Hi!
>
>> >> disable_irq_nosync or convert this to request_threaded_irq(...).
>> >> Please see recent discussion on linux-input for MAX key switch
>> >> controller.
>> >
>> > Do you have a link? (I replaced it with disable_irq_nosync, if tha=
t is
>> > enough...)
>> >
>>
>> link: http://patchwork.kernel.org/patch/35515/
>
> Thanks!
>
>> >> > + =A0 =A0 =A0 if (!i2c_check_functionality(client->adapter, I2C=
_FUNC_I2C)) {
>> >>
>> >> check for SMBUS? I have added linux-i2c as this driver has i2c bi=
ts,
>> >> so not removing any code.
>> >
>> > I guess this driver is only probed on mach-pxa... on machines that
>> > have the neccessary hardware.
>>
>> Because this driver is using smbus i2c apis, it will be good to add
>> that check too.
>
> So I should do something like
>
> if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DAT=
A))
> =A0 =A0 =A0 =A0...
>
> in addition?

Yes.



--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
