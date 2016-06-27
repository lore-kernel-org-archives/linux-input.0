From: Tony Felice <tony.felice@timesys.com>
Subject: Re: [PATCH 1/4] ARM: dts: vf610-twr: Enable display controller
Date: Mon, 27 Jun 2016 13:11:46 -0400
Message-ID: <CANcVtcg-rADXvw7yXRi1nVEjBEG=wGx6RBZdQNDTnBdzuH1rPw@mail.gmail.com>
References: <1466797486-31558-1-git-send-email-tony.felice@timesys.com>
 <1466797486-31558-2-git-send-email-tony.felice@timesys.com>
 <80c8e7b31ed47dbc419937a281b4b7c5@agner.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0164486278=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <80c8e7b31ed47dbc419937a281b4b7c5@agner.ch>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Stefan Agner <stefan@agner.ch>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, maitysanchayan@gmail.com, damien.riegel@savoirfairelinux.com, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, linux@armlinux.org.uk, dri-devel@lists.freedesktop.org, sre@kernel.org, mwelling@ieee.org, robh+dt@kernel.org, geert@linux-m68k.org, kernel@pengutronix.de, linux-input@vger.kernel.org, fabio.estevam@nxp.com, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

--===============0164486278==
Content-Type: multipart/alternative; boundary=94eb2c0b61e8d140df0536459f69

--94eb2c0b61e8d140df0536459f69
Content-Type: text/plain; charset=UTF-8

Hi Stefan,

Yes, these changes do work for the Tower board!

-Tony

On Sat, Jun 25, 2016 at 4:53 PM, Stefan Agner <stefan@agner.ch> wrote:

