From: Yves-Alexis Perez <corsac@debian.org>
Subject: Re: [PATCH v2 0/7] New Lenovos 2015 touchpads: party time!
Date: Thu, 09 Apr 2015 14:59:41 +0200
Message-ID: <1428584381.10234.17.camel@debian.org>
References: <1423253075-23469-1-git-send-email-benjamin.tissoires@redhat.com>
	 <20150319142450.GA1641@balvenie>
	 <20150319144627.GA18134@mail.corp.redhat.com>
	 <20150319152526.GA3651@balvenie>
	 <20150319155830.GB18134@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150319155830.GB18134@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Hans de Goede <hdegoede@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On jeu., 2015-03-19 at 11:58 -0400, Benjamin Tissoires wrote:
> > 
> > Am I right? Thanks for the information, I'll also try to point our
> > kernel maintainers to that thread and ask them if it's possible to
> > backport them to the 3.16 kernel for Jessie.
> 
> Yes, please do. For the record, they are already in Fedora.

I've opened a Debian bug [1] to request the patch serie to be backported
to the 3.16 kernel used by Debian and Ubuntu, but Ben Hutchings asked
for more information than just the merge commit id.

The merge contains the following commits:

09d042a2eb90ee2c86d80c48ad096ae3f5776cef Revert "Input: synaptics - use dmax in input_mt_assign_slots"
6067fe5e0bf29f525561c8281d01011cfc9ebbd4 Merge branch 'synaptics' into for-linus
8f004f3f4daf5dc98dc78f8e62497ad834053855 Input: synaptics - remove X250 from the topbuttonpad list
860e6f7fcbe5653ec4e394f9ee335f2032398beb Input: synaptics - remove X1 Carbon 3rd gen from the topbuttonpad list
cdd9dc195916ef5644cfac079094c3c1d1616e4c Input: synaptics - re-route tracksticks buttons on the Lenovo 2015 series
3adde1f59195df2965f632e22b31f97fb371612f Input: synaptics - remove TOPBUTTONPAD property for Lenovos 2015
06aa374bc70468b517dd36b95c48c8f391c08a27 Input: synaptics - retrieve the extended capabilities in query $10
b57a7128be24062b5b5b26032b7cd58f1651547e Input: synaptics - do not retrieve the board id on old firmwares
ebc80840b850db72f7ae84fbcf77630ae5409629 Input: synaptics - handle spurious release of trackstick buttons
dc5465dc8a6d5cae8a0e1d8826bdcb2e4cb261ab Input: synaptics - fix middle button on Lenovo 2015 products
02e07492cdfae9c86e3bd21c0beec88dbcc1e9e8 Input: synaptics - skip quirks when post-2013 dimensions
5b3089ddb540401c1ad2e385a03d7e89ff954585 Input: synaptics - support min/max board id in min_max_pnpid_table
b05f4d1c332a22f98c037fa64f249aa30877adaf Input: synaptics - remove obsolete min/max quirk for X240
ac097930f0730a9b777737de2b51e0fc49d2be7a Input: synaptics - query min dimensions for fw v8.1
9aff65982d0f58a78a27769fba7e97bc937b2593 Input: synaptics - log queried and quirked dimension values
8b04baba10b007f8b6c245a50be73cf09cc3a414 Input: synaptics - split synaptics_resolution(), query first

Are they all needed or is there a more minimal but still working list?

Thanks for your work and regards.

[1]: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=780862
-- 
Yves-Alexis
