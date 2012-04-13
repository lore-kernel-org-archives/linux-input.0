From: Mikko Vinni <mmvinni@yahoo.com>
Subject: "i8042: Can't reactivate AUX port" after s2ram on 3.4-rc2
Date: Fri, 13 Apr 2012 02:52:34 -0700 (PDT)
Message-ID: <1334310754.17013.YahooMailNeo@web161804.mail.bf1.yahoo.com>
Reply-To: Mikko Vinni <mmvinni@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Allen Kay <allen.m.kay@intel.com>, Jean Guyader <jean.guyader@eu.citrix.com>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-input@vger.kernel.org

Bug report:
=A0=A0=A0 https://bugzilla.kernel.org/show_bug.cgi?id=3D43099

Briefly:

After s2ram the touchpad on a HP dv5 laptop doesn't work anymore.

dmesg contains this about the touchpad
Apr 11 18:00:05 koni kernel: i8042: Can't write CTR while closing AUX port
Apr 11 18:00:08 koni kernel: i8042: Can't reactivate AUX port


Full log in bugzilla with PCI and i8042 debug turned on.

Bisected to:

commit 26f41062f28de65e11d3cf353e52d0be73442be1
Author: Kay, Allen M <allen.m.kay@intel.com>
Date:=A0=A0 Thu Jan 26 10:25:53 2012 -0800

=A0=A0=A0 PCI: check for pci bar restore completion and retry
=A0=A0=A0 =

=A0=A0=A0 On some OEM systems, pci_restore_state() is called while FLR has =
not yet
=A0=A0=A0 completed.=A0 As a result, PCI BAR register restore is not succes=
sful.=A0 This fix
=A0=A0=A0 reads back the restored value and compares it with saved value an=
d re-tries 10
=A0=A0=A0 times before giving up.


I will try to update the BIOS on this laptop next week, hoping that it might
fix some of the s2ram issues, but other than that, maybe somebody has an id=
ea?


Thanks,

Mikko
