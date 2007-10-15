From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH try #3] Input/Joystick Driver: add support AD7142
 joystick driver
Date: Mon, 15 Oct 2007 21:35:41 +0200
Message-ID: <20071015213541.25bac062@hyperion.delvare>
References: <1192459625.6215.17.camel@roc-laptop>
	<d120d5000710150848t1993b0aavbbc0cd7971e3ef3e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000710150848t1993b0aavbbc0cd7971e3ef3e@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: bryan.wu@analog.com, Andrey Panin <pazke@donpac.ru>, Roel Kluin <12o3l@tiscali.nl>, "Ahmed S. Darwish" <darwish.07@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz, linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-input@vger.kernel.org

On Mon, 15 Oct 2007 11:48:17 -0400, Dmitry Torokhov wrote:
> On 10/15/07, Bryan Wu <bryan.wu@analog.com> wrote:
> > +static int __init ad7142_init(void)
> > +{
> > +       return i2c_add_driver(&ad7142_driver);
> > +}
> > +
> > +static void __exit ad7142_exit(void)
> > +{
> > +       i2c_del_driver(&ad7142_driver);
> > +       input_unregister_device(ad7142_dev);
> 
> input_unregister_device() should be in ad7142_detach_client? I am not
> sure i2c - there seems to be 2 interface styles and you probably need
> to use the new one. I am CC-inj Jean on this.

The new style is preferred, yes.

-- 
Jean Delvare
