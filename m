From: "Bryan Wu" <cooloney.lkml@gmail.com>
Subject: Re: [PATCH try #4] Input/Joystick Driver: add support AD7142 joystick driver
Date: Wed, 17 Oct 2007 23:35:49 +0800
Message-ID: <386072610710170835j20d88feej2b107c8e8b686e89@mail.gmail.com>
References: <1192605120.7920.15.camel@roc-laptop>
	 <20071017160702.3316fc24@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20071017160702.3316fc24@hyperion.delvare>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jean Delvare <khali@linux-fr.org>
Cc: bryan.wu@analog.com, Andrey Panin <pazke@donpac.ru>, Roel Kluin <12o3l@tiscali.nl>, "Ahmed S. Darwish" <darwish.07@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz, linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-input@vger.kernel.org

On 10/17/07, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Bryan,
>
> On Wed, 17 Oct 2007 15:12:00 +0800, Bryan Wu wrote:
> > Subject: [PATCH try #4] Input/Joystick Driver: add support AD7142 joystick driver
>
> This driver is a good candidate for the new-style i2c infrastructure.
> Instead of letting i2c-core probe for the device on all available I2C
> buses, you would explicitly instantiate it from platform data. In
> practice this would mean:
> * Declare the ad7142 in platform data.
> * Call i2c_register_board_info() on that data.
> * In your ad7142 driver, implement .probe and .remove instead
>   of .attach_adapter and .detach_client.
>
I would like to rewrite it by using new-style i2c infrastructure.
But it will take some time. If I meet some problem, hope can get some advice
from you and the community.

> Of course this assumes that the underlying bus driver is also new-style
> ready (i.e. it uses i2c_add_numbered_adapter() instead of
> i2c_add_adapter()), and that you know in advance when the AD7142 is
> there or not. I hope this is the case?
>
Oh, currently i2c-bfin-twi driver is using the old-style code.

> Using a new-style i2c driver is especially important if the device
> can't be detected.
>
> Also see my i2c-related comments inline.
>

I will fix all the issues and try to pass our Blackfin AD7142 Joystick testcase.
and resubmit a patch.

Thanks
-Bryan

[!snip!]
