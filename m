From: Niels Skou Olsen <nolsen@jabra.com>
Subject: RE: [PATCH v2 0/4] Quirks cleanup and hid-generic niceness
Date: Wed, 25 Oct 2017 08:24:10 +0000
Message-ID: <VI1PR0701MB2991B256AEAD1B643B4A7527DA440@VI1PR0701MB2991.eurprd07.prod.outlook.com>
References: <20171003145729.3135-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Oct 4, 2017, nolsen@jabra.com wrote:

> On Oct 3, 2017, benjamin.tissoires@redhat.com wrote:
>
> > Niels found an issue with v1 of the series, while compiling the usbhid
> > module as a separate .ko.
> >
> > Sending a v2 with the proper From: field fixed now.
> >
>
> I have built it on for-next and tested it with no apparent issues. Also, =
I have
> Rebased/simplified my 2 pending patches on top of it, and will submit v2s=
 shortly.

Tested-by: Niels Skou Olsen <nolsen@jabra.com>

Sorry for pinging this. I know the patch is touching core HID, so the revie=
wer candidates are probably few.

Has anyone had time to look at this?

Thanks,
Niels
**** GN GROUP NOTICE - AUTOMATICALLY INSERTED**** The information in this e=
-mail (including attachments, if any) is considered confidential and is int=
ended only for the recipient(s) listed above. Any review, use, disclosure, =
distribution or copying of this e-mail is prohibited except by or on behalf=
 of the intended recipient. If you have received this email in error, pleas=
e notify me immediately by reply e-mail, delete this e-mail, and do not dis=
close its contents to anyone. Any opinions expressed in this e-mail are tho=
se of the individual and not necessarily the GN group. Thank you. *********=
*********** DISCLAIMER END ************************