> On 2016-06-24 12:44, Anthony Felice wrote:
> > This adds nodes to enable tcon0 and dcu0 for the Vybrid Tower. These
> > are used to drive the Vybrid Tower TWR-LCD-RGB display. Also, a node
> > for the nec nl4827hc19-05b panel on the TWR-LCD-RGB display has been
> > added.
>
> So my pixel clock polarity changes which will be part of 4.7 work for
> Tower? I could never actually test that since I don't have the display
> here...
> https://patchwork.kernel.org/patch/8874971/
>
> This patch looks good to me:
> Acked-by: Stefan Agner <stefan@agner.ch>
>
> --
> Stefan
>
> >
> > Signed-off-by: Anthony Felice <tony.felice@timesys.com>
> > ---
> >  arch/arm/boot/dts/vf610-twr.dts | 48
> +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/vf610-twr.dts
> b/arch/arm/boot/dts/vf610-twr.dts
> > index cdc1007..ad1aff9 100644
> > --- a/arch/arm/boot/dts/vf610-twr.dts
> > +++ b/arch/arm/boot/dts/vf610-twr.dts
> > @@ -66,6 +66,10 @@
> >               clock-frequency = <50000000>;
> >       };
> >
> > +     panel: panel {
> > +             compatible = "nec,nl4827hc19-05b";
> > +     };
> > +
> >       regulators {
> >               compatible = "simple-bus";
> >               #address-cells = <1>;
> > @@ -134,6 +138,13 @@
> >                                <&clks VF610_CLK_ENET_EXT>;
> >  };
> >
> > +&dcu0 {
> > +     fsl,panel = <&panel>;
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&pinctrl_dcu0>;
> > +     status = "okay";
> > +};
> > +
> >  &dspi0 {
> >       bus-num = <0>;
> >       pinctrl-names = "default";
> > @@ -210,6 +221,39 @@
> >
> >  &iomuxc {
> >       vf610-twr {
> > +             pinctrl_dcu0: dcu0grp {
> > +                     fsl,pins = <
> > +                             VF610_PAD_PTE0__DCU0_HSYNC      0x42
> > +                             VF610_PAD_PTE1__DCU0_VSYNC      0x42
> > +                             VF610_PAD_PTE2__DCU0_PCLK       0x42
> > +                             VF610_PAD_PTE4__DCU0_DE         0x42
> > +                             VF610_PAD_PTE5__DCU0_R0         0x42
> > +                             VF610_PAD_PTE6__DCU0_R1         0x42
> > +                             VF610_PAD_PTE7__DCU0_R2         0x42
> > +                             VF610_PAD_PTE8__DCU0_R3         0x42
> > +                             VF610_PAD_PTE9__DCU0_R4         0x42
> > +                             VF610_PAD_PTE10__DCU0_R5        0x42
> > +                             VF610_PAD_PTE11__DCU0_R6        0x42
> > +                             VF610_PAD_PTE12__DCU0_R7        0x42
> > +                             VF610_PAD_PTE13__DCU0_G0        0x42
> > +                             VF610_PAD_PTE14__DCU0_G1        0x42
> > +                             VF610_PAD_PTE15__DCU0_G2        0x42
> > +                             VF610_PAD_PTE16__DCU0_G3        0x42
> > +                             VF610_PAD_PTE17__DCU0_G4        0x42
> > +                             VF610_PAD_PTE18__DCU0_G5        0x42
> > +                             VF610_PAD_PTE19__DCU0_G6        0x42
> > +                             VF610_PAD_PTE20__DCU0_G7        0x42
> > +                             VF610_PAD_PTE21__DCU0_B0        0x42
> > +                             VF610_PAD_PTE22__DCU0_B1        0x42
> > +                             VF610_PAD_PTE23__DCU0_B2        0x42
> > +                             VF610_PAD_PTE24__DCU0_B3        0x42
> > +                             VF610_PAD_PTE25__DCU0_B4        0x42
> > +                             VF610_PAD_PTE26__DCU0_B5        0x42
> > +                             VF610_PAD_PTE27__DCU0_B6        0x42
> > +                             VF610_PAD_PTE28__DCU0_B7        0x42
> > +                     >;
> > +             };
> > +
> >               pinctrl_adc0_ad5: adc0ad5grp {
> >                       fsl,pins = <
> >                               VF610_PAD_PTC30__ADC0_SE5
>  0xa1
> > @@ -370,6 +414,10 @@
> >       status = "okay";
> >  };
> >
> > +&tcon0 {
> > +     status = "okay";
> > +};
> > +
> >  &uart1 {
> >       pinctrl-names = "default";
> >       pinctrl-0 = <&pinctrl_uart1>;
>



-- 
Tony Felice
Support Engineering Manager
Timesys Corporation

--94eb2c0b61e8d140df0536459f69
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PkhpIFN0ZWZhbiw8YnI+PGJyPjwvZGl2PlllcywgdGhl
c2UgY2hhbmdlcyBkbyB3b3JrIGZvciB0aGUgVG93ZXIgYm9hcmQhPGJyPjxicj48L2Rpdj4tVG9u
eTxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+PGJyPjxkaXYgY2xhc3M9ImdtYWls
X3F1b3RlIj5PbiBTYXQsIEp1biAyNSwgMjAxNiBhdCA0OjUzIFBNLCBTdGVmYW4gQWduZXIgPHNw
YW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86c3RlZmFuQGFnbmVyLmNoIiB0YXJnZXQ9
Il9ibGFuayI+c3RlZmFuQGFnbmVyLmNoPC9hPiZndDs8L3NwYW4+IHdyb3RlOjxicj48YmxvY2tx
dW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXIt
bGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij48c3BhbiBjbGFzcz0iIj5PbiAy
MDE2LTA2LTI0IDEyOjQ0LCBBbnRob255IEZlbGljZSB3cm90ZTo8YnI+DQomZ3Q7IFRoaXMgYWRk
cyBub2RlcyB0byBlbmFibGUgdGNvbjAgYW5kIGRjdTAgZm9yIHRoZSBWeWJyaWQgVG93ZXIuIFRo
ZXNlPGJyPg0KJmd0OyBhcmUgdXNlZCB0byBkcml2ZSB0aGUgVnlicmlkIFRvd2VyIFRXUi1MQ0Qt
UkdCIGRpc3BsYXkuIEFsc28sIGEgbm9kZTxicj4NCiZndDsgZm9yIHRoZSBuZWMgbmw0ODI3aGMx
OS0wNWIgcGFuZWwgb24gdGhlIFRXUi1MQ0QtUkdCIGRpc3BsYXkgaGFzIGJlZW48YnI+DQomZ3Q7
IGFkZGVkLjxicj4NCjxicj4NCjwvc3Bhbj5TbyBteSBwaXhlbCBjbG9jayBwb2xhcml0eSBjaGFu
Z2VzIHdoaWNoIHdpbGwgYmUgcGFydCBvZiA0Ljcgd29yayBmb3I8YnI+DQpUb3dlcj8gSSBjb3Vs
ZCBuZXZlciBhY3R1YWxseSB0ZXN0IHRoYXQgc2luY2UgSSBkb24mIzM5O3QgaGF2ZSB0aGUgZGlz
cGxheTxicj4NCmhlcmUuLi48YnI+DQo8YSBocmVmPSJodHRwczovL3BhdGNod29yay5rZXJuZWwu
b3JnL3BhdGNoLzg4NzQ5NzEvIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRw
czovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzg4NzQ5NzEvPC9hPjxicj4NCjxicj4NClRo
aXMgcGF0Y2ggbG9va3MgZ29vZCB0byBtZTo8YnI+DQpBY2tlZC1ieTogU3RlZmFuIEFnbmVyICZs
dDs8YSBocmVmPSJtYWlsdG86c3RlZmFuQGFnbmVyLmNoIj5zdGVmYW5AYWduZXIuY2g8L2E+Jmd0
Ozxicj4NCjxicj4NCi0tPGJyPg0KU3RlZmFuPGJyPg0KPGRpdiBjbGFzcz0iSE9FblpiIj48ZGl2
IGNsYXNzPSJoNSI+PGJyPg0KJmd0Ozxicj4NCiZndDsgU2lnbmVkLW9mZi1ieTogQW50aG9ueSBG
ZWxpY2UgJmx0OzxhIGhyZWY9Im1haWx0bzp0b255LmZlbGljZUB0aW1lc3lzLmNvbSI+dG9ueS5m
ZWxpY2VAdGltZXN5cy5jb208L2E+Jmd0Ozxicj4NCiZndDsgLS0tPGJyPg0KJmd0O8KgIGFyY2gv
YXJtL2Jvb3QvZHRzL3ZmNjEwLXR3ci5kdHMgfCA0OCArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKzxicj4NCiZndDvCoCAxIGZpbGUgY2hhbmdlZCwgNDggaW5zZXJ0aW9u
cygrKTxicj4NCiZndDs8YnI+DQomZ3Q7IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy92
ZjYxMC10d3IuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvdmY2MTAtdHdyLmR0czxicj4NCiZndDsg
aW5kZXggY2RjMTAwNy4uYWQxYWZmOSAxMDA2NDQ8YnI+DQomZ3Q7IC0tLSBhL2FyY2gvYXJtL2Jv
b3QvZHRzL3ZmNjEwLXR3ci5kdHM8YnI+DQomZ3Q7ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3Zm
NjEwLXR3ci5kdHM8YnI+DQomZ3Q7IEBAIC02Niw2ICs2NiwxMCBAQDxicj4NCiZndDvCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGNsb2NrLWZyZXF1ZW5jeSA9ICZsdDs1MDAwMDAwMCZndDs7PGJyPg0K
Jmd0O8KgIMKgIMKgIMKgfTs8YnI+DQomZ3Q7PGJyPg0KJmd0OyArwqAgwqAgwqBwYW5lbDogcGFu
ZWwgezxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgY29tcGF0aWJsZSA9ICZxdW90O25l
YyxubDQ4MjdoYzE5LTA1YiZxdW90Ozs8YnI+DQomZ3Q7ICvCoCDCoCDCoH07PGJyPg0KJmd0OyAr
PGJyPg0KJmd0O8KgIMKgIMKgIMKgcmVndWxhdG9ycyB7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgY29tcGF0aWJsZSA9ICZxdW90O3NpbXBsZS1idXMmcXVvdDs7PGJyPg0KJmd0O8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgI2FkZHJlc3MtY2VsbHMgPSAmbHQ7MSZndDs7PGJyPg0KJmd0
OyBAQCAtMTM0LDYgKzEzOCwxMyBAQDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmbHQ7JmFtcDtjbGtzIFZGNjEwX0NMS19FTkVUX0VYVCZn
dDs7PGJyPg0KJmd0O8KgIH07PGJyPg0KJmd0Ozxicj4NCiZndDsgKyZhbXA7ZGN1MCB7PGJyPg0K
Jmd0OyArwqAgwqAgwqBmc2wscGFuZWwgPSAmbHQ7JmFtcDtwYW5lbCZndDs7PGJyPg0KJmd0OyAr
wqAgwqAgwqBwaW5jdHJsLW5hbWVzID0gJnF1b3Q7ZGVmYXVsdCZxdW90Ozs8YnI+DQomZ3Q7ICvC
oCDCoCDCoHBpbmN0cmwtMCA9ICZsdDsmYW1wO3BpbmN0cmxfZGN1MCZndDs7PGJyPg0KJmd0OyAr
wqAgwqAgwqBzdGF0dXMgPSAmcXVvdDtva2F5JnF1b3Q7Ozxicj4NCiZndDsgK307PGJyPg0KJmd0
OyArPGJyPg0KJmd0O8KgICZhbXA7ZHNwaTAgezxicj4NCiZndDvCoCDCoCDCoCDCoGJ1cy1udW0g
PSAmbHQ7MCZndDs7PGJyPg0KJmd0O8KgIMKgIMKgIMKgcGluY3RybC1uYW1lcyA9ICZxdW90O2Rl
ZmF1bHQmcXVvdDs7PGJyPg0KJmd0OyBAQCAtMjEwLDYgKzIyMSwzOSBAQDxicj4NCiZndDs8YnI+
DQomZ3Q7wqAgJmFtcDtpb211eGMgezxicj4NCiZndDvCoCDCoCDCoCDCoHZmNjEwLXR3ciB7PGJy
Pg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBwaW5jdHJsX2RjdTA6IGRjdTBncnAgezxicj4N
CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnNsLHBpbnMgPSAmbHQ7PGJy
Pg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBWRjYx
MF9QQURfUFRFMF9fRENVMF9IU1lOQ8KgIMKgIMKgIDB4NDI8YnI+DQomZ3Q7ICvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFZGNjEwX1BBRF9QVEUxX19EQ1UwX1ZT
WU5DwqAgwqAgwqAgMHg0Mjxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgVkY2MTBfUEFEX1BURTJfX0RDVTBfUENMS8KgIMKgIMKgIMKgMHg0Mjxi
cj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgVkY2
MTBfUEFEX1BURTRfX0RDVTBfREXCoCDCoCDCoCDCoCDCoDB4NDI8YnI+DQomZ3Q7ICvCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFZGNjEwX1BBRF9QVEU1X19EQ1Uw
X1IwwqAgwqAgwqAgwqAgwqAweDQyPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBWRjYxMF9QQURfUFRFNl9fRENVMF9SMcKgIMKgIMKgIMKgIMKg
MHg0Mjxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgVkY2MTBfUEFEX1BURTdfX0RDVTBfUjLCoCDCoCDCoCDCoCDCoDB4NDI8YnI+DQomZ3Q7ICvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFZGNjEwX1BBRF9QVEU4
X19EQ1UwX1IzwqAgwqAgwqAgwqAgwqAweDQyPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBWRjYxMF9QQURfUFRFOV9fRENVMF9SNMKgIMKgIMKg
IMKgIMKgMHg0Mjxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgVkY2MTBfUEFEX1BURTEwX19EQ1UwX1I1wqAgwqAgwqAgwqAgMHg0Mjxicj4NCiZn
dDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgVkY2MTBfUEFE
X1BURTExX19EQ1UwX1I2wqAgwqAgwqAgwqAgMHg0Mjxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgVkY2MTBfUEFEX1BURTEyX19EQ1UwX1I3wqAg
wqAgwqAgwqAgMHg0Mjxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgVkY2MTBfUEFEX1BURTEzX19EQ1UwX0cwwqAgwqAgwqAgwqAgMHg0Mjxicj4N
CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgVkY2MTBf
UEFEX1BURTE0X19EQ1UwX0cxwqAgwqAgwqAgwqAgMHg0Mjxicj4NCiZndDsgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgVkY2MTBfUEFEX1BURTE1X19EQ1UwX0cy
wqAgwqAgwqAgwqAgMHg0Mjxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgVkY2MTBfUEFEX1BURTE2X19EQ1UwX0czwqAgwqAgwqAgwqAgMHg0Mjxi
cj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgVkY2
MTBfUEFEX1BURTE3X19EQ1UwX0c0wqAgwqAgwqAgwqAgMHg0Mjxicj4NCiZndDsgK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgVkY2MTBfUEFEX1BURTE4X19EQ1Uw
X0c1wqAgwqAgwqAgwqAgMHg0Mjxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgVkY2MTBfUEFEX1BURTE5X19EQ1UwX0c2wqAgwqAgwqAgwqAgMHg0
Mjxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
VkY2MTBfUEFEX1BURTIwX19EQ1UwX0c3wqAgwqAgwqAgwqAgMHg0Mjxicj4NCiZndDsgK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgVkY2MTBfUEFEX1BURTIxX19E
Q1UwX0IwwqAgwqAgwqAgwqAgMHg0Mjxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgVkY2MTBfUEFEX1BURTIyX19EQ1UwX0IxwqAgwqAgwqAgwqAg
MHg0Mjxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgVkY2MTBfUEFEX1BURTIzX19EQ1UwX0IywqAgwqAgwqAgwqAgMHg0Mjxicj4NCiZndDsgK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgVkY2MTBfUEFEX1BURTI0
X19EQ1UwX0IzwqAgwqAgwqAgwqAgMHg0Mjxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgVkY2MTBfUEFEX1BURTI1X19EQ1UwX0I0wqAgwqAgwqAg
wqAgMHg0Mjxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgVkY2MTBfUEFEX1BURTI2X19EQ1UwX0I1wqAgwqAgwqAgwqAgMHg0Mjxicj4NCiZndDsg
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgVkY2MTBfUEFEX1BU
RTI3X19EQ1UwX0I2wqAgwqAgwqAgwqAgMHg0Mjxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgVkY2MTBfUEFEX1BURTI4X19EQ1UwX0I3wqAgwqAg
wqAgwqAgMHg0Mjxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmd0
Ozs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoH07PGJyPg0KJmd0OyArPGJyPg0KJmd0
O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcGluY3RybF9hZGMwX2FkNTogYWRjMGFkNWdycCB7PGJy
Pg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnNsLHBpbnMgPSAmbHQ7
PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
VkY2MTBfUEFEX1BUQzMwX19BREMwX1NFNcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMHhhMTxicj4N
CiZndDsgQEAgLTM3MCw2ICs0MTQsMTAgQEA8YnI+DQomZ3Q7wqAgwqAgwqAgwqBzdGF0dXMgPSAm
cXVvdDtva2F5JnF1b3Q7Ozxicj4NCiZndDvCoCB9Ozxicj4NCiZndDs8YnI+DQomZ3Q7ICsmYW1w
O3Rjb24wIHs8YnI+DQomZ3Q7ICvCoCDCoCDCoHN0YXR1cyA9ICZxdW90O29rYXkmcXVvdDs7PGJy
Pg0KJmd0OyArfTs8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7wqAgJmFtcDt1YXJ0MSB7PGJyPg0KJmd0
O8KgIMKgIMKgIMKgcGluY3RybC1uYW1lcyA9ICZxdW90O2RlZmF1bHQmcXVvdDs7PGJyPg0KJmd0
O8KgIMKgIMKgIMKgcGluY3RybC0wID0gJmx0OyZhbXA7cGluY3RybF91YXJ0MSZndDs7PGJyPg0K
PC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPjwvZGl2Pjxicj48YnIgY2xlYXI9ImFsbCI+PGJyPi0t
IDxicj48ZGl2IGNsYXNzPSJnbWFpbF9zaWduYXR1cmUiIGRhdGEtc21hcnRtYWlsPSJnbWFpbF9z
aWduYXR1cmUiPjxkaXYgZGlyPSJsdHIiPjxkaXY+PGRpdiBkaXI9Imx0ciI+PGRpdj5Ub255IEZl
bGljZTxicj5TdXBwb3J0IEVuZ2luZWVyaW5nIE1hbmFnZXI8YnI+PC9kaXY+VGltZXN5cyBDb3Jw
b3JhdGlvbjxicj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj4NCjwvZGl2Pg0K
--94eb2c0b61e8d140df0536459f69--

--===============0164486278==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0164486278==--
