From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: [linux-pm] "i8042: Can't reactivate AUX port" after s2ram on 3.4-rc2
Date: Sun, 15 Apr 2012 09:12:47 +0100
Message-ID: <CAAMvbhEFLHPsemALYVQwsuTaAiom1RviLECcPwqdtzA4ogmuLw@mail.gmail.com>
References: <1334310754.17013.YahooMailNeo@web161804.mail.bf1.yahoo.com>
	<201204132118.22074.rjw@sisk.pl>
	<1334346546.93033.YahooMailNeo@web161806.mail.bf1.yahoo.com>
	<201204132219.23106.rjw@sisk.pl>
	<1334350068.79333.YahooMailNeo@web161804.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:52928 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127Ab2DOIMs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 15 Apr 2012 04:12:48 -0400
In-Reply-To: <1334350068.79333.YahooMailNeo@web161804.mail.bf1.yahoo.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mikko Vinni <mmvinni@yahoo.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Bjorn Helgaas <bhelgaas@google.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Allen Kay <allen.m.kay@intel.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>

On 13 April 2012 21:47, Mikko Vinni <mmvinni@yahoo.com> wrote:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 firewire_ohci 0000:0a:00.0: Refused =
to change power state, currently in D3
> =C2=A0=C2=A0=C2=A0=C2=A0 10 firewire_ohci 0000:0a:00.0: restoring con=
fig space at offset 0xf (was 0xffffffff, writing 0x10a)
> =C2=A0=C2=A0=C2=A0=C2=A0 10 firewire_ohci 0000:0a:00.0: restoring con=
fig space at offset 0xe (was 0xffffffff, writing 0x0)
<snip>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 sdhci-pci 0000:0a:00.1: Refused to c=
hange power state, currently in D3
> =C2=A0=C2=A0=C2=A0=C2=A0 10 sdhci-pci 0000:0a:00.1: restoring config =
space at offset 0xf (was 0xffffffff, writing 0x10a)
> =C2=A0=C2=A0=C2=A0=C2=A0 10 sdhci-pci 0000:0a:00.1: restoring config =
space at offset 0xe (was 0xffffffff, writing 0x0)
<snip>

Could the problem be more due to "Refused to change power state,
currently in D3".
the "was 0xffffffff" would be returned if their was no power to the dev=
ice.
Don't you need power, before you can write to the config space?
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
