From: "Joey Lee" <jlee@novell.com>
Subject: Re: [PATCH 0/4] Add new wmi support to acer-wmi driver
Date: Sun, 05 Dec 2010 18:37:23 -0700
Message-ID: <4CFCD9030200002300024FBA@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
Sender: platform-driver-x86-owner@vger.kernel.org
To: cascardo@holoscopio.com
Cc: corentin.chary@gmail.com, dmitry.torokhov@gmail.com, corentincj@iksaif.net, Takashi Iwai <tiwai@novell.com>, mjg@redhat.com, mjg59@srcf.ucam.org, carlos@strangeworlds.co.uk, jbenc@suse.cz, jdelvare@suse.de, trenn@suse.de, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Cascardo,=20

=E6=96=BC =E5=85=AD=EF=BC=8C2010-12-04 =E6=96=BC 09:08 -0200=EF=BC=8CTh=
adeu Lima de Souza Cascardo =E6=8F=90=E5=88=B0=EF=BC=9A
> On Sat, Dec 04, 2010 at 09:03:22AM +0800, Lee, Chun-Yi wrote:
> > Hi Matthew,=20
> >=20
> > These patches add new wmi support to acer-wmi driver, included the =
following
> > functions:
> >=20
> > - Acer wmi hotkey events:
> >   Acer BIOS applied wmi hotkey events from 2010, this patch adds su=
pport.
> >=20
> > - Enabled Acer Launch Manager mode:
> >   Directly enable it to avoid the raw EC behavior conflict with rfk=
ill-input or
> >   userland solution.
> >=20
> > - Add 3G rfkill sysfs file:
> >   Provide interface to userland for enable/disable 3G function by w=
mi method.
> >=20
> > - Detect the WiFi/Bluetooth/3G devices available:
> >   Look for OEM type AAh in dmi to get the WiFi/BT/3G devices availa=
ble.
> >=20
>=20
> Please, add a subsystem/driver prefix to the summary like:
>=20
> acer-wmi: Add 3G rfkill sysfs file.
>=20
> Otherwise, any person reading summaries will ask perself: adding such
> file to what!?!
>=20
> Regards,
> Cascardo.
>=20

Thank's for your suggestion, I will add driver prefix to the summary an=
d
send this serial again.

Joey Lee

> > Signed-off-by: Lee, Chun-Yi <jlee@novell.com>
> > Reviewed-by: Thomas Renninger <trenn@suse.de>
> >=20
> > Lee, Chun-Yi (4):
> >   Add acer wmi hotkey events support
> >   Enabled Acer Launch Manager mode
> >   Add 3G rfkill sysfs file
> >   Detect the WiFi/Bluetooth/3G devices available
> >=20
> >  drivers/platform/x86/Kconfig    |    2 +
> >  drivers/platform/x86/acer-wmi.c |  400 +++++++++++++++++++++++++++=
+++++++++++-
> >  2 files changed, 394 insertions(+), 8 deletions(-)
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe platform-=
driver-x86" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
