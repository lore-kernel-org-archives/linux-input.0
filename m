From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: extend EV_LED
Date: Mon, 12 Feb 2007 13:31:52 -0500
Message-ID: <d120d5000702121031o1ea5ff20lf4e0946c8c1e2980@mail.gmail.com>
References: <45CEE9AB.2020208@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <45CEE9AB.2020208@freemail.hu>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 2/11/07, N=E9meth M=E1rton <nm127@freemail.hu> wrote:
>
> Extend EV_LED handling code so that it can handle not
> only two states (on/off) but also others. For example
> a LED can blink using hardware acceleration. The code
> changed so that it is similar to the code at EV_SND.
>

Hi,

I am not sure we would need this, could you explain what are you
trying to use input leds for?

Generally speaking leds within input subsystem are supposed to be very
simple on/off objects, mostly for reporting state of input devices
(keyboards), I am not even sure that LED_MAIL and LED_CHARGING make
much sense here. For more compex objects(blinking/different
colors/different brightness) we have a separate LED subsystem
(drivers/leds).

--=20
Dmitry
