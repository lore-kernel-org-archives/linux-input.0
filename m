From: "Joey Lee" <jlee@novell.com>
Subject: Re: [PATCH 2/3] Support enable Acer Launch Manager mode
Date: Fri, 15 Oct 2010 02:02:01 -0600
Message-ID: <4CB8A5290200002300021E79@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: corentin.chary@gmail.com, Takashi Iwai <tiwai@novell.com>, Thomas Renninger <trenn@novell.com>, mjg59@srcf.ucam.org, carlos@strangeworlds.co.uk, jbenc@suse.cz, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org

Hi Dmitry,=20

=E6=96=BC =E4=B8=89=EF=BC=8C2010-10-13 =E6=96=BC 11:26 -0700=EF=BC=8CDm=
itry Torokhov =E6=8F=90=E5=88=B0=EF=BC=9A
> On Wed, Oct 13, 2010 at 11:47:41AM +0800, Lee, Chun-Yi wrote:
> > Add a launch_manager parameter for support to enable Acer Launch Ma=
nager
> > mode. After enable it, the communication key will stop the default
> > behavior to control WLAN/Bluetooth/WWAN rfkill state. It leave user=
nland
> > application to handle the rfkill state changed.
> >=20
>=20
> Why would user chose one setup over another? I.e do we really need a
> module option or maybe we should pick up behavior and stick to it?
>=20

When Acer notebook ship with Windows, they will preload a userland
application, the name is Launch Manager, it provide a GUI for end user
to change WLAN/BT/3G on/off state.

So, Acer wmi method have this function to provide the userland
application can call it to disable the default EC behavior in wifi
hotkey. After disable the hotkey's default behavior, it will only send
out wmi event when user press wifi key and doesn't touch any WLAN/BT/3G
state.

If Linux distro provide userland application the features like Acer
Launch Manager on Windows, then it can set the launch_manager to 1 to
change the wifi hotkey behavior.
Because the Launch Manager is userland application, so wmi driver only
can provide the function for it to call and don't have any way can
detect it from kernel module.

I thought it similar to disable rfkill_input by /dev/rfkill, the
different is disable rfkill_input need use ioctl, but I put a module
option in acer-wmi driver.


Thank's a lot!
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
