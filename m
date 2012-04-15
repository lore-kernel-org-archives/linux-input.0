From: Mikko Vinni <mmvinni@yahoo.com>
Subject: Re: [linux-pm] "i8042: Can't reactivate AUX port" after s2ram on 3.4-rc2
Date: Sun, 15 Apr 2012 03:47:07 -0700 (PDT)
Message-ID: <1334486827.79192.YahooMailNeo@web161806.mail.bf1.yahoo.com>
References: <1334310754.17013.YahooMailNeo@web161804.mail.bf1.yahoo.com> <201204132118.22074.rjw@sisk.pl> <1334346546.93033.YahooMailNeo@web161806.mail.bf1.yahoo.com> <201204132219.23106.rjw@sisk.pl> <1334350068.79333.YahooMailNeo@web161804.mail.bf1.yahoo.com> <CAAMvbhEFLHPsemALYVQwsuTaAiom1RviLECcPwqdtzA4ogmuLw@mail.gmail.com>
Reply-To: Mikko Vinni <mmvinni@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nm30.bullet.mail.bf1.yahoo.com ([98.139.212.189]:33292 "HELO
	nm30.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752964Ab2DOKrJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 15 Apr 2012 06:47:09 -0400
In-Reply-To: <CAAMvbhEFLHPsemALYVQwsuTaAiom1RviLECcPwqdtzA4ogmuLw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Bjorn Helgaas <bhelgaas@google.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Allen Kay <allen.m.kay@intel.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>

=46rom: James Courtier-Dutton:

>=20
> On 13 April 2012 21:47, Mikko Vinni <mmvinni@yahoo.com> wrote:
>>  =A0=A0=A0=A0=A0 1 firewire_ohci 0000:0a:00.0: Refused to change pow=
er state,=20
> currently in D3
>>  =A0=A0=A0=A0 10 firewire_ohci 0000:0a:00.0: restoring config space =
at offset 0xf=20
> (was 0xffffffff, writing 0x10a)
>>  =A0=A0=A0=A0 10 firewire_ohci 0000:0a:00.0: restoring config space =
at offset 0xe=20
> (was 0xffffffff, writing 0x0)
> <snip>
>>  =A0=A0=A0=A0=A0 1 sdhci-pci 0000:0a:00.1: Refused to change power s=
tate, currently in=20
> D3
>>  =A0=A0=A0=A0 10 sdhci-pci 0000:0a:00.1: restoring config space at o=
ffset 0xf (was=20
> 0xffffffff, writing 0x10a)
>>  =A0=A0=A0=A0 10 sdhci-pci 0000:0a:00.1: restoring config space at o=
ffset 0xe (was=20
> 0xffffffff, writing 0x0)
> <snip>
>=20
> Could the problem be more due to "Refused to change power state,
> currently in D3".
> the "was 0xffffffff" would be returned if their was no power to the=20
> device.
> Don't you need power, before you can write to the config space?
>

Those messages and the problem of the combo card reader and firewire
not working after s2ram has been present for long
(https://bugzilla.kernel.org/show_bug.cgi?id=3D35452
dmesg here: https://lkml.org/lkml/2011/5/15/55).

Before 3.4-rc1 there was nothing wrong with the touchpad (and keyboard
and reboot) after s2ram, and the problems are somehow separate.
Rafael's patch fixes the new problem, any suggestions for the old
one would be warmly appreciated.


Mikko
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
