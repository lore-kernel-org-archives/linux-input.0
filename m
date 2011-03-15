From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH 2/2] hid-ntrig: calibration
Date: Tue, 15 Mar 2011 16:05:12 -0400
Message-ID: <1300219512.19767.11.camel@holly>
References: <1299829072-19489-1-git-send-email-rafi@seas.upenn.edu>
	 <1299829072-19489-2-git-send-email-rafi@seas.upenn.edu>
	 <4D79D3BD.9000204@seas.upenn.edu>
	  <alpine.LNX.2.00.1103151646120.19969@pobox.suse.cz>
Reply-To: Rafi Rubin <rafi@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fox.seas.upenn.edu ([158.130.68.12]:58197 "EHLO
	fox.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758048Ab1COUFi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Mar 2011 16:05:38 -0400
In-Reply-To: <alpine.LNX.2.00.1103151646120.19969@pobox.suse.cz>
Content-ID: <1300219511.19767.10.camel@holly>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: micki@n-trig.com, linux-input@vger.kernel.org


----- Original message -----
> On Fri, 11 Mar 2011, Rafi Rubin wrote:
>=20
> > On a related note, I looked into switching to usbhid_submit_report =
for
> > firmware version polling but it looks like the report offset (or
> > something like that) is wrong.
> >=20
> > I get:
> > af082500
> >=20
> > usbmon shows the devices sends:
> > 0c002508 afe10000
> >=20
> > If I change the report offset in the field to 8, I get the desired
> > bits: e1af0825
> >=20
> >=20
> > I don't really know much about parsing the hid descriptors, so I do=
n't
> > know why its off by a byte.=C2=A0  Perhaps its worth testing a diff=
erent
> > firmware to see if this is specific to my current firmware.
>=20
> I am not really sure I fully understand what you are saying here. Jus=
t
> for=C2=A0  clarification:
>=20
> - isn't the byte the 'report id' number here?
> - does your message mean that the patch doesn't work? Or is this quit=
e
> the=C2=A0  contrary -- explanation why it is written the way it is (i=
=2Ee. using=20
> usb_control_msg() instead of usbhid_submit_report())?

usbhid_submit_report does not work for calibration and firmware version=
 polling.

Sorry for the confusion.

Rafi
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
