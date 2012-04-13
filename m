From: Mikko Vinni <mmvinni@yahoo.com>
Subject: Re: [linux-pm] "i8042: Can't reactivate AUX port" after s2ram on 3.4-rc2
Date: Fri, 13 Apr 2012 12:49:06 -0700 (PDT)
Message-ID: <1334346546.93033.YahooMailNeo@web161806.mail.bf1.yahoo.com>
References: <1334310754.17013.YahooMailNeo@web161804.mail.bf1.yahoo.com> <201204132118.22074.rjw@sisk.pl>
Reply-To: Mikko Vinni <mmvinni@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nm27.bullet.mail.bf1.yahoo.com ([98.139.212.186]:32344 "HELO
	nm27.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756580Ab2DMTtI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Apr 2012 15:49:08 -0400
In-Reply-To: <201204132118.22074.rjw@sisk.pl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Allen Kay <allen.m.kay@intel.com>, Jean Guyader <jean.guyader@eu.citrix.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>

=46rom: Rafael J. Wysocki:

> On Friday, April 13, 2012, Mikko Vinni wrote:
>>  Bug report:
>> =A0 =A0 https://bugzilla.kernel.org/show_bug.cgi?id=3D43099
>>=20
>>  Briefly:
>>=20
>>  After s2ram the touchpad on a HP dv5 laptop doesn't work anymore.
>>=20
>>  dmesg contains this about the touchpad
>>  Apr 11 18:00:05 koni kernel: i8042: Can't write CTR while closing A=
UX=20
> port
>>  Apr 11 18:00:08 koni kernel: i8042: Can't reactivate AUX port
>>=20
>>=20
>>  Full log in bugzilla with PCI and i8042 debug turned on.
>>=20
>>  Bisected to:
>>=20
>>  commit 26f41062f28de65e11d3cf353e52d0be73442be1
>>  Author: Kay, Allen M <allen.m.kay@intel.com>
>>  Date:=A0  Thu Jan 26 10:25:53 2012 -0800
>>=20
>> =A0 =A0  PCI: check for pci bar restore completion and retry
>> =A0 =A0=20
>> =A0 =A0  On some OEM systems, pci_restore_state() is called while FL=
R has not=20
> yet
>> =A0 =A0  completed.=A0 As a result, PCI BAR register restore is not =
successful.=A0=20
> This fix
>> =A0 =A0  reads back the restored value and compares it with saved va=
lue and=20
> re-tries 10
>> =A0 =A0  times before giving up.
>=20
> Does reverting the above commit on top of the current Linus' tree fix=
 the
> problem for you?


It does (at least with the tree from yesterday, 4166fb64593514ad920b7db=
d290e0a934b37d24a).


Mikko

>=20
> Rafael
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
