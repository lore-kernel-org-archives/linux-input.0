From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v5 2/2] input: samsung-keypad: Add device tree support
Date: Tue, 27 Dec 2011 23:28:38 -0800
Message-ID: <CAOesGMic39gaYt9rsyebBJDS=cKAmmOP1BdunzAEiL+wcf0HKQ@mail.gmail.com>
References: <1318264197-6698-1-git-send-email-thomas.abraham@linaro.org>
	<1318264197-6698-3-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1318264197-6698-3-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: devicetree-discuss@lists.ozlabs.org, dmitry.torokhov@gmail.com, grant.likely@secretlab.ca, linux-input@vger.kernel.org, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jy0922.shim@samsung.com, dh09.lee@samsung.com, patches@linaro.org
List-Id: linux-input@vger.kernel.org

Hi,

I came across this searching for other proposed device tree bindings
based on what I wanted to do for Tegra.

Comments below.

On Mon, Oct 10, 2011 at 9:29 AM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:

> +- Keys represented as child nodes: Each key connected to the keypad
> + =A0controller is represented as a child node to the keypad controll=
er
> + =A0device node and should include the following properties.
> + =A0- keypad,row: the row number to which the key is connected.
> + =A0- keypad,column: the column number to which the key is connected=
=2E
> + =A0- linux,code: the key-code to be reported when the key is presse=
d
> + =A0 =A0and released.

[...]
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 key_1 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad,row =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad,column =3D <3>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 linux,code =3D <2>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 key_2 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad,row =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad,column =3D <4>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 linux,code =3D <3>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 key_3 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad,row =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad,column =3D <5>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 linux,code =3D <4>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };


The above is good if all you want to specify is a few keys. If you
want a full keyboard specification, it gets very verbose.

I would prefer a simpler binding, something along the lines of:

linux,keymap =3D < row col code ... >;

Where it's just an array of the above, so your example would be:
linux,keymap =3D < 0 3 2
                 0 4 3
                 0 5 4 >;

Same amount of data, it would be more or less as easy to read but a
_much_ more compact representation when you need to provide 100+ keys.


-Olof
