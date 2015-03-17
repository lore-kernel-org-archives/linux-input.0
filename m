From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: [PATCH] Add a quirk for the Dell XPS 13 (2015) when in PS/2 mode.
Date: Mon, 16 Mar 2015 19:45:57 -0500
Message-ID: <55077945.3020804@dell.com>
References: <1424310180-2512-1-git-send-email-mario_limonciello@dell.com>	<201502202141.16017@pali>	<54EE1917.4020805@dell.com>	<201502252145.22577@pali>	<CAN+gG=EY-gyNKyEyfXw8hTDL8L4TR8OQLM2g+uLUUv_HM3mHWA@mail.gmail.com>	<5506E8D2.60207@dell.com>	<CAOFGe97na_mw-_AHJn6zyxVb-kDAxntjEgvXRcy6eg7uPfhQ8A@mail.gmail.com>	<550725D9.20805@dell.com>	<CAOFGe95VzKhvrFES9DHD4TB08XVd+pEMbDGVZ=fdAiDFLT9gVg@mail.gmail.com>	<5507422B.5000805@dell.com>	<CAOFGe94xt0i-if+SP3Y7EtQ+0TkW4i41SXV1g3RyRQZW+ssDDg@mail.gmail.com> <CAN+gG=Hg7u27PXryAt37+dgvwr4SHG9Bf_woNNxd7=nQVvZDAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAN+gG=Hg7u27PXryAt37+dgvwr4SHG9Bf_woNNxd7=nQVvZDAA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jason Ekstrand <jason@jlekstrand.net>
Cc: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Rob <robr.bensson@gmail.com>
List-Id: linux-input@vger.kernel.org


On 03/16/2015 04:07 PM, Benjamin Tissoires wrote:
> On Mon, Mar 16, 2015 at 4:57 PM, Jason Ekstrand <jason@jlekstrand.net> wrote:
> Yes, that's the gist of it.
> Mario, you might not have seen the problem because you are not running
> wayland and/or libinput. The xorg synaptics driver is much more
> relaxed concerning what it received from the kernel and I think it
> sets most of the time the right software button area if it sees only
> one button.
>
> Cheers,
> Benjamin
Ah thanks.  That explains why I haven't noticed it yet.
