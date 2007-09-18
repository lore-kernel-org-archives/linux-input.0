From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] xpad: fix Kconfig to avoid compile error
Date: Tue, 18 Sep 2007 13:52:11 -0400
Message-ID: <d120d5000709181052r6ee721d6r2d77d0f6b38a4398@mail.gmail.com>
References: <20070918090033.GB14882@devil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070918090033.GB14882@devil>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Andreas Herrmann <aherrman@arcor.de>
Cc: Jan Kratochvil <honza@jikos.cz>, linux-input@atrey.karlin.mff.cuni.cz, linux-joystick@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi Andreas,

On 9/18/07, Andreas Herrmann <aherrman@arcor.de> wrote:
> With LEDS_CLASS=m && JOYSTICK_XPAD_LEDS=y I get following compile error:
>
>    ...
>  LD      .tmp_vmlinux1
> drivers/built-in.o: In function `xpad_disconnect':
> xpad.c:(.text+0xb3d6b): undefined reference to `led_classdev_unregister'
> drivers/built-in.o: In function `xpad_probe':
> xpad.c:(.text+0xb48a6): undefined reference to `led_classdev_register'
> make: *** [.tmp_vmlinux1] Error 1
>    ...
>
> To avoid this kernel configuration, do auto-select LEDS_CLASS
> for JOYSTCK_XPAD_LEDS.
>

I'd rather it depend on LEDS_CLASS (but properly). I believe I posted
a patch yesterday.

-- 
Dmitry
