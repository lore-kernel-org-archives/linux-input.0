From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] input: samsung-keypad: Add device tree support
Date: Wed, 14 Sep 2011 11:13:18 -0600
Message-ID: <20110914171318.GA24425@ponder.secretlab.ca>
References: <1315916779-21793-1-git-send-email-thomas.abraham@linaro.org>
 <1315916779-21793-2-git-send-email-thomas.abraham@linaro.org>
 <1315916779-21793-3-git-send-email-thomas.abraham@linaro.org>
 <20110914161144.GF3134@ponder.secretlab.ca>
 <CAJuYYwSNaVCnHFTMtW0RZLGLaS+iKBibWYwn5mqNT-0EW31yAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJuYYwSNaVCnHFTMtW0RZLGLaS+iKBibWYwn5mqNT-0EW31yAQ@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: devicetree-discuss@lists.ozlabs.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jy0922.shim@samsung.com, dh09.lee@samsung.com
List-Id: linux-input@vger.kernel.org

On Wed, Sep 14, 2011 at 10:19:22PM +0530, Thomas Abraham wrote:
> Hi Grant,
>=20
> On 14 September 2011 21:41, Grant Likely <grant.likely@secretlab.ca> =
wrote:
> > On Tue, Sep 13, 2011 at 05:56:19PM +0530, Thomas Abraham wrote:
> >> Add device tree based discovery support for Samsung's keypad contr=
oller.
> >>
> >> Cc: Joonyoung Shim <jy0922.shim@samsung.com>
> >> Cc: Donghwa Lee <dh09.lee@samsung.com>
> >> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> >> ---
> >> =A0.../devicetree/bindings/input/samsung-keypad.txt =A0 | =A0 88 +=
+++++++++
> >> =A0drivers/input/keyboard/samsung-keypad.c =A0 =A0 =A0 =A0 =A0 =A0=
| =A0177 ++++++++++++++++++--
> >> =A02 files changed, 253 insertions(+), 12 deletions(-)
> >> =A0create mode 100644 Documentation/devicetree/bindings/input/sams=
ung-keypad.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/input/samsung-keypa=
d.txt b/Documentation/devicetree/bindings/input/samsung-keypad.txt
> >> new file mode 100644
> >> index 0000000..e1c7237
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/input/samsung-keypad.txt
> >> @@ -0,0 +1,88 @@
> >> +* Samsung's Keypad Controller device tree bindings
> >> +
> >> +Samsung's Keypad controller is used to interface a SoC with a mat=
rix-type
> >> +keypad device. The keypad controller supports multiple row and co=
lumn lines.
> >> +A key can be placed at each intersection of a unique row and a un=
ique column.
> >> +The keypad controller can sense a key-press and key-release and r=
eport the
> >> +event using a interrupt to the cpu.
> >> +
> >> +Required SoC Specific Properties:
> >> +- compatible: should be one of the following
> >> + =A0- "samsung,s3c6410-keypad": For controllers compatible with s=
3c6410 keypad
> >> + =A0 =A0controller.
> >> + =A0- "samsung,s5pv210-keypad": For controllers compatible with s=
5pv210 keypad
> >> + =A0 =A0controller.
> >> +
> >> +- reg: physical base address of the controller and length of memo=
ry mapped
> >> + =A0region.
> >> +
> >> +- interrupts: The interrupt number to the cpu.
> >> +
> >> +Required Board Specific Properties:
> >> +- samsung,keypad-num-rows: Number of row lines connected to the k=
eypad
> >> + =A0controller.
> >> +
> >> +- samsung,keypad-num-columns: Number of column lines connected to=
 the
> >> + =A0keypad controller.
> >> +
> >> +- row-gpios: List of gpios used as row lines. The gpio specifier =
for
> >> + =A0this property depends on the gpio controller to which these r=
ow lines
> >> + =A0are connected.
> >> +
> >> +- col-gpios: List of gpios used as column lines. The gpio specifi=
er for
> >> + =A0this property depends on the gpio controller to which these c=
olumn
> >> + =A0lines are connected.
> >
> > I know we've got overlapping terminology here. =A0When you say GPIO=
s
> > here, does it refer to the pin multiplexing feature of the samsung
> > parts, and thus how the keypad controller IO is routed to the pins?
> > Or does the driver manipulate GPIO lines manually?
>=20
> It is intended to mean gpio and not the pinmux. But the way the gpio
> specifier is specified in the dts file, it includes information about
> both gpio number and the pin-control details. For instance, if 'gpa0'
> is a gpio controller (which includes pin-control functionality as wel=
l
> in the hardware), then the gpio specifier for the keypad would be as
> below.
>=20
> row-gpios =3D <&gpa0 0 3 3 0>,
>                  <&gpa0 1 3 3 0>;
>=20
> The syntax for the gpio specifier is
> <[phandle of gpio controller] [pin number within the gpio controller]
> [mux function] [pull up/down] [drive strength]>
>=20
> The keypad driver does not know or use the mux function, pull up/down
> and drive strength details. The driver would call of_get_gpio to get
> the linux gpio number and then do a gpio_request on that gpio number.
> The gpio dt support manges the pin-mux and other settings
> transparently for the keypad driver. So even though the gpio specifie=
r
> format changes, the dt support code for the driver does not change.
>=20
> The driver does not manipulate the gpios directly. It just requests
> for the gpio number and makes a note of the number to free it when th=
e
> driver unbinds.
>=20
> >
> > If it is pin multiplexing, then using the GPIO binding seems rather
> > odd. It may be entirely appropriate, but it will need to play well
> > with the pinmux stuff that linusw is working on.
>=20
> When pinmux/pin-ctrl functionality which linusw is developing is used
> for this driver, it would be a extension to this patch. The driver
> would request for the gpio and then use the pin-ctrl subsystem api to
> setup the pin-control. In that case, the gpio-specifier would change
> but that change would be break anything which this patch does.
>=20
> >
> >> +
> >> +- Keys represented as child nodes: Each key connected to the keyp=
ad
> >> + =A0controller is represented as a child node to the keypad contr=
oller
> >> + =A0device node and should include the following properties.
> >> + =A0- keypad,row: the row number to which the key is connected.
> >> + =A0- keypad,column: the column number to which the key is connec=
ted.
> >> + =A0- keypad,key-code: the key-code to be reported when the key i=
s pressed
> >> + =A0 =A0and released.
> >
> > What defines the meanings of the key codes?
>=20
> The key-code could be any value which the system would want the keypa=
d
> driver to report when that key is pressed.

Are they linux keycodes?  If so, then this property name can
probably be linux,code.  There is already precedence for that
usage in Documentation/devicetree/bindings/gpio/gpio-keys.txt.  (I
would personally prefer "linux,key-code", but sometimes it is better
to go with existing precidence) You could also use linux,input-type as
specified in that binding.

>=20
> >
> >> +
> >> +Optional Properties specific to linux:
> >> +- linux,keypad-no-autorepeat: do no enable autorepeat feature.
> >> +- linux,keypad-wakeup: use any event on keypad as wakeup event.
> >
> > Is this really a linux-specific feature?
>=20
> Yes, it is a property defined by the linux subsystems. A non-linux
> system might not have such features.

I was specifically referring to the wakeup property, but okay, I can
see the argument that it is linux-specific because it is usage-policy
related.

g.
